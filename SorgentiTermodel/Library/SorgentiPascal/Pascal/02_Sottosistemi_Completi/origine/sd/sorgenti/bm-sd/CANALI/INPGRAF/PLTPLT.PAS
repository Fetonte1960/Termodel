if exist(Driveplt+NomePianta+'.plt') then
    begin
      assign(ft,DrivePlt+NomePianta+'.plt');
      reset(ft);
      alzata:=true;
      st1:='';
      st2:='';
      while not eof(ft) do
      begin
        read(ft,ch);
        if a0 then
        begin
        case ch of
        'U':alzata:=true;
        'D':alzata:=false;
        'A':begin
                     repeat
                      read(ft,ch);
                      if ch<>','then st1:=st1+ch;
                     until ch=',';
                     repeat
                       read(ft,ch);
                       if ch <>';' then st2:=st2+ch;
                     until (ch=';') or (eoln(ft));

                     val(st1,xt,v);
                     val(st2,yt,v);
                     st1:='';
                     st2:='';

                     if alzata then
                     begin
                       if (xt <> 0)and(yt <> 0) then
                       begin
                         xt:=xt*fs;
                         yt:=yt*fs;
                       end;
                       write(f,u,a,round(xt),',',round(yt),';');
                     end
                     else
                     begin
                       if (xt <> 0)and(yt <> 0) then
                       begin
                         xt:=xt*fs;
                         yt:=yt*fs;
                       end;
                       write(f,d,a,round(xt),',',round(yt),';');
                     end;


                   end;
                end;
              end
              else
              begin
                case ch of
               'U':alzata:=true;

               'D':alzata:=false;

               'A':begin
                     repeat
                      read(ft,ch);
                      if ch<>','then st1:=st1+ch;
                     until ch=',';
                     repeat
                       read(ft,ch);
                       if ch <>';' then st2:=st2+ch;
                     until (ch=';') or (eoln(ft));

                     val(st1,xt,v);
                     val(st2,yt,v);
                     st1:='';
                     st2:='';

                     if alzata then
                     begin
                       if (xt <> 0)and(yt <> 0) then
                       begin
                         xt:=(xt+22717)*fs;
                         yt:=(yt+17937)*fs;
                       end;
                       write(f,u,a,round(xt),',',round(yt),';');
                     end
                     else
                     begin
                       if (xt <> 0)and(yt <> 0) then
                       begin
                         xt:=(xt+22717)*fs;
                         yt:=(yt+17937)*fs;
                       end;
                       write(f,d,a,round(xt),',',round(yt),';');
                     end;


                   end;
                end;
              end;
            end;
            close(ft);
          end;
