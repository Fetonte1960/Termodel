Type
      RecRiduz = record
                    CodRidR:string[5];
                    LungRidR,AngRidR:real;
                    CodRidC:string[5];
                    LungRidC,AngRidC:real;
                    CodAllR:string[5];
                    LungAllR,AngAllR:real;
                    CodAllC:string[5];
                    LungAllC,AngAllC:real;
                    CodTrasRC:string[5];
                    LungTrasRC:real;
                    CodTrasCR:string[5];
                    LungTrasCR:real;
                    CodRotR:string[5];
                    LungRotR:real;
                    RagCurv,RagStac,RagTee:real;
                 end;

  VAR
    Riduz : ^RecRiduz;
    Frid  :file of RecRiduz;