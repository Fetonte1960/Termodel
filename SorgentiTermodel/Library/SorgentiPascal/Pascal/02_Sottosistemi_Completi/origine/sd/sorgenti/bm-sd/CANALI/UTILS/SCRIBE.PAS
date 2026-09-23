{$P-}
(****************************************************************************
* SCRIBE.PAS
*
* Description : SentinelSCRIBE API Functions Declarations Borland Delphi
*               for Windows Unit.
*
* (C) Copyright 1990-1996 Rainbow Technologies, Inc. All Rights Reserved.
****************************************************************************)
Unit SCRIBE;
Interface
Const
{Driver Error Codes}
SKCMD_SUCCESS               =  0    ;
SKCMD_SYS_API_ERR           =  -800 ; { System API Error occured               }
SKCMD_DRIVER_OPEN_ERR       =  -801 ; { Failed on opening sys drvr             }
SKCMD_DRIVER_COMM_ERR       =  -802 ; { comm fail with driver                  }
SKCMD_UNKNOWN_MACH          =  -803 ; { unkown machine type                    }
SKCMD_SIGNAL_NOT_SUPPORTED  =  -804 ; { BUSY line not supported                }
SKCMD_ACQUIRE_PORT_TIMEOUT  =  -805 ; { Acquire port time-out                  }
SKCMD_PORT_RELEASE_FAIL     =  -806 ; { Release the port failed                }
SKCMD_PORT_ALLOC_FAIL       =  -807 ; { the driver failed to allocate the port }
SKCMD_DRVR_IS_BUSY          =  -808 ; { the sys driver is busy                 }
SKCMD_IO_COMM_ERR           =  -809 ; { I/O comm err with key                  }
SKCMD_FAILED_ACCESS_PORT    =  -895 ;
SKCMD_PORT_IS_BUSY          =  -896 ;
SKCMD_CORRUPTED_DRVR        =  -897 ; { Data invalid                           }
SKCMD_PORT_NOT_FOUND        =  -899 ;
SKCMD_INVALID_REQUEST       =  -993 ; { requested command is invalid           }
SKCMD_NO_KEY_DETECTED       =  -994 ;
SKCMD_INVALID_PARAMETER     =  -995 ; { requested command has invalid parameter}
SKCMD_ACCESS_DENIED         =  -997 ; { requested command requires a higher
                                        permission level                 }
SKCMD_VERSION_NOT_SUPPORTED =  -998 ; { Update system driver                   }
SKCMD_DRVR_NOT_INSTALLED    =  -999 ; { system driver is not installed         }

{OS Driver types}
RB_DOSRM_LOCAL_DRVR   =  1 ;         { DOS Real Mode local driver }
RB_WIN3x_LOCAL_DRVR   =  2 ;         { Windows 3.x local driver   }
RB_WIN32s_LOCAL_DRVR  =  3 ;         { Win32s local driver        }
RB_WIN3x_SYS_DRVR     =  4 ;         { Windows 3.x system driver  }
RB_WINNT_SYS_DRVR     =  5 ;         { Windows NT system driver   }
RB_OS2_SYS_DRVR       =  6 ;         { OS/2 system driver         }
RB_WIN95_SYS_DRVR     =  7 ;         { Windows 95 system driver   }
RB_NW_LOCAL_DRVR      =  8 ;         { Netware local driver       }

{$IFDEF _DLL_ }
CloseMsg  = 'The SentinelSCRIBE DLL is closed' ;
OpenMsg = 'The SentinelSCRIBE DLL is open' ;

Function OPEN_SENT : Word; far;
Function CLOSE_SENT : Word; far;
{$ELSE}
Function GETTICKCOUNT : Word; far;   {Must be defined to link with SCRIBE.OBJ
                                                 but not used by SKEVAL.PAS}
{$ENDIF}

Function SK_COMMAND(CmdStr : Pointer;Size:Word) : Word; far;

Implementation
{$IFDEF _DLL_ }
Function OPEN_SENT  : Word; EXTERNAL 'SK16W' index 13;
Function SK_COMMAND(CmdStr : Pointer;Size:Word) : Word;
                            EXTERNAL 'SK16W' index 12;
Function CLOSE_SENT : Word; EXTERNAL 'SK16W' index 14;

{$ELSE}
{$L SCRIBE.OBJ}

{Function OPEN_SENT  : Word; EXTERNAL ;}
Function SK_COMMAND(CmdStr : Pointer;Size:Word) : Word;
                            EXTERNAL ;
Function GETTICKCOUNT : Word; EXTERNAL 'user.exe'; {Needed by SCRIBE.OBJ }
{Function CLOSE_SENT : Word; EXTERNAL ;  }
{$ENDIF}

end.

