(****************************************************************************
* 
* SKEVAL.PAS 
*
* $Header:   S:/scribe/windows/tpaswin/skeval.pas   1.2   27 Nov 1991 11:07:12   BGROVE  $
*
* Description - SentinelScribe Turbo Pascal for Windows evaluation program.
*
* Revision Log
*
* $Log:   S:/scribe/windows/tpaswin/skeval.pas  $
* 
*    Rev 1.2   27 Nov 1991 11:07:12   BGROVE
* Fixed a syntax error for non DLL code.
*
*    Rev 1.1   27 Nov 1991 10:18:12   BGROVE
* Scribe eval for turbopascal for windows.
* 
****************************************************************************)

PROGRAM SKEVAL;

USES

{$IFDEF _MAKEDLL}
        SKWINDLL,                               (* SentinelScribe DLL Unit *)
        CRT;
{$ELSE}
        SKTPWF,                                 (* SentinelScribe driver   *)
        CRT;
{$ENDIF}

VAR
    Chars  : String;
    Result : Integer;
    Ok     : Boolean;

BEGIN

{$IFDEF _MAKEDLL}
        Ok := open_sent;                        (* Allocate task data for  *)
                                                (* DLL implementation      *)
{$ELSE}
        Ok := TRUE;
{$ENDIF}

If NOT Ok Then
begin
        CLRSCR;
        WriteLn('No more task handles available.');
end
else
begin
	CLRSCR;
	WRITELN( 'Rainbow Technologies SentinelScribe Evaluation Program.');
	WRITELN;

        Chars :='I/1/10';
        Result:=SK_COMMAND(Chars,length(Chars));

        Chars :='E/suSkpjqjzedZzVqE';
        Result:=SK_COMMAND(Chars,length(Chars));
        Chars :='E/bWfBlsacCaaadccL';
        Result:=SK_COMMAND(Chars,length(Chars));

	Chars := 'V/';
	Result := SK_COMMAND(Chars, Length(Chars));
	WRITELN('SentinelScribe Software Version => ',(Result DIV 256), '.', (Result MOD 256) );
	WRITELN;


	REPEAT
    		WRITELN;
    		WRITE( 'Input String: ' );
    		READLN( Chars );
    		IF length( Chars ) > 0 THEN
    		begin
    			result := SK_COMMAND( Chars, Length(Chars) );
        		WRITELN( 'Result = ', result:4 );
    		end;
	UNTIL length( Chars ) = 0;
        WriteLn('Done');

{$IFDEF _MAKEDLL}
        Ok := close_sent;                       (* De-allocate task data   *)
                                                (* for DLL implementation  *)
{$ENDIF}
end;

END.

