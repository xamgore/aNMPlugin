unit ActionsDemoUnit;

interface

uses
  Windows, AIMPSDKAddons, AIMPSDKHelpers, AIMPAddonCustomPlugin, AIMPSDKCore;

type
  { TAIMPActionsDemoPlugin }

  TAIMPActionsDemoPlugin = class(TAIMPAddonsCustomPlugin)
  private
    FAction: HAIMPACTION;
    FMenu: HAIMPMENU;
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
  AHeader := TAIMPActionsDemoPlugin.Create;
  Result := True;
end;

procedure ActionProc(UserData: Pointer; ID: Integer; Handle: HAIMPACTION); stdcall;
begin
  MessageBox(0, 'Action executed', 'Information', MB_ICONINFORMATION);
end;

{ TAIMPActionsDemoPlugin }

function TAIMPActionsDemoPlugin.Finalize: HRESULT;
var
  AActionsManager: IAIMPAddonsActionManager;
  AMenuManager: IAIMPAddonsMenuManager;
begin
  if Supports(CoreUnit, IAIMPAddonsMenuManager, AMenuManager) then
    AMenuManager.MenuRemove(FMenu);
  if Supports(CoreUnit, IAIMPAddonsActionManager, AActionsManager) then
    AActionsManager.ActionRemove(FAction);
  Result := inherited Finalize;
end;

function TAIMPActionsDemoPlugin.Initialize(ACoreUnit: IAIMPCoreUnit): HRESULT;
const
  ActionGroupName: PWideChar = 'Demo Plugin';
  ActionName: PWideChar = 'Demo Action';
var
  AActionsManager: IAIMPAddonsActionManager;
  AHotKey: Cardinal;
  AMenuItem: TAIMPMenuItemInfo;
  AMenuManager: IAIMPAddonsMenuManager2;
begin
  Result := inherited Initialize(ACoreUnit);
  if Supports(CoreUnit, IAIMPAddonsActionManager, AActionsManager) then
  begin
    if Succeeded(AActionsManager.ActionCreate(HInstance, 1, ActionProc, Self, FAction)) then
    begin
      // Setup action display name and group name
      AActionsManager.ActionPropertySetValue(FAction,
        AIMP_ACTION_PROPERTY_NAME, ActionName, Length(ActionName) * SizeOf(WideChar));
      AActionsManager.ActionPropertySetValue(FAction,
        AIMP_ACTION_PROPERTY_GROUPNAME, ActionGroupName, Length(ActionGroupName) * SizeOf(WideChar));

      // Set default local hotkey for an action
      AHotKey := AActionsManager.ActionMakeHotkey(
        AIMP_ACTION_HOTKEY_MODIFIER_CTRL or AIMP_ACTION_HOTKEY_MODIFIER_SHIFT, Ord('Z'));
      AActionsManager.ActionPropertySetValue(FAction,
        AIMP_ACTION_PROPERTY_DEFAULTLOCALHOTKEY, @AHotKey, SizeOf(AHotKey));

      // Create menu item and link action to it
      if Supports(CoreUnit, IAIMPAddonsMenuManager2, AMenuManager) then
      begin
        ZeroMemory(@AMenuItem, SizeOf(AMenuItem));
        AMenuItem.StructSize := SizeOf(AMenuItem);
        AMenuItem.Caption := 'Menu Item with Action';
        FMenu := AMenuManager.MenuCreate(AIMP_MENUID_UTILITIES, @AMenuItem);
        AMenuManager.MenuSetAction(FMenu, FAction);
      end;
    end;
  end;
end;

end.
