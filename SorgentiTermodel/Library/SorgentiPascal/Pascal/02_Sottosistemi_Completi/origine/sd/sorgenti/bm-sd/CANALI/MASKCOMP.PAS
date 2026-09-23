unit MaskComp;
interface

Uses

    {$Ifdef dos}
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  {$endif}
  {$Ifdef Win}
  WinDos, {Unit found in TURBO.TPL}
  WinProcs,
  wintypes,
  strings,
  {$endif}
  Turbo3, {Unit found in TURBO3.TPU}
  utilitie,
  Defuti,
  inituti,
  WM,
  definiz;




procedure Computo(Prog:string;var Scelta:integer);

implementation


VAR
    progG:string;
    riga : INTEGER;
    filearchivio : STRING[40];
    ff : TEXT;
    InitMask,Errore : BOOLEAN;

    progcmt,Nprog : STRING[18];
    NomeArch:string;
    f:file of tarchivio;


  PROCEDURE scrittura_cmt;
    VAR f1 : FILE OF rec_inp;
      I : INTEGER;
    BEGIN
      ASSIGN(f1, drivearc+progcmt+'.cmt');
      REWRITE(f1);
      FOR I := 1 TO maxcmt DO WRITE(f1, mul^[I]);
      CLOSE(f1);
    END;



  PROCEDURE azzera_mul;
    VAR I : INTEGER;
    BEGIN
      FOR I := 1 TO maxcmt DO
        BEGIN
          mul^[I].tipo := '';
          mul^[I].lato_maggiore := 0;
          mul^[I].lung_max_tron := 0;
          mul^[I].lam_spessore := 0;
          mul^[I].lam_peso := 0;
          mul^[I].tipo_giunzio := '';
          mul^[I].cod_giu_tras := '';
          mul^[I].pes_giu_tras := 0;
          mul^[I].rin_int_num := 0;
          mul^[I].rin_int_tip := '';
          mul^[I].rin_int_pes := 0;
          mul^[i].bul_tipo := '';
          mul^[i].bul_passo := 0;
          mul^[i].bul_peso := 0;
        END;
    END;

 procedure w_computo;far;
 var pc:array[0..70] of char;
     ps:string[70];
     st:string;
     nt:integer;
     pc1:array[0..200] of char;
      buf:pchar;
 begin
   scrittura_cmt;
   if stampe_word then
   begin
     buf:=@pc1;
     getwindowtext(pmainwin^.hwindow,buf,200);
     assign(ftext,'wintxt.dat');
     rewrite(ftext);
     st:=strpas(buf);
     write(ftext,st);
     close(ftext);
     ps:=GET_drive+'\cca\w_commet.exe p1';
   end
   else
   ps:=GET_drive+'\cca\w_commet.exe';
   {$ifdef win}
   strpcopy(pc,ps);
   winexec(pc,sw_hide);
   {$endif}
 end;

  PROCEDURE lettura_maschera_input(var scelta,chiave:integer;prog:string);
    VAR Campo,I : INTEGER;
      f1 : FILE OF rec_inp;
      f10 : TEXT;
      Maskera:string;
      SI:STRING[1];

    BEGIN
      {.. identificazione del file .cmt da caricare ..}
      ASSIGN(f10, driveprog+'corren.mto');
      RESET(f10);
      READ(f10, progcmt);
      CLOSE(f10);

      IF Exist(drivearc+progcmt+'.cmt') THEN
        BEGIN
          AZZERA_MUL;
          { se esiste la tabella per quel progetto la devo leggere }
          ASSIGN(f1, drivearc+progcmt+'.cmt');
          RESET(f1);
          I:=0;
          WHILE NOT EOF(F1) DO
           BEGIN
              I:=I+1;
              READ(f1, mul^[I]);
           END;
          CLOSE(f1);
        END
      ELSE azzera_mul;
      InitMask := TRUE;
      Campo := 1;  Riga := 1;
      Chiave:=0;
      {$Ifdef dos}

      REPEAT
        Mess^[1]:=W_M(14)+' '+upstring(progcmt);  {' Scheda Tipologica :}

        M_IOTabella(Seg(mul^),Ofs(mul^),Maxcmt,10,14,Chiave,scelta,Riga,Campo,'Input.msk','pm',
                    false,InitMask,not InitMask,false,true);
        scrittura_cmt;

        if Chiave = 59 then
         begin
            assign(ff,'Comt.sce');
            rewrite(ff);
            write(ff,'***');
            close(ff);
            halt;
         end;
      UNTIL ((Chiave = 27) and (scelta<>72)) or (Chiave = 61);
     {$endif}
     {$Ifdef Win}
     Mess^[1]:=W_M(14)+' '+upstring(progcmt);  {' Scheda Tipologica :}
     initproc;
     procarr[1]:=w_computo;
     st_8:='Arkmto';
     a_w:=numerotabella(st_8,hd,2);
     W_IOTabella(mul^,Maxcmt,10,14,'Input.msk',false,procarr,true,code,fill_listagen,tabellacorrente^[a_w].self);
     if code=1 then scrittura_cmt;
     {$endif}
    END;

PROCEDURE SaveArch;
      BEGIN
        ASSIGN(f, NomeArch);
        REWRITE(f);
        WRITE(f, vprogmto^);
        CLOSE(f);
      END;

{$IFdef win}
procedure W_lettura;far;
var f10:text;
    hd:hwnd;
begin
  hd:=0;
  st_8:='ARKMTO';
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w].dialog^ do
  begin
  NProg := vprogmto^[Numerolineatabella].Nome;
  IF NProg > '' THEN
  BEGIN
    ASSIGN(f10, driveprog+'corren.mto');
    REWRITE(f10);
    WRITE(f10, nprog);
    CLOSE(f10);
    SaveArch;
    progG:=Nprog;
    lettura_maschera_input(scelta,chiave,progG);
    END
  ELSE messagebeep(10);
  end;
end;
{$endif}



  PROCEDURE ArchProg(var scelta:integer;prog:string);

    VAR i, Chiave, Campo : INTEGER;
      f10 : TEXT;
      InitMask : BOOLEAN;


    PROCEDURE LoadArch;
      VAR i : INTEGER;
      BEGIN
        IF Exist(NomeArch) THEN
          BEGIN
            ASSIGN(f, NomeArch);
            RESET(f);
            READ(f, vprogmto^);
            CLOSE(f);
          END
        ELSE
          BEGIN
            FOR i := 1 TO NProgetti DO
              WITH vprogmto^[i] DO
                BEGIN
                  Descr := '';
                  Nome := '';
                END;
          END;
      END;





    begin
      progG:=prog;
      NomeArch:=Driveprog+'mto.apg';
      campo:=1;
      LoadArch;
      posx:=0;
      posy:=0;
      tab_testo:=true;
      procarr[3]:=W_lettura;
      W_IOTabella(vprogmto^, NProgetti, 10, 2,'Arkmto.msk',false,procarr,true,code,fill_listagen,nil);
    END;


  procedure computo(Prog:string;var scelta:integer);

  BEGIN                       { main }


    Archprog(scelta,prog);

  END;
end.
