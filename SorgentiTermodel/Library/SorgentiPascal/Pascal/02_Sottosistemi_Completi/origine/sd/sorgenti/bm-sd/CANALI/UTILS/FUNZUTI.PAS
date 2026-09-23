

{--------------------------------  SETLEFT  ----------------------------------}
FUNCTION SETLEFT(ST:STring):STring;
BEGIN
  WHILE (COPY(ST,1,1)=' ') AND (ST>'') DO ST:=COPY(ST,2,LENGTH(ST)-1);
  SETLEFT:=ST;
END;     { FUNC. SETLEFT }


{--------------------------------  SETright  ----------------------------------}
FUNCTION SETRIGHT(ST:STring):STring;
VAR
  I:INTEGER;
BEGIN
  I:=LENGTH(ST);
  while (I > 1) and (ST[i] = ' ') do i:=i-1;
  if i = 1 then
   begin
     if st[i] = ' ' then i:=0;
   end;

  if i = 0 then SetRight:=''
  else SETRIGHT:=COPY(ST,1,I);

END;     { FUNC. SETRIGHT }






 function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;


{----------------------------  FORMAT_STRING  --------------------------------}
FUNCTION FORMAT(ST:STring;StLength:INTEGER):STring;
BEGIN
  ST:=COPY(ST,1,StLength);
  FORMAT:=ST+COPY(Fill,1,StLength-LENGTH(ST));
END;      { FUNC.  FORMAT }

Function FormST(ST:STring):String;
begin
   St:=(SetLeft(SetRight(St)));
   FormSt:=UpString(St);
end;



 procedure WriteCampi(i:integer;NotZero:boolean);
  var
      Dato:LineStr;
      PInt :^integer;
      PStr :^st240;
      PReal:^real;
      PChar:^char;
  begin
     with Tabella^[I] do
      begin
         case Tipo of
          'I','i':
            begin
               PInt:=ptr(BAddr,OAddr);
               if notzero and (PInt^ = 0) then Dato:='  '
               else
                begin
                   str(PInt^:L,Dato);
                   Dato:=setleft(SetRight(Dato));
                end;
            end;
          'R','r':
            begin
               PReal:=ptr(BAddr,OAddr);
               if notzero and (PReal^ = 0) then Dato:='  '
               else
                begin
                   str(PReal^:L:CifreDec,Dato);
                   Dato:=setleft(SetRight(Dato));
                end;
            end;
          '$','s':
            begin
               PStr:=ptr(BAddr,OAddr);
               Dato:=PStr^;Dato:=setleft(SetRight(dato));
            end;
          'C','c':
            begin
               PChar:=ptr(BAddr,OAddr);
               Dato[1]:=PChar^;
            end;
          else Dato:='';
         end;
         gotoxy(x,y);write(format(Dato,L));
      end;

   textcolor(col[4]);
   textbackground(col[3]);

   for i:=1 to ninfo do
   with info^[i] do
   begin
     gotoxy(ix,iy);
     write(mess^[i])
   end;

  end;

 function Exist(Nome:st80):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;



 function AggiornaDato(Dato:linestr;I:integer):boolean;
  var flag1:integer;
      Error:boolean;
      DatoInit:linestr;
      PInt  : ^integer;
      PReal: ^real;
      PStr  : ^String;
      PChar : ^Char;
  begin
     DatoInit:=Dato;
     flag1:=0;Error:=false;
     with Tabella^[I] do
      begin
         case Tipo of
           'I','i':
             begin
                PInt:=ptr(BAddr,OAddr);
                Dato:=SetLeft(SetRight(Dato));
                if Dato = '' then Dato:='0';
                val(Dato,PInt^,flag1);
                PInt^:=PInt^*CtrlKey;
                Error:=(flag1 <> 0);
             end;
           'R','r':
             begin
                PReal:=ptr(BAddr,OAddr);
                Dato:=SetLeft(setright(Dato));
                if Dato = '' then Dato:='0';
                val(Dato,PReal^,flag1);
                PReal^:=PReal^*CtrlKey;
                Error:=(flag1 <> 0);
             end;
           '$','s':
             begin
                PStr:=ptr(BAddr,OAddr);
                PStr^:=Dato;
                if CtrlKey = 0 then PStr^:='';
             end;
           'C','c':
             begin
                PChar:=ptr(BAddr,OAddr);
                PChar^:=Dato[1];
                if CtrlKey = 0 then PChar^:=' ';
             end;
           else Dato:='';
         end;
      end;
      if Error then Dato:=DatoInit;
      AggiornaDato:=not(Error);
  end;

 procedure LeggiDato(var Dato:linestr;I:integer;NotZero:boolean);
 var
      PInt  : ^integer;
      PReal: ^real;
      PStr  : ^String;
      PChar : ^Char;
  begin
{   gotoxy(1,22); write(' Tabella^ Campo : ',i); delay(1000);}
     with Tabella^[I] do
      begin
         case Tipo of
           'I','i':
             begin
                PInt:=ptr(BAddr,OAddr);
                if (PInt^ = 0) and notzero then Dato:=''
                else str(PInt^:L,Dato);
                Dato:=SetLeft(SetRight(Dato));
             end;
           'R','r':
             begin
                PReal:=ptr(BAddr,OAddr);
                if (PReal^ = 0) and notzero then Dato:=''
                else str(PReal^:L:CifreDec,Dato);
                Dato:=SetLeft(SetRight(Dato));
             end;
           '$','s':
             begin
                PStr:=ptr(BAddr,OAddr);
                Dato:=SetLeft(SetRight(PStr^));
             end;
           'C','c':
             begin
                PChar:=ptr(BAddr,OAddr);
                Dato:=' ';
                Dato[1]:=PChar^;
             end;
           else Dato:='';
         end;
         Dato:=format(Dato,L);
      end;

  end;

procedure WriteMessage(Nome:st80;i:integer);
var f    : text;
    Riga : st80;
    k    : integer;
begin
   assign(f,Nome);
   reset(f);
   for k:=1 to i do readln(f,Riga);
   close(f);
   write(chr(7));
   textbackground(4);   textcolor(14);
   gotoxy(1,21);  write(Riga);
   textbackground(col[1]);   textcolor(col[2]);   ClrEol;
   delay(1200);
   gotoxy(1,21);     ClrEol;
end;