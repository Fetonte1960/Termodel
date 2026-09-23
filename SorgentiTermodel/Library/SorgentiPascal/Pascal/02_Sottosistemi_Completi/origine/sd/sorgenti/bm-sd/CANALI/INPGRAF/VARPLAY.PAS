type tiponastro=record
                  mouse   :boolean;
                  tempo   :real;
           pdes,psin,pcen :boolean;
                  car     :char;
                  x,y     :real;

                 end;
var  nastro:tiponastro;
    fnastro:file of tiponastro;
    timeiniz:real;
    NumStep:integer;
    F_T:File of integer;
    play,Composto,rec:boolean;
    Demo_Drive:String;