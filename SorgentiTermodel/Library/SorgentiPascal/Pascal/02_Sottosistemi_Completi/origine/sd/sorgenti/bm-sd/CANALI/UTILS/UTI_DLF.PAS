unit Uti_dlf;

interface


uses
  SysUtils,Forms, StdCtrls,classes,ExtCtrls,grids,tabnotbk,controls,mc4edit;
type
  tcampigrid=array[1..30] of record
                                tipo:char;
                                L:integer;
                                Nome:string[10];
                             end;
  TMyform = class(TForm)
  private
    data:pointer;
    td:array[0..300] of record
                          t:tipi;
                          intera,decimale:integer;
                          ofset:word;
                          control:tcontrol;
                       end;
    { Private declarations }
    ctrlcount:integer;
  public
    procedure azzera(var dato;acontenitore:tobject;pagina:integer);
    PROCEDURE TRANSFER(INMASK:BOOLEAN);
    { Public declarations }
  end;

procedure Register;
implementation

procedure azzera1(note:ttabbednotebook;pagina:integer;pan:tpanel;form:tmyform);
var i,j:integer;
    ofsin:word;

begin
  j:=0;
  ofsin:=ofs(form.data^);
  if note<> nil then
  with (note.pages.objects[pagina] as twincontrol) do
  begin
    for i:=0 to controlcount-1 do
    if controls[i] is tmc4edit then
    begin
      with form.td[(controls[i] as tmc4edit).mc4_numero] do
      begin
        control:=controls[i];
        inc(form.ctrlcount);
        ofset:=ofsin;
        t:=(controls[i] as tmc4edit).mc4_tipo;
        case t of
        Reale
        :begin
            intera:=(controls[i] as tmc4edit).mc4_interi;
            decimale:=(controls[i] as tmc4edit).mc4_decimali;
            ofsin:=ofsin+6;
          end;
        Intero
        :begin
            ofsin:=ofsin+2;
          end;
        Stringa
        :begin
            intera:=(controls[i] as tmc4edit).mc4_interi;
            ofsin:=ofsin+intera+1;
          end;
        end;
      end;
     (controls[i] as tmc4edit).text:='';
    end
    else
    if controls[i] is tradiogroup then
    begin
      with form.td[(controls[i] as tradiogroup).taborder] do
      begin
        control:=controls[i];
        inc(form.ctrlcount);
        ofset:=ofsin;
        ofsin:=ofsin+2;
      end;
    end
    else
    if controls[i] is tcheckBox then
    begin
      with form.td[(controls[i] as tcheckbox).taborder] do
      begin
        control:=controls[i];
        inc(form.ctrlcount);
        ofset:=ofsin;
        ofsin:=ofsin+2;
      end;
    end
    else
    if controls[i] is tcomboBox then
    begin
      with form.td[(controls[i] as TComboBox).taborder] do
      begin
        control:=controls[i];
        inc(form.ctrlcount);
        ofset:=ofsin;
        if (controls[i] as TComboBox).text[1]='I' then
        begin
          t:=Intero;
          ofsin:=ofsin+2
        end
        else
        begin
          t:=Stringa;
          intera:=strtoint(copy((controls[i] as tcombobox).text,2,length((controls[i] as tcombobox).text)));
          ofsin:=ofsin+intera+1;
        end;
      end;
    end;
  end
  else
  with pan do
  begin
    for i:=0 to controlcount-1 do
    if controls[i] is tedit then
    begin
      with form.td[(controls[i] as tedit).taborder] do
      begin
        control:=controls[i];
        inc(form.ctrlcount);
        ofset:=ofsin;
        t:=(controls[i] as tmc4edit).mc4_tipo;
        case t of
        Reale
        :begin
           intera:=(controls[i] as tmc4edit).mc4_interi;
           decimale:=(controls[i] as tmc4edit).mc4_decimali;
           ofsin:=ofsin+6;
         end;
        Intero
        :begin
           ofsin:=ofsin+2;
         end;
        Stringa
        :begin
           intera:=(controls[i] as tmc4edit).mc4_interi;
           ofsin:=ofsin+intera+1;
         end;
        end;
      end;
     (controls[i] as tmc4edit).text:='';
    end
    else
    if controls[i] is tradiogroup then
    begin
      with form.td[(controls[i] as tradiogroup).taborder] do
      begin
        control:=controls[i];
        inc(form.ctrlcount);
        ofset:=ofsin;
        ofsin:=ofsin+2;
      end;
    end
    else
    if controls[i] is tcheckBox then
    begin
      with form.td[(controls[i] as tcheckbox).taborder] do
      begin
        control:=controls[i];
        inc(form.ctrlcount);
        ofset:=ofsin;
        ofsin:=ofsin+2;
      end;
    end
    else
    if controls[i] is tcomboBox then
    begin
      with form.td[(controls[i] as TComboBox).taborder] do
      begin
        control:=controls[i];
        inc(form.ctrlcount);
        ofset:=ofsin;
        if (controls[i] as TComboBox).text[1]='I' then
        begin
          t:=Intero;
          ofsin:=ofsin+2
        end
        else
        begin
          t:=Stringa;
          intera:=strtoint(copy((controls[i] as tcombobox).text,2,length((controls[i] as tcombobox).text)));
          ofsin:=ofsin+intera+1;
        end;
      end;
    end;
  end;
end;


procedure tmyform.azzera(var dato;acontenitore:tobject;pagina:integer);
var i,j:integer;
    ofsin:word;
begin
  data:=@Dato;
  
  ofsin:=ofs(data^);
  ctrlcount:=-1;
  if acontenitore=nil then
  begin
  for i:=0 to controlcount-1 do
  if controls[i] is tmc4edit then
  begin
    with td[(controls[i] as tmc4edit).mc4_numero] do
    begin
      control:=controls[i];
      inc(ctrlcount);
      ofset:=ofsin;
      t:=(controls[i] as tmc4edit).mc4_tipo;
      case t of
      Reale
      :begin
         intera:=(controls[i] as tmc4edit).mc4_interi;
         decimale:=(controls[i] as tmc4edit).mc4_decimali;
         ofsin:=ofsin+6;
       end;
      Intero
      :begin
         ofsin:=ofsin+2;
       end;
       Stringa
       :begin
          intera:=(controls[i] as tmc4edit).mc4_interi;
          ofsin:=ofsin+intera+1;
         end;
      end;
    end;
    (controls[i] as tmc4edit).text:='';
  end
  else
  if controls[i] is tradiogroup then
  begin
    with td[(controls[i] as tradiogroup).taborder] do
    begin
      control:=controls[i];
      inc(ctrlcount);
      ofset:=ofsin;
      ofsin:=ofsin+2;
    end;
  end
  else
  if controls[i] is tcheckBox then
  begin
    with td[(controls[i] as tcheckbox).taborder] do
    begin
      control:=controls[i];
      inc(ctrlcount);
      ofset:=ofsin;
      ofsin:=ofsin+2;
    end;
  end
  else
  if controls[i] is tcomboBox then
  begin
    with td[(controls[i] as TComboBox).taborder] do
    begin
      control:=controls[i];
      inc(ctrlcount);
      ofset:=ofsin;
      if (controls[i] as TComboBox).text[1]='I' then
      begin
        t:=Intero;
        ofsin:=ofsin+2
      end
      else
      begin
        t:=Stringa;
        intera:=strtoint(copy((controls[i] as tcombobox).text,2,length((controls[i] as tcombobox).text)));
        ofsin:=ofsin+intera+1;
      end;
    end;
  end;
  end
  else
  if acontenitore is ttabbednotebook then azzera1(ttabbednotebook(acontenitore),pagina,nil,self)
  else
  azzera1(nil,pagina,tpanel(acontenitore),self);
  transfer(true);
end;


procedure tmyform.transfer(inmask:boolean);
var i,v,j,int,dec:integer;
    s:string;
    segm:word;
    p:pointer;
    r:real;
    var realtemp:real;
      PInt :^integer;
      PStr :^string;
      PReal:^real;
      Pchar:^char;
      INDIRIZZO:LONGINT;
begin
  segm:=seg(data^);
  for i:=0 to ctrlcount do
  if td[i].control is tedit then
  begin
    WITH td[i] do
    begin
      case t of
      Reale
         :begin
            preal:=ptr(segm,ofset);
            if inmask then
            begin
              if preal^>0 then
              str(preal^:intera:decimale,s)
              else s:='';
             (control as tedit).text:=s;
            end
            else
            begin
              s:=(control as tedit).text;
              val(s,preal^,v);
              {offs:=offs+6;}
            end;
          end;

       Intero
         :begin
            pint:=ptr(segm,ofset);
            if inmask then
            begin
              if pint^>0 then
              str(pint^,s)
              else s:='';
             (control as tedit).text:=s;
            end
            else
            begin
              s:=(control as tedit).text;
              val(s,pint^,v);
              {offs:=offs+6;}
            end;
          end;

      Stringa
         :begin
            pstr:=ptr(segm,ofset);
            if inmask then (control as tedit).text:=pstr^
            else
            pstr^:=(control as tedit).text
          end;
      end;
    end;
  end
  else
  if td[i].control is TRadioGroup then
  begin
    WITH td[i] do
    begin

      pint:=ptr(segm,ofset);

      if inmask then
        (control as tradiogroup).itemindex:=pint^
      else
        pint^:=(control as tradiogroup).itemindex
    end;
  end
  else
  if td[i].control is TCheckBox then
  begin
    WITH td[i] do
    begin
      pint:=ptr(segm,ofset);

      if inmask then
        (control as tcheckbox).checked:=pint^>0
      else
        if (control as tcheckbox).checked then pint^:=1 else pint^:=0;
    end;
  end
  else
  if td[i].control is tcombobox then
  begin
    WITH td[i] do
    begin
      case t of
       Intero
         :begin
            pint:=ptr(segm,ofset);
            if inmask then
            begin
              if pint^>0 then
              (control as tcombobox).text:=(control as tcombobox).items[pint^]
              else
              (control as tcombobox).text:='Assente';
            end
            else
            begin
              pint^:=(control as tcombobox).ItemIndex;
              {offs:=offs+6;}
            end;
          end;

      Stringa
         :begin
            pstr:=ptr(segm,ofset);
            if inmask then (control as tcombobox).text:=pstr^
            else
            pstr^:=(control as tcombobox).text
          end;
      end;
    end;
  end;
end;

procedure Register;
begin
  RegisterComponents('Samples', [Tmyform]);
end;

end.


