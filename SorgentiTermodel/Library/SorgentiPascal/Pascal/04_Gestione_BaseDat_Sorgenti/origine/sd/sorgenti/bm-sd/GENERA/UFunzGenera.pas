unit UFunzGenera;

interface
uses SysUtils,Dialogs;

Type tipoFile=(FOut,Ftype,Fdatain,Fdataout,FdataLink,FProcLink,Fnewpun,Fdisppun,
               Fcompila,Fcreadb,FIodati,Fltutti,FStutti,freport,fcombo,Fini,FOpen,
               Fsave,FNuovo,FForm,Fconferma,FControlla,FiniMem,FCaseTab,FCampoDb);

Var  salvadb:boolean;
     Basedati,ffout:textfile;

    elfile:array[0..100]of Textfile;

Procedure Write_ln(ff:tipofile;ss:string);
Procedure FAssignFile(ff:TipoFile;Path:string);
Procedure FRewrite(ff:TipoFile);
Procedure FWriteln(ff:TipoFile;ss:string);
Procedure FClosefile(ff:TipoFile);

implementation
Procedure FWriteln(ff:TipoFile;ss:string);
begin
writeln(elfile[integer(ff)],ss);
end;
Procedure FAssignFile(ff:TipoFile;Path:string);
begin
assignFile(elfile[integer(ff)],Path);
end;
Procedure FRewrite(ff:TipoFile);
begin
  try
  Rewrite(elfile[integer(ff)]);
  except
  showmessage('Il file '+inttostr(integer(ff))+' non è aperto');
  end;
end;
Procedure FClosefile(ff:TipoFile);
begin
Closefile(elfile[integer(ff)]);
end;
Procedure Write_ln(ff:tipofile;ss:string);
Var i:integer;
begin
if (salvadb) or (ff in[Ftype,FnewPun,FDispPun]) then
writeln(elfile[integer(ff)],ss);
end;

end.
