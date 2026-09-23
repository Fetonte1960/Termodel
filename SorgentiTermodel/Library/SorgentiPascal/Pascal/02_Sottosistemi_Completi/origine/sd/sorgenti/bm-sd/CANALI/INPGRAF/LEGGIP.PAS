13:{begin
               repeat
                 stpl:='';
                 stpl:=readcom('Nome disegno:',0);

                 if not exist(stpl+'.plt') then
                 begin
                   write(chr(7));
                   richiesta('');
                   richiesta('Nome disegno non valido !');
                   delay(1500);
                   richiesta('');
                 end;
               until (exist(stpl+'.plt'))or(stpl='');
               if stpl <> '' then
               begin
                 stpl:=stpl+'.plt';
                 leggiplotter(stpl);
               end;
               richiesta('');
               scelta:=0;
             end;