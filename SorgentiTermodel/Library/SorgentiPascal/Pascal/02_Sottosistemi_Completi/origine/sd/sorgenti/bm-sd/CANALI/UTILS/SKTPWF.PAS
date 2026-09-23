(****************************************************************************
*
* SKTPWF.PAS
*
* $Header:   S:/scribe/windows/tpaswin/sktpwf.pas   1.0   27 Nov 1991 10:17:08   BGROVE  $
*
* Description - SentinelScribe Turbo Pascal for Windows unit implementation
*               using SKTPWF.OBJ
*
* Revision Log
*
* $Log:   S:/scribe/windows/tpaswin/sktpwf.pas  $
*
*    Rev 1.0   27 Nov 1991 10:17:08   BGROVE
* Initial revision.
*
*
****************************************************************************)


Unit SKTPWF;

Interface

Function SK_COMMAND( VAR CmdStr : String; CmdLen : Word ) : Word;

Implementation
{$L \sorgenti\lavoro\utils\SKTPWF.OBJ}                                 (* Far calls interface     *)

Function SK_COMMAND( VAR CmdStr : String; CmdLen : Word ) : WORD; EXTERNAL ;


end.
