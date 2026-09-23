{$P-}
(****************************************************************************
*
* SKBPWF.PAS
*
* $Header:
*
* Description - SentinelScribe Borland Delphi for Windows unit implementation
*               using SKBPWF.OBJ
*
* Revision Log
*
* $Log:   S:/scribe/windows/delphi/skbpwf.pav  $
 * 
 *    Rev 1.0   26 Jun 1995 11:01:28   BCHANG
 * Initial revision.
*
****************************************************************************)
Unit SKBPWF;

Interface

Function SK_COMMAND( VAR CmdStr : String; CmdLen : Word ) : Word;

Implementation

{$L SKBPWF.OBJ}                                 (* Far calls interface     *)
Function SK_COMMAND( VAR CmdStr : String; CmdLen : Word ) : WORD ; EXTERNAL ;

end.
