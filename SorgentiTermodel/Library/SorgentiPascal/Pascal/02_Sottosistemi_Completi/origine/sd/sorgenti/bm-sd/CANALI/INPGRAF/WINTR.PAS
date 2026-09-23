{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit WinTr;

INTERFACE

uses Printer,crt,definiz,globfunz,GenProc,halotp4,graph,angoli,verifica,WM,osnap;




Type T_Load_tronco=
object
    origine,fine,trovato,recvuoto,STImp,primavolta,coder,inpnum:boolean;
    ires,prec,TrCorr,trsel,TPN,errore:integer;
    Usc:stacchi;
    St_Dist,ER_MES:string;
    dist_temp:real;
Procedure Proc;
end;

Var Load_tronco:T_load_tronco;

{---------------------------------------------------------------------------}
implementation


{***************************  Val_str     *****************************}

Function Val_str(var Nx,Ny:real;xpr,ypr:real;rigacom:string):Boolean;

var Num:string;
    ang,angar:real;
    lung:real;
    i:integer;
    errore:integer;
begin

if trattosel<>0 then {-- trattosel in sezione --}
  with Dis^[Trattosel]^ do
  if (xg(x2,y2)=xg(x1,y1))and(yg(y2,z2)=yg(y1,z1)) then trattosel:=0;

if trattosel<>0 then
  begin
  with dis^[trattosel]^ do
    if yg(y2,z2)=yg(y1,z1) then
      begin
      if xg(x2,y2)>=xg(x1,y1) then angar:=pi/2 else angar:=(3/2)*pi;
      end
    else
      begin
      if yg(y2,z2)>yg(y1,z1) then
        begin
        angar:=arctan((xg(x2,y2)-xg(x1,y1))/abs(yg(y2,z2)-yg(y1,z1)));
        end
      else
      angar:=(pi-arctan((xg(x2,y2)-xg(x1,y1))/abs(yg(y2,z2)-yg(y1,z1))));
      end;
  end
else angar:=0;


Nx:=0;
Ny:=0;
Val_str:=false;
Num:='';
i:=1;
while (i<length(rigacom))and
      (rigacom[i]<>';')  and
      (rigacom[i]<>',')  and
      (rigacom[i]<>' ')  Do
  begin
  Num:=Num+rigacom[i];
  i:=i+1;
  end;
val(Num,ang,errore);
if errore=0 then
  begin
  if ((trattosel<>0)and(abs(trunc(ang)) IN [0,15,20,30,45,60,75,90]))or
     ((trattosel=0)and(abs(trunc(ang)) IN [0,90,180])) then
    begin
    Num:='';
    i:=i+1;
    while (i<=length(rigacom))and
          (rigacom[i]<>' ')   Do
      begin
      Num:=Num+rigacom[i];
      i:=i+1;
      end;
    val(Num,lung,errore);
    if (errore=0)and(lung>=0) then
      begin
      Val_str:=true;
      ang:=ang*PI/180+angar;
      lung:=lung*40000/conf.Altnum;
      if  not sezione then lung:=xg(lung,0)-xg(0,0)
      else lung:=yg(0,lung)-yg(0,0);
      Ny:=ypr+lung*cos(ang);
      Nx:=xpr+lung*sin(ang);
      end
    end
  end;

end;



{**************************** TRONCO *****************************************}

procedure T_Load_tronco.proc;
Var k:integer;
begin
coder:=false;
recvuoto:=vuoto;
fine    :=false;
retino  :=false;
x:=500;y:=350;
Prec    :=0;
TrCorr  :=0;
orglocator(@x,@y);

if recvuoto then  {-- Primo tronco introdotto --}

  begin
  origine:=true;
  if (c_Osnap)and(not sezione) then  {- osnap alla pianta -}
    begin
    richiesta('(Osnap punto medio)Selezionare una linea dal disegno');{*TR*}
    st1:='';
      REPEAT
      trovato:=false;
      readcord(x,y,cod,scelta,ST1,3);
      if cod=132 then
        begin
        x:=xe(x);
        y:=ye(x,y);
        trovato:=osn(x,y,0,0,0,0,9,st1);
        if not trovato then richiesta(st1);
        st1:='';
        x:=xg(x,y);
        y:=yg(y,0);
        end
      UNTIL (trovato)or(cod=130);
    delbox;
    end
  else
    begin
    richiesta(W_M(30)); {'Dal punto'}
    st1:='';
    readcord(x,y,cod,scelta,st1,11);
    end;
  Trattosel:=0;
  end

else            {-- Il tronco non e` il primo --}

  begin
  origine:=false;
  st1:='';
  richiesta(W_M(31)+':'); { '<Dal punto>/Spezza:' }
  st1:=W_M(31);

  {richiesta('<Dal punto>/Origine/Spezza:');
  st1:='<Dal punto>/Origine/Spezza:'}
  readcord(x,y,cod,scelta,st1,5)
  end;

if cod=130 then fine:=true

else

if st1<>'' then

  case upcase(st1[1]) of

 {'O':begin                     richiesta('');
      richiesta('Dal punto');
      origine:=true;
      st1:='';
      readcord(x,y,cod,scelta,st1,1);
      end;  }

{S}  CH20:begin            {-- Spezza --}

      if Selezlinea(Trattosel)=130 then fine:=true

      else

        begin
        xp:=xg(dis^[Trattosel]^.x1,dis^[Trattosel]^.y1);
        yp:=yg(dis^[Trattosel]^.y1,dis^[Trattosel]^.z1);
        {Tretino(x,y);}
        richiesta('');

        if (c_Osnap)and(not sezione) then  {- osnap alla pianta -}
          begin
          Calcdirez(trattosel,C_ang,Dist_temp);
          str(c_dist*conf.Altnum/40000:5:3,st_dist);

          st1:='(Osnap)Selezionare una linea del disegno/Distanza('+st_dist+')'; {*TR*}
          richiesta(st1+':');
            REPEAT
            trovato:=false;
            readcord(x,y,cod,scelta,ST1,3);
            if st1='' then
              begin
              if cod=132 then
                begin
                x:=xe(x);
                y:=ye(x,y);
                trovato:=osn(x,y,0,0,xe(xp),ye(xp,yp),8,st1);
                if not trovato then richiesta(st1);
                st1:='';
                x:=xg(x,y);
                y:=yg(y,0);
                end
              end
            else
              begin
              ST_DIST:=ST1;
              val(st_dist,dist_temp,errore);
              if errore=0 then C_dist:=Dist_temp*40000/Conf.AltNum
              else write(chr(7));
              str(c_dist*conf.Altnum/40000:5:3,st_dist);
              st1:='(Osnap)Selezionare una linea del disegno/Distanza('+st_dist+')'; {*TR*}
              richiesta(st1+':');
              end;
            until (cod=130)or(trovato);
          delbox;
          end
        else
          begin
          richiesta(W_M(32)); {'Selezionare punto');}
          st1:='';
          readcord(x,y,cod,scelta,st1,7);
          setcolor(7);
          isocur(x,y,2);
          richiesta('');
          end;



        Ver_spez(xe(x),ye(x,y),ze(y),Trattosel,Cod);

        if cod=132 then

          begin

          with dis^[nrighe]^ do

            begin
            entita:='L';
            color :=dis^[TrattoSel]^.color;
            tlinea:=dis^[TrattoSel]^.tlinea;
            x1    :=xe(x);
            y1    :=ye(x,y);
            z1    :=ze(y);
            x2    :=dis^[TrattoSel]^.x2;
            y2    :=dis^[TrattoSel]^.y2;
            z2    :=dis^[TrattoSel]^.z2;
            NLinea:=Dis^[TrattoSel]^.NLinea;
            Npezzo:=Dis^[TrattoSel]^.NPezzo;
            Rid   :=Dis^[TrattoSel]^.Rid;
            Tronco:=Dis^[TrattoSel]^.Tronco;
            flag:=true;
            end;

          with dis^[TrattoSel]^ do

            begin
            x2:=xe(x);
            y2:=ye(x,y);
            z2:=ze(y);
            Nlinea:=NRighe;
            Npezzo:=0;
            Rid:='';
            end;

          NRighe:=NewRiga;

          end

          else fine:=true;

        end;

      end;

  end;


delay(200);

if Not Fine then  {-- Confermato primo punto --}

  begin
  xp    :=x;
  yp    :=y;
  retino:=true;
  movabs(@x,@y);
  richiesta('');
  trsel:=trattosel;
  primavolta:=true;

    repeat

    if (c_Osnap)and(not sezione) then  {- osnap alla pianta -}
      begin
      str(c_dist*conf.Altnum/40000:5:3,st_dist);
        repeat

        st1:='(Osnap)Selezionare angolo/Distanza('+st_dist+')'; {*TR*}
        richiesta(st1+':');
        readcord(x,y,cod,scelta,ST1,2);
        errore:=0;
        if st1<>'' then
          begin
          ST_DIST:=ST1;
          val(st_dist,dist_temp,errore);
          if errore=0 then C_dist:=Dist_temp*40000/Conf.AltNum
          else write(chr(7));
          str(c_dist*conf.Altnum/40000:5:3,st_dist);
          end
        else
        if cod=132 then Calc_d(xp,yp,0,x,y,0,C_ang,Dist_temp);
        until (St1='');


      delln;
      setclip(@xw1,@yw1,@xw2,@yw2);
      setcolor(7);
      isocur(x,y,2);

      er_mes:='Selezionare una linea del disegno';{*TR*}
      if cod=132 then
        REPEAT

        st1:='';
        Richiesta(er_mes);
        readcord(x,y,cod,scelta,ST1,3);

        if cod=132 then
        begin
        x:=xe(x);
        y:=ye(x,y);
        trovato:=osn(x,y,0,0,xe(xp),ye(xp,yp),8,ER_MES);
        if not trovato then richiesta(er_mes);
        x:=xg(x,y);
        y:=yg(y,0);
        end;
        until (cod=130)or(trovato);
      delbox;
      end
    else
      repeat
      inpNum:=true;
      st1:=W_M(33); {'<Al punto/ang,lung>' }
      richiesta(W_M(33));
      readcord(x,y,cod,scelta,ST1,2);
      if (st1<>'') then
        begin
        inpnum:=Val_str(x,y,xp,yp,St1);
        if inpnum then cod:=132
        else write(chr(7));
        end;

      until inpnum;

    delln;
    setclip(@xw1,@yw1,@xw2,@yw2);
    setcolor(7);
    isocur(x,y,2);

    if (Cod=132)and(not(vuoto))and(primavolta) then
      begin


      for k:=1 to 5 do usc[k]:=0;
      usc[0]:=trsel;
      usc[6]:=0;
      with dis^[0]^ do

        begin
        entita:='L';
        x2    :=xe(x);
        y2    :=ye(x,y);
        z2    :=ze(y);
        x1    :=xE(xp);
        y1    :=ye(xp,yp);
        z1    :=ze(yp);
        end;


      Case TipoNodo(Trsel) of
        1:usc[1]:=dis^[trsel]^.NLinea;
        3:for k:=1 to 5 Do
          if dati^[dis^[trsel]^.tronco]^.pros[k]<>0 then
          usc[k]:=dati^[dati^[dis^[trsel]^.tronco]^.pros[k]]^.ti
          else Usc[k]:=0;
      end;



      if Not(st_ok(usc))then
        begin
        cod:=130;
        coder:=true;
        end

      end;

      primavolta:=false;

      case cod of

      132:begin               {-- Confermato secondo punto --}


          if TrCorr = 0 then

            begin


            if origine then

              begin
              RisultCalc.Origine:=NTronchi;
              Trcorr:=Ntronchi;
              InitRec(Ntronchi,1);
              Dati^[NTronchi]^.Ti:=NRighe;
              NTronchi:=newTr;
              end

            else TrCorr:=InsNodo(Trsel,NRighe,TipoNodo(Trsel),0);

            end

          else Dis^[Prec]^.NLinea:=NRighe;

          with dis^[nrighe]^ do     {-- Caricamento record grafico --}

            begin
            entita:='L';
            x2    :=xe(x);
            y2    :=ye(x,y);
            z2    :=ze(y);
            x1    :=xE(xp);
            y1    :=ye(xp,yp);
            z1    :=ze(yp);
            color :=conf.rcolore;
            tlinea:=conf.tlinea;
            tronco:=TrCorr;
            Nlinea:=0;
            nPezzo:=0;
            Rid:='';
            flag:=true;
            end;

            trattosel:=NRighe;
            MOVABS1(@XP,@YP);
            If Prec<>0 Then Dis^[Prec]^.Nlinea:=NRighe;
            Prec:=Nrighe;
            xp:=x;yp:=y;
            {delhcur;}
            setLcolor1(conf.rcolore);
            SetLnStyle(@conf.Tlinea);
            lnabs1(@x,@y);
            richiesta('');
            Nrighe:=NewRiga;
            if pienit then fine:=true;

          end
      end;
    until (cod=130)or(fine);

  end;


delay(300);
setcolor(7);
isocur(x,y,2);
setclip(@minxw,@minyw,@maxxw,@maxyw);
delln;
if not coder then richiesta('');
retino:=false;

end;



end.