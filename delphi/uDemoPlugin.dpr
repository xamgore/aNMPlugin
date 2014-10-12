library uDemoPlugin;

{$R *.res}

uses
  AIMPSDKCore in '..\..\AIMPSDKCore.pas',
  AIMPSDKAddons in '..\..\AIMPSDKAddons.pas',
  AIMPSDKCommon in '..\..\AIMPSDKCommon.pas',
  AIMPAddonCustomPlugin in '..\..\Helpers\AIMPAddonCustomPlugin.pas',
  uDemoPluginFrame in 'uDemoPluginFrame.pas' {DemoPluginForm};

{DemoPluginForm}

function AIMP_QueryAddon3(out AHeader: IAIMPAddonPlugin): LongBool; stdcall;
begin
  AHeader := TAIMPAddonDemoPlugin.Create;
  Result := True;
end;

exports
  AIMP_QueryAddon3;

begin
end.
