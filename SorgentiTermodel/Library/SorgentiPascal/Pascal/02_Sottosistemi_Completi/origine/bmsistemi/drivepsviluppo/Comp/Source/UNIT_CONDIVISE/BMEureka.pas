unit BMEureka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExceptionLog, StdCtrls;

const
  myRoot = '\SOFTWARE\BM Sistemi srl';

  MSG_Eureka_01 = 'Attenzione: Attraverso il tuo programma di posta sta per essere inviato un report sull''errore generato.' + #13 +
                  'Confermi l''invio di tale report?';

  MSG_Eureka_02 = 'Attenzione: Non è stato possibile inviare il report attraverso la posta elettronica.' +
                  'Se l''errore persiste contatta direttamente la BM Sistemi srl (www.bmsistemi.com \ info@bmsistemi.com \ +39 0932 763691)';

  MSG_Eureka_03 = 'Attenzione: è avvenuto un errore in %s.' + #13 +
                  'Vuoi inviare una segnalazione di errore a BM Sistemi srl?';

  MSG_Eureka_04 = 'Attenzione: Il programma, a seguito del precedente errore, potrebbe essere diventato instabile.' + #13 +
                  'Vuoi terminare di forza %s?';


type
  TFormEureka = class(TForm)
    LabelInfo: TLabel;
    Label1: TLabel;
    MemoErr: TMemo;
    Label2: TLabel;

    procedure EurekaLogExceptionActionNotify(EurekaExceptionRecord: TEurekaExceptionRecord; EurekaAction: TEurekaActionType; var Execute: Boolean);
    procedure EurekaLogExceptionErrorNotify(EurekaExceptionRecord: TEurekaExceptionRecord; EurekaAction: TEurekaActionType; var Retry: Boolean);
    procedure EurekaLogExceptionNotify(EurekaExceptionRecord: TEurekaExceptionRecord; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);

  private
   { Private declarations }
   F_InvioErrore: Boolean;                                                      // Mantiene informazioni sulla richiesta di invio errore

   function LeggiValoriRegistro(const Chiave: String): String;                                        // Ritorna informazioni sul registro
  public
    { Public declarations }

    function AddInfo(const S: String): Boolean;
  end;

var
  FormEureka: TFormEureka;

implementation

Uses Registry, ECore;

{$R *.dfm}

{****************************************************************************
 *********** EUREKA LOG *****************************************************
 ***********
}

{-----------------------------------------------------------------------------
  Procedure: TFormEureka.AddInfo
  Author:    Giovanni
  Date:      29-set-2004
  Arguments: const S: String
  Result:    Boolean

  Questa funzione imposta un'informazione aggiuntiva per il log di errore
-----------------------------------------------------------------------------}
function TFormEureka.AddInfo(const S: String): Boolean;
begin
     MemoErr.Lines.Clear;
     MemoErr.Lines.Add(S);
end;

procedure TFormEureka.EurekaLogExceptionActionNotify(EurekaExceptionRecord: TEurekaExceptionRecord; EurekaAction: TEurekaActionType; var Execute: Boolean);
Var
   i: Integer;
   S: String;
begin
     {
      atShowingExceptionInfo (before): call made before showing exception information.
      atShowedExceptionInfo  (after) : call made after showing exception information.
      atSavingLogFile        (before): call made before saving Log File.
      atSavedLogFile         (after) : call made after saving Log File.
      atSendingEmail         (before): call made before sending Email.
      atSentEmail            (after) : call made after sending Email.
      atTerminating
     }

     Case EurekaAction of
        atSendingEmail        : begin
                                     if F_InvioErrore then
                                          Execute := MessageDlg(MSG_Eureka_01, mtInformation, [mbYes, mbNo], 0) = mrYes
                                     else Execute := False;

                                     if Execute then
                                     begin
                                           EurekaExceptionRecord.CurrentModuleOptions.EMailSendOptions := esoEmailClient;
                                           EurekaExceptionRecord.CurrentModuleOptions.EMailAddresses   := 'bugs@bmsistemi.com';
                                           EurekaExceptionRecord.CurrentModuleOptions.EMailSubject     := 'BMEureka: Errore in ' + Application.Title;

                                           // Costruzione del messaggio
                                           S := 'Data Errore                  : ' + DateTimeToStr(now) + #13 +
                                                'Modulo                       : ' + Application.ExeName + #13 +
                                                '------------------------';

                                           // Aggiungo il registro
                                           LeggiValoriRegistro(myRoot);

                                           if MemoErr.Lines.Count > 0 then
                                           begin
                                               S := S + #13 + #13 + '___________________' + #13 + 'Informazioni Aggiuntive' + #13;
                                               for i := 0 to MemoErr.Lines.Count - 1 do
                                                 S := S + MemoErr.Lines[i] + #13;
                                           end;

                                           EurekaExceptionRecord.CurrentModuleOptions.EMailMessage     := S;
                                     end;
                                end;
     end; // case
end;

procedure TFormEureka.EurekaLogExceptionErrorNotify(EurekaExceptionRecord: TEurekaExceptionRecord;
                                                    EurekaAction: TEurekaActionType; var Retry: Boolean);
begin
    if EurekaAction = atSentEmail then
    begin
         MessageDlg(MSG_Eureka_02, mtError, [mbOk], 0);
         Retry := False
    end;
end;

procedure TFormEureka.EurekaLogExceptionNotify(EurekaExceptionRecord: TEurekaExceptionRecord; var Handled: Boolean);
begin
     F_InvioErrore := MessageDlg(format(MSG_Eureka_03, [Application.Title]), mtInformation, [mbYes, mbNo], 0) = mrYes;
     
     // Nel caso non si voglia inviare il messaggio allora chiedo se si vuole terminare in ogni caso il programma
     if not F_InvioErrore then
     begin
          if MessageDlg(format(MSG_Eureka_04, [Application.Title]), mtInformation, [mbYes, mbNo], 0) = mrYes then
                Halt(0);
     end;
end;


{-----------------------------------------------------------------------------
  Procedure: TFormEureka.FormCreate
  Author:    Giovanni
  Date:      29-set-2004
  Arguments: Sender: TObject
  Result:    None

  Pulizia del memo
-----------------------------------------------------------------------------}
procedure TFormEureka.FormCreate(Sender: TObject);
begin
     MemoErr.Clear;
end;

{-----------------------------------------------------------------------------
  Procedure: TFormEureka.LeggiValoriRegistro
  Author:    Giovanni
  Date:      29-set-2004
  Arguments: None
  Result:    String

  Questa funzione legge le informazioni presenti sul registro
-----------------------------------------------------------------------------}
function TFormEureka.LeggiValoriRegistro(const Chiave: String): String;
var
  Reg: TRegistry;
  Chiavi, Valori: TStringList;
  i: Integer;
begin
     Result := '';

     try
        Reg := TRegistry.Create;
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        Reg.OpenKeyReadOnly(Chiave);

        if Reg.HasSubKeys then
        begin
             Chiavi := TStringList.Create;

             Reg.GetKeyNames(Chiavi);

             if Chiavi.Count > 0 then
               for i := 0 to Chiavi.Count - 1 do
                    LeggiValoriRegistro(Chiave + '\' + Chiavi[i]);

             FreeAndNil(Chiavi);
        end else
        begin
             Valori := TStringList.Create;

             Reg.GetValueNames(Valori);

             MemoErr.Lines.Add(Format('---------', []));
             MemoErr.Lines.Add(Format('=> %s', [Chiave]));

             for i := 0 to Valori.Count - 1 do
                MemoErr.Lines.Add(Format('                %s = %s', [Valori[i], Reg.ReadString(Valori[i])]));

             FreeAndNil(Valori);

        end;

     finally
            if Assigned(Reg) then
               Reg.Free;
     end; // try
end;

{-----------------------------------------------------------------------------
  Procedure:
  Author:    Giovanni
  Date:      10-gen-2005
  Arguments: Not available
  Result:    Not available

  Cosa fa:
-----------------------------------------------------------------------------}
initialization
begin
   if Application <> nil then
        FormEureka := TFormEureka.Create(Application)
   else MessageDlg('Attenzione: Variabile Application non allocata, utilizzare le opzioni di progetto per attivare Eureka LOG', mtInformation, [mbOK], 0);
end;

finalization
begin
     //FreeAndNil(FormEureka);
end;



end.
