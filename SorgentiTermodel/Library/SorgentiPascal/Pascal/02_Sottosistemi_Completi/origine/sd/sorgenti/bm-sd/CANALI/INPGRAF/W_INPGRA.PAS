Program duct;
Uses owindows;
Type M_window=Object(TApplication)
              end;
M_pun=^M_window;
Var Main_Win:M_Pun;
begin
New(Main_win,init('Duct'));
Main_win^.Run;
Main_win^.Done;
end.