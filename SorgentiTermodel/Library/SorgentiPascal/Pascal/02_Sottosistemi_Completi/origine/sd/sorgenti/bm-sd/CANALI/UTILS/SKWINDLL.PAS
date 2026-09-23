(***************************************************************************
*
* SKWINDLL.PAS
*
* Description - This unit is for the SKWIN.DLL file. It defines the 
*               entry points for the DLL.
*
***************************************************************************)

unit SKWINDLL;

interface

function sk_command( VAR cmdstr : STRING; len : WORD ) : WORD;
function open_sent  : BOOLEAN;
function close_sent : BOOLEAN;

implementation

function sk_command; external 'SKWIN' index 1;
function open_sent;  external 'SKWIN' index 2;
function close_sent; external 'SKWIN' index 3;

end.