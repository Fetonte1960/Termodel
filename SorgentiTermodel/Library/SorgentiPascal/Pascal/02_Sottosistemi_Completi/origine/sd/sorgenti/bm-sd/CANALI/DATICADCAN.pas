type  Tipocan=Array[1..4] of string[5];
type recconf=record
             Rcolore   :integer;
             Tlinea   :integer;
             Rsnap    :real;
             griglia  :real;
             altnum   :integer;  {-- Scala --}
             ManRip   :String[1];
             CircRet  :String[1];
             Curve    :TipoCan;
             Br90     :array[1..3] of record
                                        RapLung:real;
                                        CodCan :TipoCan;
                                      end;
             BrD90     :array[1..3] of record
                                        RapLung:real;
                                        CodCan :TipoCan;
                                      end;
             Tee,Croce:TipoCan;

             BocVert  :record
                         TipoBoc:String[1];
                         CodBoc :TipoCan;
                       end;

             Bocoriz  :record
                         TipoBoc:String[1];
                         CodBoc :TipoCan;
                       end;
             end;



var conf:^recconf;
    fconf:file of recconf;
 fi     :file of cadrec;
// st1,stpl,Device             :string;

    UnMis:integer;
    F_Unmis:File of integer;
    NomeProg:string;
    grafica:boolean;
const
      NTabCan =2;

type
      VetDim=record
             Codpezzo,gruppo:integer;
             Entita:string[1];
             Piano:string[30];
             Tlinea,Colore:integer;
             X1,Y1,X2,Y2,Z1,Z2:real;
             R,R2:real;
             end;
     RecPezzo=record
                 entita:string[1];
                 TLinea:integer;
                 X1,Y1,X2,Y2,R,R1:real;
              end;
     e_DisPezzo=Array[1..30] of RecPezzo;
     e_DisPezzo1=Array[1..50]of RecPezzo;

var
    Vettore:^VetDim;
    FDim:file of VetDim;
    PianoCorDim:string[30];
    DisPezzo:^e_dispezzo;
    DisPezzo1:^e_dispezzo1;

    Sez_Dim   :Boolean;
    FDeb:Text;

const maxpar=9;
type Int3d=record
            Entita:string[1];
            codp:string[10];
            Indp:integer;
            Par:array[1..maxpar]of real;
           end;
const Maxp3d=50;
      Maxp3d1=70;
Var codpcor:string;
    Indpcor:Integer;
type
elpezzo3d=Array[1..Maxp3d] of Int3d;
elpezzo13d=Array[1..Maxp3d1]of Int3d;
var
DisPezzo3d:^elpezzo3d;
DisPezzo13d:^elpezzo13d;
DriveCCA:string;

CONST maxaggdis=20;

type DimDaDis = record
                 NProgettu   : string[8];
                 culuri      : integer;
                end;


eldimdadis=array[1..maxaggdis] of dimdadis;

Var VaiColDim:^eldimdaDis;
    NtrValid:integer;
