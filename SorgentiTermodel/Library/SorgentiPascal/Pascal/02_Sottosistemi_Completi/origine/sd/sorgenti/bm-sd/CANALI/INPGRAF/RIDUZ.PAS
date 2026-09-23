{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit Riduz;

INTERFACE

uses definiz,globfunz,genproc,HaloTp4,WM,diseg,controll;

Procedure Riduzione;

{---------------------------------------------------------------------------}
implementation


{***************************  Riduzioni              *******************************}

Procedure Riduzione;

var cod,scelta:integer;
    xp,yp:real;

begin

repeat
{I}st1:=readcom(W_M(53),CH33,0); {'Inserimento/Cancellazione/Annulla','I',0);}
st1:=upcase(st1[1]);
{I,C,A}until (st1[1]=CH33)or(st1[1]=CH34)or(st1[1]=CH3);

  case st1[1] of

{I}  CH33:begin

     if Selezlinea(Trattosel)<>130 then

       begin
       xp:=xg(dis^[Trattosel]^.x1,dis^[Trattosel]^.y1);
       yp:=yg(dis^[Trattosel]^.y1,dis^[Trattosel]^.z1);
       {Tretino(x,y,false);}
       richiesta('');
       richiesta(W_M(32)); {'Selezionare punto');}
       st1:='';
       readcord(x,y,cod,scelta,st1,7);
       isocur(x,y,2);
       richiesta('');

       Ver_spez(xe(x),ye(x,y),ze(y),Trattosel,Cod);

       if cod=132 then

         begin

         with dis^[nrighe]^ do

           begin
           entita:='L';
           color :=dis^[TrattoSel]^.color ;
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
           Rid:=ReadCom(W_M(54),'',0); { 'Codice pezzo' }
           DisRid(Trattosel,T_col(Color));
           end;
         InitRec(Dis^[trattosel]^.tronco,4);
         InitRec(Dis^[NRighe]^.tronco,4);
         NRighe:=NewRiga;

         end;

       end;

     end;

{C}  CH34:begin
      st1:='';
      richiesta(W_M(55)); {'<selezionare pezzo>:');}
      readcord(x,y,cod,scelta,st1,10);
      DelHCur;
      if cod<>130 then
        begin
        with dis^[trattosel]^ do
          begin
          DisRid(trattosel,0);
          rid:='';
          InitRec(Dis^[trattosel]^.tronco,4);
          end;
        end;
      end

  end;
richiesta('');
end;



end.