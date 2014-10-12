unit PlayingQueueHookUnit;

interface

uses
  Windows, AIMPSDKAddons, AIMPSDKHelpers, AIMPAddonCustomPlugin, AIMPSDKCore, AIMPSDKCommon;

type
  { TMyPlayerAsyncHook }

  TMyPlayerAsyncHook = class(TInterfacedObject, IAIMPAddonsPlayerAsyncHook)
  public
    // IAIMPAddonsPlayerAsyncHook
    function PreparingForRemoteTrackPlayback(ATrackURI: IAIMPString; var AHandled: LongBool): HRESULT; stdcall;
  end;

  { TAIMPPlayingQueueHookDemoPlugin }

  TAIMPPlayingQueueHookDemoPlugin = class(TAIMPAddonsCustomPlugin)
  private
    FPlayerAsyncHook: IAIMPAddonsPlayerAsyncHook;
    FPlayerManager: IAIMPAddonsPlayerManager2;
  protected
    function Initialize(ACoreUnit: IAIMPCoreUnit): HRESULT; override; stdcall;
    function Finalize: HRESULT; override; stdcall;
  end;

function AIMP_QueryAddon3(out AHeader: IAIMPAddonPlugin): LongBool; stdcall;
implementation

uses
  SysUtils, ActiveX;

function AIMP_QueryAddon3(out AHeader: IAIMPAddonPlugin): LongBool; stdcall;
begin
  AHeader := TAIMPPlayingQueueHookDemoPlugin.Create;
  Result := True;
end;

{ TAIMPPlayingQueueHookDemoPlugin }

function TAIMPPlayingQueueHookDemoPlugin.Finalize: HRESULT;
begin
  if FPlayerManager <> nil then
    FPlayerManager.PlayingQueueUnregisterHook(FPlayerAsyncHook);
  FPlayerAsyncHook := nil;
  Result := inherited Finalize;
end;

function TAIMPPlayingQueueHookDemoPlugin.Initialize(ACoreUnit: IAIMPCoreUnit): HRESULT;
begin
  Result := inherited Initialize(ACoreUnit);
  if Supports(CoreUnit, IAIMPAddonsPlayerManager2, FPlayerManager) then
  begin
    FPlayerAsyncHook := TMyPlayerAsyncHook.Create;
    FPlayerManager.PlayingQueueRegisterHook(FPlayerAsyncHook);
  end;
end;

{ TMyPlayerAsyncHook }

function TMyPlayerAsyncHook.PreparingForRemoteTrackPlayback(ATrackURI: IAIMPString; var AHandled: LongBool): HRESULT;
const
  S = 'http://example.com';
begin
  Result := ATrackURI.SetData(PWideChar(S), Length(S));
  AHandled := Succeeded(Result);
end;

end.
