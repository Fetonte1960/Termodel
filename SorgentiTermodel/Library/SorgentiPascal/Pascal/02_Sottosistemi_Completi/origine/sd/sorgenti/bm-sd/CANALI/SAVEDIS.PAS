{************************** SAVEDIS*****************************************}

Procedure SaveDis(Nome:string);
var i:integer;

begin

{ assign(fi,Nome+'.ret');rewrite(fi);
 for i:=1 to nrighe do write(fi,dis^[i]);
 close(fi);}

 assign(fr,nome+'.dtr');rewrite(fr);
 for i:=1 to ntronchi do write(fr,dati^[i]);
 close(fr);

 assign(fgt,nome+'.ter');rewrite(fgt);
 for i:=1 to nGTerm do write(fgt,GTerm^[i]);
 close(fgt);

{ assign(fconf,Nome+'.con');
 rewrite(fconf);
 write(fconf,conf);
 lose(fconf);}

end;