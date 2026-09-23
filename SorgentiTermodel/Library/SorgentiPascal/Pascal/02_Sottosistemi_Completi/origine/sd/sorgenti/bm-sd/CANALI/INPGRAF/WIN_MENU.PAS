Unit Window_menu;

Interface

uses OWindows,odialogs,strings;

type
  pstatico=^tstatico;
  tstatico =object(tstatic)
  constructor initresource(Aparent:pwindowsobject;Aid:integer;atextlength:integer);
  function Transfer(DataPtr: Pointer; TransferFlag: Word): Word; virtual;
  end;


type win_menu=Object(TDlgwindow)
              Procedure Menu_com(opzione:integer);Virtual;
              Procedure M_101;Virtual cm_first+101;
              Procedure M_102;Virtual cm_first+102;
              Procedure M_103;Virtual cm_first+103;
              Procedure M_104;Virtual cm_first+104;
              Procedure M_105;Virtual cm_first+105;
              Procedure M_106;Virtual cm_first+106;
              Procedure M_107;Virtual cm_first+107;
              Procedure M_108;Virtual cm_first+108;
              Procedure M_109;Virtual cm_first+109;
              Procedure M_110;Virtual cm_first+110;
              Procedure M_111;Virtual cm_first+111;
              Procedure M_112;Virtual cm_first+112;
              Procedure M_113;Virtual cm_first+113;
              Procedure M_114;Virtual cm_first+114;
              Procedure M_115;Virtual cm_first+115;
              Procedure M_116;Virtual cm_first+116;
              Procedure M_117;Virtual cm_first+117;
              Procedure M_118;Virtual cm_first+118;
              Procedure M_119;Virtual cm_first+119;
              Procedure M_120;Virtual cm_first+120;
              Procedure M_121;Virtual cm_first+121;
              Procedure M_122;Virtual cm_first+122;
              Procedure M_123;Virtual cm_first+123;
              Procedure M_124;Virtual cm_first+124;
              Procedure M_125;Virtual cm_first+125;
              Procedure M_126;Virtual cm_first+126;
              Procedure M_127;Virtual cm_first+127;
              Procedure M_128;Virtual cm_first+128;
              Procedure M_129;Virtual cm_first+129;
              Procedure M_130;Virtual cm_first+130;
              Procedure M_131;Virtual cm_first+131;
              Procedure M_132;Virtual cm_first+132;
              end;


Implementation
Procedure Win_menu.Menu_com(opzione:integer);
begin
end;
Procedure Win_menu.M_101;
begin
Menu_com(101);
end;
Procedure Win_menu.M_102;
begin
Menu_com(102);
end;
Procedure Win_menu.M_103;
begin
Menu_com(103);
end;
Procedure Win_menu.M_104;
begin
Menu_com(104);
end;
Procedure Win_menu.M_105;
begin
Menu_com(105);
end;
Procedure Win_menu.M_106;
begin
Menu_com(106);
end;
Procedure Win_menu.M_107;
begin
Menu_com(107);
end;
Procedure Win_menu.M_108;
begin
Menu_com(108);
end;
Procedure Win_menu.M_109;
begin
Menu_com(109);
end;
Procedure Win_menu.M_110;
begin
Menu_com(110);
end;
Procedure Win_menu.M_111;
begin
Menu_com(111);
end;
Procedure Win_menu.M_112;
begin
Menu_com(112);
end;
Procedure Win_menu.M_113;
begin
Menu_com(113);
end;
Procedure Win_menu.M_114;
begin
Menu_com(114);
end;
Procedure Win_menu.M_115;
begin
Menu_com(115);
end;
Procedure Win_menu.M_116;
begin
Menu_com(116);
end;
Procedure Win_menu.M_117;
begin
Menu_com(117);
end;
Procedure Win_menu.M_118;
begin
Menu_com(118);
end;
Procedure Win_menu.M_119;
begin
Menu_com(119);
end;
Procedure Win_menu.M_120;
begin
Menu_com(120);
end;
Procedure Win_menu.M_121;
begin
Menu_com(121);
end;
Procedure Win_menu.M_122;
begin
Menu_com(122);
end;
Procedure Win_menu.M_123;
begin
Menu_com(123);
end;
Procedure Win_menu.M_124;
begin
Menu_com(124);
end;
Procedure Win_menu.M_125;
begin
Menu_com(125);
end;
Procedure Win_menu.M_126;
begin
Menu_com(126);
end;
Procedure Win_menu.M_127;
begin
Menu_com(127);
end;
Procedure Win_menu.M_128;
begin
Menu_com(128);
end;
Procedure Win_menu.M_129;
begin
Menu_com(129);
end;
Procedure Win_menu.M_130;
begin
Menu_com(130);
end;
Procedure Win_menu.M_131;
begin
Menu_com(131);
end;
Procedure Win_menu.M_132;
begin
Menu_com(132);
end;
constructor tstatico.initresource(Aparent:pwindowsobject;Aid:integer;atextlength:integer);
begin
  inherited Initresource(AParent, Aid,atextlength);
end;

function Tstatico.Transfer(DataPtr: Pointer; TransferFlag: Word): Word;
var
  ValCode: Integer;
  Testo:pchar{string};
begin
  case TransferFlag of
    tf_GetData:
      begin
        GetText(Testo, SizeOf(Text));
        string(DataPtr^):=strpas(Testo);
      end;
    tf_SetData:
      begin
        testo:=strPcopy('',string(dataPtr^));
        SetText(testo);
      end;
  end;
  Transfer := SizeOf(string);
end;
end.