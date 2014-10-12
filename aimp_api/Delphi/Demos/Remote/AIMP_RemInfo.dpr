program AIMP_RemInfo;

uses
  Forms,
  AIMPSDKCore in '..\..\AIMPSDKCore.pas',
  AIMPSDKCommon in '..\..\AIMPSDKCommon.pas',
  AIMPSDKRemote in '..\..\AIMPSDKRemote.pas',
  AIMP_RemInfoUnit in 'AIMP_RemInfoUnit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
