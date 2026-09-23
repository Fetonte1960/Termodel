{************************************************}
{                                                }
{   Turbo Pascal for Windows                     }
{   Demo program                                 }
{   Copyright (c) 1991 by Microphar              }
{                                                }
{************************************************}

{ "Demo" Windows application written in Turbo Pascal }

unit mphkey;
{$F-}
{$R-}
{$L c:\mc4-l10\utils\CLE.obj}

interface
uses {$ifdef win}WinTypes, WinProcs, {$endif}Strings,winapi;


function Lecture(adresse:byte; var Valeur:LongInt):byte;
function Ecriture(Adresse:byte; Valeur:Word):Integer;
function EcritChaine(adresse:byte;valeur:Pchar):byte;
function LitChaine(adresse:byte; valeur:Pchar;taille:byte):byte;

implementation


procedure setup(selector:WORD);external;
procedure ecrit(selector:WORD);external;
function init:Word;external;
function peek_0(selector, offset:WORD):byte;external;
function is_mod_prot:word;external;




const
  idm_About = 100;
  IconId    = 110;
  ImageId   = 120;
  Code_C    = 5486  ;


var
  Residant     : Integer;
  vect_int     : word;
  buffer       : word;
procedure decrypt(selector:Word);

type byteptr  =^byte;
     intptr   =^word;
     ptr_byte = record
                 case boolean of
                   true:(p:byteptr);
                   false:(offset:word;segment:word)
                 end;
     ptr_int  = record
                 case boolean of
                   true:(p:intptr);
                   false:(offset:word;segment:word)
                 end;

var
   sg     :word;
   ofs    :word;
   fin    :word;
   q,i    :word;
   offset :word;
   cb1,cb2:byte;
   code_ch:byte;
   code_cl:byte;
   b      :ptr_byte;
   p      :ptr_int;
   c      :byte;

begin

    code_ch := Code_C div 256;
    code_cl := Code_C mod 256;

    setup(selector);


    offset  :=6 ; cb1 :=peek_0(selector, offset);
    offset  :=7 ; cb2 :=peek_0(selector, offset);
    vect_int:= cb1 + cb2 *256;

    p.segment :=selector  ;
    p.offset  :=4  + vect_int ; ofs    :=p.p^;
    p.offset  :=12 + vect_int ; fin    :=p.p^;
    p.offset  :=14 + vect_int ; buffer :=p.p^;

    b.segment :=selector ;
    b.offset  :=ofs;

    while b.offset <= fin do
     begin
       c        := b.p^ xor code_ch;
       b.p^     := c;
       b.offset := b.offset + 1;
       c        := b.p^ xor code_cl;
       b.p^     := c;
       b.offset := b.offset + 1;
      end
  
  End;

{
******************************************************************************
*  Function  to write a word at a location.                                  *
*     - Adresse has the value of the location where to write.                *
*     - The range of Adresse is beetwen 0 and 30.                            *
*     - Valeur is the value of the word to write.                            *
*     - In return you get:                                                   *
*         -0 If all is done well.                                            *
*         -1 If the writing hasn't been done.                                *
*         -2 If the location is out of range.                                *
*         -3 If the key is not present.                                      *
******************************************************************************
}
function Ecriture(Adresse:byte; Valeur:Word):Integer;

type byteptr=^byte;
     ptr_byte = record
                 case boolean of
                   true:(p:byteptr);
                   false:(offset:word;segment:word)
                 end;
var b       :ptr_byte;
    selector:word;
    offset  :word;
    c       :byte;

begin
    selector := Init;
    decrypt(selector);
{ -------------------------------------------------------------------------- }
    b.segment :=selector;
    b.offset  :=$46C           ;c:=b.p^;
    b.offset  :=4  + vect_int  ;b.p^:=c ;
    b.offset  :=5  + vect_int  ;b.p^:=1;
    b.offset  :=12 + vect_int  ;b.p^:=c xor adresse;

    b.offset  :=$46C        ;c:=b.p^;
    b.offset  :=6  + vect_int  ;b.p^:=c ;
    b.offset  :=13 + vect_int  ;b.p^:=c xor (valeur and 255);

    b.offset  :=$46C        ;c:=b.p^;
    b.offset  :=7  + vect_int  ;b.p^:=c ;
    b.offset  :=14 + vect_int  ;b.p^:=c xor (valeur shr 8);

    ecrit(selector);

    b.offset:=4 + vect_int;
    if is_mod_prot = 1 then
       {FreeSelector(selector)};
    ecriture:= b.p^;
end;


{
******************************************************************************
* Function  to read a word at a location.                                    *
*    - Adresse has the value of the location where to write.                 *
*    - The range of Adresse is beetwen 0 and 30.                             *
*    - The word is stored in Valeur.                                         *
*    - In return you get:                                                    *
*              -0 If all is done well.                                       *
*              -2 If the location is out of range.                           *
*              -3 If the key is not present.                                 *
******************************************************************************
}
function Lecture(adresse:byte; var Valeur:LongInt):byte;

type byteptr=^byte;
     ptr_byte = record
                 case boolean of
                   true:(p:byteptr);
                   false:(offset:word;segment:word)
                 end;

var b,p1,p2,q1,q2:ptr_byte;
    selector     :word;
    offset       :word;
    c            :byte;

begin
    selector := Init;
    decrypt(selector);

{ -------------------------------------------------------------------------- }
    b.segment :=selector;
    b.offset :=$46C           ;c:=b.p^;
    b.offset :=4  + vect_int  ;b.p^:=c ;
    b.offset :=5  + vect_int  ;b.p^:=2;
    b.offset :=12 + vect_int  ;b.p^:=c xor adresse;

    b.offset :=$46C          ;c:=b.p^;
    b.offset :=6  + vect_int ;b.p^:=c ;
    b.offset :=13 + vect_int ;b.p^:=c ;

    b.offset :=$46C           ;c:=b.p^;
    b.offset :=7  + vect_int  ;b.p^:=c ;
    b.offset :=14 + vect_int  ;b.p^:=c;

    ecrit(selector);

    p1.segment:=selector           ;p2.segment:=selector;
    q1.segment:=selector           ;q2.segment:= selector;
    p1.offset :=6 + vect_int   ;q1.offset :=13 + vect_int;
    p2.offset :=7 + vect_int   ;q2.offset :=14 + vect_int;

    valeur:=(p1.p^- q1.p^) + (p2.p^ - q2.p^)*256;

    b.offset  :=4 + vect_int;
    if is_mod_prot = 1 then
       {FreeSelector(selector)};
    lecture   :=b.p^;

end;


{
*******************************************************************************
* Function  to write an ascii string at a location.                           *
*    - "Adresse" has the value of the location where to write.                *
*    - The range of "Adresse" is beetwen 0 and 30.                            *
*    - "Valeur" contains the string to write.                                 *
*    - In return you get:                                                     *
*         -0 If all is done well.                                             *
*         -1 If the writing hasn't been done.                                 *
*         -2 If the location is out of range.                                 *
*         -3 If the key is not present.                                       *
*******************************************************************************
}
function EcritChaine(adresse:byte;valeur:Pchar):byte;

type byteptr=^byte;
     ptr_byte = record
                 case boolean of
                   true:(p:byteptr);
                   false:(offset:word;segment:word)
                 end;
var b:ptr_byte;
    taille, b0:byte;
    selector: word;
    offset  : word;
    i       : word;
    cb1, cb2: byte;

begin
    selector := init;
    decrypt(selector);
{ -------------------------------------------------------------------------- }

    taille := StrLen (valeur);
    if taille > 62 then taille := 62;

    b.segment :=selector;
    b.offset  :=$46C        ;b0:=b.p^;
    b.offset  := 4  + vect_int ;b.p^:=b0 ;
    b.offset  := 5  + vect_int ;b.p^:=5;
    b.offset  := 12 + vect_int ;b.p^:=b0 xor adresse;

    b.offset  :=$46C        ;b0  :=b.p^;
    b.offset  := 6  + vect_int ;b.p^:=b0 ;
    b.offset  := 13 + vect_int ;b.p^:=b0 xor taille;

    b.offset  :=$46C        ;b0  :=b.p^;
    b.offset  := 7  + vect_int ;b.p^:=b0 ;

    b.segment := selector;
    i         := 0;
    while i <= taille do
     begin
	 b.offset := buffer+i;
	 b.p^     := b0 xor ord(valeur[i+1]);
	 b.offset := b.offset + 1;
	 b.p^     := b0 xor ord(valeur[i]);
	 i        := i + 2;
	end;

    ecrit(selector);

    b.segment  :=selector;
    b.offset   :=4 + vect_int;
    StrCopy(valeur, ' ');
    if is_mod_prot = 1 then
       {FreeSelector(selector)};
    ecritchaine:=b.p^;
end;


{
*******************************************************************************
* Function  to read an ascii string at a location.                            *
*    - "Adresse" has the value of the location where to read.                 *
*    - The range of "Adresse" is beetwen 0 and 30.                            *
*    - "Taille" contains the number of caracteres you want to read.           *
*    - "Valeur" contains the string read.                                     *
*    - In return you get:                                                     *
*         -0 If all is done well.                                             *
*         -2 If the location is out of range.                                 *
*         -3 If the key is not present.                                       *
*******************************************************************************
}
function LitChaine(adresse:byte; valeur:Pchar;taille:byte):byte;

type byteptr=^byte;
     ptr_byte = record
                 case boolean of
                   true:(p:byteptr);
                   false:(offset:word;segment:word)
                 end;
var b       : ptr_byte;
    err, b0 : byte;
    selector: word;
    offset  : word;
    i       : word;
    c       : byte;

begin
    selector := init;
    decrypt(selector);
{ -------------------------------------------------------------------------- }

    b.segment :=selector;
    b.offset  :=$46C       ;b0:=b.p^;
    b.offset  :=4  + vect_int ;b.p^:=b0 ;
    b.offset  :=5  + vect_int ;b.p^:=6;
    b.offset  :=12 + vect_int ;b.p^:=b0 xor adresse;

    b.offset  :=$46C       ;b0  :=b.p^;
    b.offset  :=6  + vect_int ;b.p^:=b0 ;
    b.offset  :=13 + vect_int ;b.p^:=b0 xor taille;

    b.offset  :=$46C       ;b0  :=b.p^;
    b.offset  :=7  + vect_int ;b.p^:=b0 ;
    b.offset  :=14 + vect_int ;b.p^:=b0;

    ecrit(selector);

    b.offset  :=4 + vect_int;
    err       :=b.p^;

   if err = 0 then
 	begin
	 b.offset  := 7 + vect_int ; b0 := b.p^;
	 b.segment := selector;
	 i         := 0;
	 while i <= taille do
		begin
		b.offset    := buffer+i;
		valeur[i+1] := chr(b.p^ xor b0);
		b.offset    := b.offset + 1;
		valeur[i]   := chr(b.p^ xor b0);
		i           := i + 2;
		end;
	end
     else
		valeur      :='';
    if is_mod_prot = 1 then
      {FreeSelector(selector)};
    litchaine   := err;

end;



(*
procedure Display(Window:Hwnd);
var
   DC       : HDC;
   hMemoryDC: HDC;
   OldBitMap: TBitMap;

begin

  hMicroBitmap := LoadBitmap(HInstance, MakeIntResource(ImageId));
  DC  := GetDC(Window);
  hMemoryDC :=CreateCompatibleDC(DC);
  SelectObject(hMemoryDC, hMicroBitmap);
  GetObject(hMicroBitmap, Sizeof(OldBitMap), @OldBitMap);
  BitBlt(DC, 0,0, OldBitMap.bmWidth, OldBitMap.bmHeight, hMemoryDC, 0, 0, SRCCOPY);
  DeleteDC(hMemoryDC);
  ReleaseDC(Window, DC);
end;








procedure MakeWindow(Window:HWnd);
begin

  ImagePre := CreateWindow(
    'Button',
    nil,
    bs_ownerdraw or ws_child or ws_visible,
    50,
    10,
    190,
    240,
    Window,
    ImageId,
    HInstance,
    nil);

end;

function About(Dialog: HWnd; Message, WParam: Word;
  LParam: Longint): Bool; export;
begin
  About := True;
  case Message of
    wm_InitDialog:
      Exit;
    wm_Command:
      if WParam = id_Ok then
      begin
        EndDialog(Dialog, 1);
        Exit;
      end;
  end;
  About := False;
end;


procedure Wait(STime:LongInt);
var
   DebTime : LongInt;
begin
   DebTime := 0;
   while DebTime <= STime do
       DebTime := DebTime +1;
end;


function WindowProc(Window: HWnd; Message, WParam: Word;
  LParam: Longint): Longint; export;
var
  AboutProc: TFarProc;
  TItem    : TDrawItemStruct;
  DC       : HDC;
  PS       : TPaintStruct;
  Retour   : byte;
  Valeur   : LongInt;
  P        : Pchar;
  S        : array[0..127] of char;
  Len      : Byte;
  OLdHWnd  : HWnd;

begin
  WindowProc := 0;
  case Message of
    wm_Command:
      if WParam = idm_About then
      begin
        AboutProc := MakeProcInstance(@About, HInstance);
        DialogBox(HInstance, 'AboutBox', Window, AboutProc);
        FreeProcInstance(AboutProc);
        Exit;
      end;
   wm_Paint:
      begin
        DC := BeginPaint(Window, PS);

        {Ecriture d'une valeur}
        TextOut(DC, 1, 10, PCHAR('Writing value 12345 at location 28'), 34);
        P  :=@TexteRetour;
        Retour :=Ecriture(28, 12345);
        Str(Retour, TexteRetour);
        TextOut(DC, 350,  10, S, WVSPrintF(S, 'Writing Error  : %s', P));

        {Lecture d'une valeur}
        TextOut(DC, 1, 32, PCHAR('Reading value at location 28'), 28);
        P  :=@TexteRetour;
        Retour :=Lecture(28, Valeur);
        str(Valeur, TexteRetour);
        TextOut(DC, 1, 52, S, WVSPrintF(S, 'Reading value :%s',P));
        str(Retour, TexteRetour);
        TextOut(DC, 350,  52, S, WVSPrintF(S, 'Reading Error :%s',P));

        {Writing a string}
        TextOut(DC, 1, 72, Pchar('Writing a String in location 0 of Memory key '), 45);
        P  :=@TexteRetour;
        StrCopy(S, 'This is a Demonstration of Microphar Memory Key');
        Len := StrLen(S);
        Retour :=EcritChaine(0,S);
        Str(Retour, TexteRetour);
        TextOut(DC, 350,  72, S, WVSPrintF(S, 'Writing Error  : %s', P));

        {Reading a string}
        TextOut(DC, 1, 92, Pchar('Reading a String at Location 0'), 30);
        P  :=@TexteRetour;
        Retour :=LitChaine(0, S, Len);
        if Retour = 0 then
           TextOut(DC, 1, 112, S, Len);
        Str(Retour, TexteRetour);
        TextOut(DC, 350, 112, S, WVSPrintF(S, 'Reading Error : %s', P));

        TextOut(DC, 150, 190, Pchar('End of Demo'), 11);
        EndPaint(Window, PS);
      end;
    wm_Destroy:
      begin
        PostQuitMessage(0);
        Exit;
      end;
  end;
  WindowProc := DefWindowProc(Window, Message, WParam, LParam);
end;







procedure WinMain;
var
  Window   : HWnd;
  Message  : TMsg;
const
  WindowClass: TWndClass = (
    style: 0;
    lpfnWndProc: @WindowProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: 'SAMPLE';
    lpszClassName: AppName);

begin

  ImagePre := 0;
  Residant := 0;
  if HPrevInst = 0 then
  begin
    WindowClass.hInstance := HInstance;
    WindowClass.hIcon := LoadIcon(HInstance, MakeIntResource(IconId));
    WindowClass.hCursor := LoadCursor(HInstance, idc_Arrow);
    WindowClass.hbrBackground := GetStockObject(white_Brush);
    if not RegisterClass(WindowClass) then Halt(255);
  end;

  Window := CreateWindow(
    AppName,
    'Microphar Program Demonstration',
    ws_OverlappedWindow,
    20,
    20,
    500,
    300,
    0,
    0,
    HInstance,
    nil);

  ShowWindow(Window, CmdShow);
  UpdateWindow(Window);

  while GetMessage(Message, 0, 0, 0) do
  begin
    TranslateMessage(Message);
    DispatchMessage(Message);
  end;
  Halt(Message.wParam);
end;

begin
  WinMain;
*)
{$F+}
{$R+}
end.
