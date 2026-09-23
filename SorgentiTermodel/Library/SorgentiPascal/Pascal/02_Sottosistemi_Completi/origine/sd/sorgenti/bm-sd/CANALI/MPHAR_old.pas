{************************************************}
{                                                }
{   Borland Pascal 7.0 / protected mode          }
{   Demo program                                 }
{   Copyright (c) 1993 by Microphar              }
{   Compiling : BPC /CP PROG.PAS                 }
{************************************************}


unit MPHAR_old;
{$F-}
{$R-}

{* if you use Borland Pascal DPMI under Windows
   put this line into your source

 uses WinCrt;
 *}


{* if you use Borland Pascal DPMI under Dos
   put this following line in your source *}

interface

function Lecture(adresse:byte; var Valeur:LongInt):byte;
function Ecriture(Adresse:byte; Valeur:Word):Integer;

implementation
(*
{$L \sorgenti\lavoro\utils\CLE}
procedure setup(selector:WORD);external;
procedure ecrit(selector:WORD);external;
function init:Word;external;
function peek_0(selector, offset:WORD):byte;external;
procedure FreeSel(selector:word);external;



const
  Code_C    = 5486   ;

var
  vect_int     : word;
  buffer       : word;
  longueur     : byte;
  valu         : longint;
  valeur       : string;
  retour       : byte;
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
    ecriture:= b.p^;
    FreeSel(selector);
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
    a1,a2,a3,a4,a5 :real;
    f:text;
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

    a1:=p1.p^;
    a2:=q1.p^;
    a3:=p2.p^;
    a4:=q2.p^;

    a5:=(a1- a2) + (a3 - a4)*256;
    valeur:=trunc(a5);

{    valeur:=(p1.p^- q1.p^) + (p2.p^ - q2.p^)*256;}

 {   assign(f,'d:\mc4-l10\igro\deb.txt');
    rewrite(f);
    writeln(f,'adr  ',adresse);
    writeln(f,'1  ',p1.p^);
    writeln(f,'2  ',q1.p^);
    writeln(f,'3  ',p2.p^);
    writeln(f,'4  ',q2.p^);
    writeln(f,'valx  ',valeur);
    close(f);}

    b.offset  :=4 + vect_int;
    lecture   :=b.p^;
    FreeSel(selector);

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
function EcritChaine(adresse:byte;valeur:string):byte;

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

    taille := length (valeur);

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
    i         := 1;
    while i <= taille+1 do
     begin
	 b.offset := buffer+i-1;
	 b.p^     := b0 xor ord(valeur[i+1]);
	 b.offset := b.offset + 1;
	 b.p^     := b0 xor ord(valeur[i]);
	 i        := i + 2;
	end;

    ecrit(selector);

    b.segment  :=selector;
    b.offset   :=4 + vect_int;
    ecritchaine:=b.p^;
    FreeSel(selector);
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
function LitChaine(adresse:byte; taille:byte; var valeur:string):byte;

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
	 if taille > 62 then taille := 62;
	 i         := 62 - (adresse * 2);
	 if taille > i then taille := i;
	 valeur    := ' ';
	 for i:= 2 to taille do valeur := valeur + ' ';
	 b.offset  := 7 + vect_int ; b0 := b.p^;
	 b.segment := selector;
	 i         := 1;
	 while i <= taille+1 do
		begin
		b.offset    := buffer+i-1;
		valeur[i+1] := chr(b.p^ xor b0);
		b.offset    := b.offset + 1;
		valeur[i]   := chr(b.p^ xor b0);
		i           := i + 2;
		end;
	end
     else
		valeur      :='';

    litchaine   := err;
    FreeSel(selector);

end;

begin
(*
{
*******************************************************************************
* This example shows you how to write a value in address 28 of the memory .   *
*******************************************************************************
}
	writeln; writeln;
	valu := 12700;
	writeln ('Writing 12700 in location 28 of memory key');
	retour := ecriture(28,valu);
    	writeln ('Writing Error = ', retour);

{
*******************************************************************************
* This example shows you how to read a value in address 28 of the memory .    *
*******************************************************************************
}
	writeln; writeln;
	writeln ('Reading location 28 of memory key');
    	retour := lecture (28,valu);
    	writeln ('Value = ', valu,' Reading Error = ', retour);

{
*******************************************************************************
* This example shows you how to write a string in address 0 of the memory .   *
*******************************************************************************
}
	valeur := 'This is a demonstration of the MICROPHAR memory Key';
	writeln; writeln;
	writeln ('Writing a string in location 0 of memory key');
	retour := ecritchaine(0,valeur);
    	writeln ('Writing Error = ', retour);

{
*******************************************************************************
* Loop for demomstration.                                                     *
* This example shows you how to read a string in address 0 of the memory .    *
*******************************************************************************
}

	writeln; writeln;
	writeln ('Reading a string at location 0 of memory key');
	longueur := 51;
  repeat
    	retour := litchaine (0, longueur, valeur);
    	writeln ('String = ', valeur);
    	writeln (' Reading Error = ', retour);
   until KeyPressed



valu:=680;
retour := ecriture(6,valu);
 FOR I := 0 to 30 do
 begin
   retour:= lecture(i,valu);
   write(valu,' ');
 end;
 *)
{$F+}
{$R+}

end.



