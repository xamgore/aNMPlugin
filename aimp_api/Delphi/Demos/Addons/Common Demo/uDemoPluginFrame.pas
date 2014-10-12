unit uDemoPluginFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AIMPAddonCustomPlugin, ComCtrls, AIMPSDKCore, AIMPSDKAddons,
  StdCtrls, ExtCtrls;

type
  TDemoPluginForm = class;

  { TAIMPAddonDemoPlugin }

  TAIMPAddonDemoPlugin = class(TAIMPAddonsCustomPlugin)
  private
    FMenuHandle: HAIMPMENU;
    FFrame: TDemoPluginForm;
    procedure MenuFinalize;
    procedure MenuInitialize;
  protected
    function GetPluginFlags: Cardinal; override; stdcall;
    function Initialize(ACoreUnit: IAIMPCoreUnit): HRESULT; override; stdcall;
    function Finalize: HRESULT; override; stdcall;
    function ShowSettingsDialog(AParentWindow: HWND): HRESULT; override; stdcall;
  end;

  { TDemoPluginForm }

  TDemoPluginForm = class(TForm, IAIMPAddonsPlaylistManagerListener)
    PageControl1: TPageControl;
    tsPlsMan: TTabSheet;
    lbPlaylist: TListBox;
    cbPlaylists: TComboBox;
    Panel1: TPanel;
    gbEntry: TGroupBox;
    edFileName: TEdit;
    edDisplayText: TEdit;
    cbEntrySelected: TCheckBox;
    edEntryIndex: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edEntryMark: TEdit;
    cbEntryAutoPlayingSwitch: TCheckBox;
    lbEntryStatistics: TLabel;
    btnEntryApply: TButton;
    btnEntryReloadInfo: TButton;
    tsSkins: TTabSheet;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure cbPlaylistsSelect(Sender: TObject);
    procedure lbPlaylistClick(Sender: TObject);
    procedure btnEntryReloadInfoClick(Sender: TObject);
    procedure btnEntryApplyClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FPlaylistManager: IAIMPAddonsPlaylistManager;
    FPlugin: TAIMPAddonDemoPlugin;
    function GetSelectedEntry: HPLSENTRY;
    function GetSelectedStorage: HPLS;
    procedure UpdateActiveIndexPlaylist;
    procedure UpdatePlaylistsCombo;
    procedure UpdateSelectedEntryInfo;
  protected
    // IAIMPAddonsPlaylistManagerListener
    procedure StorageActivated(ID: HPLS); stdcall;
    procedure StorageAdded(ID: HPLS); stdcall;
    procedure StorageChanged(ID: HPLS; AFlags: Cardinal); stdcall;
    procedure StorageRemoved(ID: HPLS); stdcall;
    //
    property SelectedEntry: HPLSENTRY read GetSelectedEntry;
    property SelectedStorage: HPLS read GetSelectedStorage;
  public
    constructor Create(APlugin: TAIMPAddonDemoPlugin); reintroduce;
    destructor Destroy; override;
    //
    property PlaylistManager: IAIMPAddonsPlaylistManager read FPlaylistManager;
    property Plugin: TAIMPAddonDemoPlugin read FPlugin;
  end;

var
  DemoPluginForm: TDemoPluginForm;

implementation

{$R *.dfm}
{$R uDemoPluginFrame.res}

procedure _MenuClick(AUserData: TAIMPAddonDemoPlugin; AHandle: HAIMPMENU); stdcall;
begin
  AUserData.ShowSettingsDialog(0);
end;

{ TAIMPAddonDemoPlugin }

function TAIMPAddonDemoPlugin.Finalize: HRESULT;
begin
  FreeAndNil(FFrame);
  MenuFinalize;
  Result := inherited Finalize;
end;

function TAIMPAddonDemoPlugin.Initialize(ACoreUnit: IAIMPCoreUnit): HRESULT;
begin
  Result := inherited Initialize(ACoreUnit);
  if Succeeded(Result) then
  begin
    MenuInitialize;
    FFrame := TDemoPluginForm.Create(Self);
    FFrame.Show;
  end;
end;

procedure TAIMPAddonDemoPlugin.MenuFinalize;
var
  AMenuManager: IAIMPAddonsMenuManager;
begin
  if GetMenuManager(AMenuManager) then
  try
    AMenuManager.MenuRemove(FMenuHandle);
    FMenuHandle := nil;
  finally
    AMenuManager := nil;
  end;
end;

procedure TAIMPAddonDemoPlugin.MenuInitialize;
var
  AMenuInfo: TAIMPMenuItemInfo;
  AMenuManager: IAIMPAddonsMenuManager;
begin
  if GetMenuManager(AMenuManager) then
  try
    ZeroMemory(@AMenuInfo, SizeOf(AMenuInfo));
    AMenuInfo.StructSize := SizeOf(AMenuInfo);
    AMenuInfo.Bitmap := LoadBitmap(HInstance, 'AIMP');
    AMenuInfo.Caption := 'Demo Plugin';
    AMenuInfo.Flags := AIMP_MENUITEM_ENABLED;
    AMenuInfo.Proc := @_MenuClick;
    AMenuInfo.UserData := Self;
    FMenuHandle := AMenuManager.MenuCreate(AIMP_MENUID_UTILITIES, @AMenuInfo);
  finally
    AMenuManager := nil;
  end;
end;

function TAIMPAddonDemoPlugin.GetPluginFlags: Cardinal;
begin
  Result := AIMP_ADDON_FLAGS_HAS_DIALOG;
end;

function TAIMPAddonDemoPlugin.ShowSettingsDialog(AParentWindow: HWND): HRESULT;
begin
  MessageBoxW(AParentWindow, 'Settings Dialog!', GetPluginName, MB_OK);
  Result := S_OK;
end;

{ TDemoPluginForm }

constructor TDemoPluginForm.Create(APlugin: TAIMPAddonDemoPlugin);
begin
  inherited Create(nil);
  FPlugin := APlugin;
  Caption := 'Demo Plugin - AIMP ' + FormatVersionInfo(Plugin.Version);

  if Plugin.GetPlaylistManager(FPlaylistManager) then
    FPlaylistManager.ListenerAdd(Self)
  else
    FPlaylistManager := nil;

  UpdatePlaylistsCombo;
end;

destructor TDemoPluginForm.Destroy;
begin
  if PlaylistManager <> nil then
  begin
    FPlaylistManager.ListenerRemove(Self);
    FPlaylistManager := nil;
  end;
  inherited Destroy;
end;

procedure TDemoPluginForm.lbPlaylistClick(Sender: TObject);
begin
  UpdateSelectedEntryInfo;
end;

procedure TDemoPluginForm.StorageActivated(ID: HPLS);
begin
  UpdateActiveIndexPlaylist;
end;

procedure TDemoPluginForm.StorageAdded(ID: HPLS);
begin
  UpdatePlaylistsCombo;
end;

procedure TDemoPluginForm.StorageChanged(ID: HPLS; AFlags: Cardinal);
begin
  if AFlags and AIMP_PLAYLIST_NOTIFY_NAME <> 0 then
    UpdatePlaylistsCombo;
  if AFlags and AIMP_PLAYLIST_NOTIFY_CONTENT <> 0 then
    cbPlaylistsSelect(nil);
end;

procedure TDemoPluginForm.StorageRemoved(ID: HPLS);
begin
  UpdatePlaylistsCombo;
end;

function TDemoPluginForm.GetSelectedEntry: HPLSENTRY;
begin
  Result := PlaylistManager.StorageGetEntry(SelectedStorage, lbPlaylist.ItemIndex);
end;

function TDemoPluginForm.GetSelectedStorage: HPLS;
begin
  if cbPlaylists.ItemIndex >= 0 then
    Result := HPLS(cbPlaylists.Items.Objects[cbPlaylists.ItemIndex])
  else
    Result := nil;
end;

procedure TDemoPluginForm.UpdatePlaylistsCombo;
var
  I: Integer;
  ID: HPLS;
begin
  cbPlaylists.Items.BeginUpdate;
  try
    cbPlaylists.Items.Clear;
    if PlaylistManager <> nil then
    begin
      for I := 0 to PlaylistManager.StorageGetCount - 1 do
      begin
        ID := PlaylistManager.StorageGet(I);
        cbPlaylists.AddItem(StoragePropertyGetStringValue(
          PlaylistManager, ID, AIMP_PLAYLIST_STORAGE_PROPERTY_NAME), TObject(ID));
      end;
      UpdateActiveIndexPlaylist;
    end;
  finally
    cbPlaylists.Items.EndUpdate;
  end;
end;

procedure TDemoPluginForm.UpdateSelectedEntryInfo;
var
  AStatistics: TAIMPFileStatisticsInfo;
  ID: HPLSENTRY;
begin
  gbEntry.Enabled := lbPlaylist.ItemIndex >= 0;
  if gbEntry.Enabled then
  begin
    ID := SelectedEntry;
    cbEntryAutoPlayingSwitch.Checked := EntryPropertyGetBoolValue(
      PlaylistManager, ID, AIMP_PLAYLIST_ENTRY_PROPERTY_PLAYINGSWITCH);
    cbEntrySelected.Checked := EntryPropertyGetBoolValue(
      PlaylistManager, ID, AIMP_PLAYLIST_ENTRY_PROPERTY_SELECTED);
    edDisplayText.Text := EntryPropertyGetStringValue(
      PlaylistManager, ID, AIMP_PLAYLIST_ENTRY_PROPERTY_DISPLAYTEXT);
    edEntryIndex.Text := IntToStr(EntryPropertyGetIntegerValue(
      PlaylistManager, ID, AIMP_PLAYLIST_ENTRY_PROPERTY_INDEX));
    edEntryMark.Text := IntToStr(EntryPropertyGetIntegerValue(
      PlaylistManager, ID, AIMP_PLAYLIST_ENTRY_PROPERTY_MARK));
    edFileName.Text := EntryPropertyGetStringValue(
      PlaylistManager, ID, AIMP_PLAYLIST_ENTRY_PROPERTY_FILENAME);
    if Succeeded(PlaylistManager.EntryPropertyGetValue(ID,
      AIMP_PLAYLIST_ENTRY_PROPERTY_STATISTICS, @AStatistics, SizeOf(TAIMPFileStatisticsInfo)))
    then
      lbEntryStatistics.Caption :=
        'Mark: ' + FormatFloat('0.0', AStatistics.Mark) + #13#10 +
        'Added: ' + FormatDateTime('yyyy.MM.dd hh:mm:ss', AStatistics.AddedDate) + #13#10 +
        'LastPlay: ' + FormatDateTime('yyyy.MM.dd hh:mm:ss', AStatistics.LastPlayDate) + #13#10 +
        'Rank: ' + FormatFloat('0.0', 5 * AStatistics.Rating) + #13#10 +
        'PlayCount: ' + IntToStr(AStatistics.PlayCount);
  end;
end;

procedure TDemoPluginForm.UpdateActiveIndexPlaylist;
begin
  if PlaylistManager <> nil then
  begin
    cbPlaylists.ItemIndex := cbPlaylists.Items.IndexOfObject(TObject(PlaylistManager.StorageActiveGet));
    cbPlaylistsSelect(nil);
  end;
end;

procedure TDemoPluginForm.btnEntryApplyClick(Sender: TObject);

  procedure CheckResult(AResult: LongBool; const APropertyName: UnicodeString);
  begin
    if not AResult then
      MessageDlg('Failed to set value to "' + APropertyName + '"', mtWarning, [mbOK], 0);
  end;

var
  ID: HPLSENTRY;
begin
  ID := SelectedEntry;
  CheckResult(EntryPropertySetBoolValue(PlaylistManager, ID,
    AIMP_PLAYLIST_ENTRY_PROPERTY_PLAYINGSWITCH, cbEntryAutoPlayingSwitch.Checked),
    'AIMP_PLAYLIST_ENTRY_PROPERTY_PLAYINGSWITCH');

  CheckResult(EntryPropertySetBoolValue(PlaylistManager, ID,
    AIMP_PLAYLIST_ENTRY_PROPERTY_SELECTED, cbEntrySelected.Checked),
    'AIMP_PLAYLIST_ENTRY_PROPERTY_SELECTED');

  CheckResult(EntryPropertySetIntegerValue(PlaylistManager, ID,
    AIMP_PLAYLIST_ENTRY_PROPERTY_INDEX, StrToIntDef(edEntryIndex.Text, -1)),
    'AIMP_PLAYLIST_ENTRY_PROPERTY_INDEX');

  CheckResult(EntryPropertySetIntegerValue(PlaylistManager, ID,
    AIMP_PLAYLIST_ENTRY_PROPERTY_MARK, StrToIntDef(edEntryMark.Text, -1)),
    'AIMP_PLAYLIST_ENTRY_PROPERTY_MARK');

  CheckResult(EntryPropertySetStringValue(PlaylistManager, ID,
    AIMP_PLAYLIST_ENTRY_PROPERTY_FILENAME, edFileName.Text),
    'AIMP_PLAYLIST_ENTRY_PROPERTY_FILENAME');

  UpdateSelectedEntryInfo;
end;

procedure TDemoPluginForm.btnEntryReloadInfoClick(Sender: TObject);
begin
  if Succeeded(PlaylistManager.EntryReloadInfo(SelectedEntry)) then
    UpdateSelectedEntryInfo;
end;

procedure TDemoPluginForm.Button1Click(Sender: TObject);
const
  BufferLength = 512;
var
  ABuffers: array[0..3, 0..BufferLength - 1] of WideChar;
  AManager: IAIMPAddonsSkinsManager;
  ASkinInfo: TAIMPSkinInfo;
  ASkinLocalFileName: UnicodeString;
begin
  if Plugin.GetSkinsManager(AManager) then
  try
    if OpenDialog1.Execute then
    begin
      ZeroMemory(@ASkinInfo, SizeOf(ASkinInfo));
      ASkinInfo.StructSize := SizeOf(ASkinInfo);
      ASkinInfo.AuthorBuffer := @ABuffers[0];
      ASkinInfo.AuthorBufferLength := BufferLength;
      ASkinInfo.NameBuffer := @ABuffers[1];
      ASkinInfo.NameBufferLength := BufferLength;
      ASkinInfo.InfoBuffer := @ABuffers[2];
      ASkinInfo.InfoBufferLength := BufferLength;

      ASkinLocalFileName := UnicodeString(OpenDialog1.FileName);
      if AManager.GetSkinInfo(PWideChar(ASkinLocalFileName), Length(ASkinLocalFileName), @ASkinInfo) = S_OK then
      begin
        Label3.Caption := ABuffers[0];
        Label4.Caption := ABuffers[1];
        Label5.Caption := ABuffers[2];
        Image1.Picture.Bitmap.Handle := ASkinInfo.Preview; // TBitmap will destroy handle automaticly
      end;
    end;
  finally
    AManager := nil;
  end;
end;

procedure TDemoPluginForm.cbPlaylistsSelect(Sender: TObject);
var
  I: Integer;
  ID: HPLS;
begin
  if PlaylistManager <> nil then
  begin
    ID := SelectedStorage;
    PlaylistManager.StorageActiveSet(ID);
    lbPlaylist.Items.BeginUpdate;
    try
      lbPlaylist.Items.Clear;
      for I := 0 to PlaylistManager.StorageGetEntryCount(ID) - 1 do
      begin
        lbPlaylist.Items.Add(EntryPropertyGetStringValue(PlaylistManager,
          PlaylistManager.StorageGetEntry(ID, I), AIMP_PLAYLIST_ENTRY_PROPERTY_DISPLAYTEXT));
      end;
      UpdateSelectedEntryInfo;
    finally
      lbPlaylist.Items.EndUpdate;
    end;
  end;
end;

end.

