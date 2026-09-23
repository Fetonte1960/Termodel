program leggier;
uses crt,dos,utilitie;

type RecError=record
              Sottorete:string[8];
              terminale:string[8];
              tronco:integer;
              descr:string[50];
              end;

elerrore=array[1..100] of recerror;
var errore:elerrore;
    f:file of elerrore;
    initmenu:boolean;
    campo,chiave,riga:integer;
    initmask:boolean;
begin

assign(f,'errori.dat');
reset(f);
read(f,errore);
close(f);
ctrlkey:=1;
readcolor;
  ClrScr;
  InitMask:=true;
  InitMenu:=true;

  repeat
     IOTabella(Seg(errore),Ofs(errore),100,10,4,Chiave,{chiave1,}Riga,
                 'conerror.msk',{'pm',}true,InitMask,not InitMask);

     InitMask:=false;
     InitMenu:=false;

  until (chiave=27){and(chiave1<>23)};

end.