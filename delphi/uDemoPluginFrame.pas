unit uDemoPluginFrame;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AIMPAddonCustomPlugin, ComCtrls, StdCtrls, ExtCtrls,
  AIMPSDKCore, AIMPSDKAddons, AIMPSDKCommon,//pngimage,
  IdHTTP, ShellApi;


{$WEAKLINKRTTI ON}
 {$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  
type
  TDemoPluginForm = class;

  TEventManager = class;

  TAIMPAddonDemoPlugin = class(TAIMPAddonsCustomPlugin)
  private
    FMenuHandle: HAIMPMENU;
    F2MenuHandle: HAIMPMENU;
    FPlayerManager: IAIMPAddonsPlayerManager;    
    FEventManager: TEventManager;
    
    FSettingsFrame: TDemoPluginForm;

    procedure MenuFinalize;
    procedure MenuInitialize;
  protected
    function GetPluginFlags: Cardinal; override; stdcall;

    function Initialize(ACoreUnit: IAIMPCoreUnit): HRESULT; override; stdcall;
    function Finalize: HRESULT; override; stdcall;

    function ShowSettingsDialog(AParentWindow: HWND): HRESULT; override; stdcall;
    function GetPluginAuthor(): PWideChar; override; stdcall;
    function GetPluginInfo(): PWideChar; override; stdcall;
    function GetPluginName(): PWideChar; override; stdcall;
     
  public       
    property PlayerManager: IAIMPAddonsPlayerManager read FPlayerManager;
    property EventManager: TEventManager read FEventManager;

    procedure SendInfo();
  end;

  TEventManager = class(TObject, IInterface, IAIMPCoreUnitMessageHook)
    procedure CoreMessage(AMessage: DWORD; AParam1: Integer; AParam2: Pointer; var AResult: HRESULT); stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    public Plugin: TAIMPAddonDemoPlugin;
  end;
  
  TWebThread = class(TThread)
  private
    // Отправка данных на сервер
    procedure SendRequest(Artist, Song, Genre, Login, Pass: string);
  protected
    procedure Execute; override;
  public
    Artist, Song, Genre, Login, Pass: string;
  end;

  TDemoPluginForm = class(TForm)
    CheckAuthButton: TButton;
    SaveSettingsButton: TButton;
    LoginTB: TEdit;
    LabelLogin: TLabel;
    LabelPass: TLabel;
    PassTB: TEdit;
    MustSendCheckBox: TCheckBox;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure SaveSettingsButtonClick(Sender: TObject);
    procedure MustSendCheckBoxClick(Sender: TObject);
    procedure CheckAuthButtonClick(Sender: TObject);
    procedure LoginTBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PassTBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TBKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FPlugin: TAIMPAddonDemoPlugin;
    sLogin, sPass, prevLTBm, prevPTBm: string;
    sIsAuthorized, sIsWorking: boolean;   
    procedure FieldChanged;
  public                   
    procedure Save();
    procedure Load();
    procedure LoadSettings();
    procedure SaveSettings();
    
    constructor Create(APlugin: TAIMPAddonDemoPlugin); reintroduce;
    destructor Destroy; override;
    //
    property Plugin: TAIMPAddonDemoPlugin read FPlugin;
  end;

var
  DemoPlugin: TAIMPAddonDemoPlugin;
  IsEnabled, IsWorking, IsNewTrack, IsAuthorized: boolean;
  LastState, PlayerPosition: integer;
  Login, Password: string;

const 
  LocalStorage: WideString = 'aMPAuth';

implementation

{$R *.dfm}
{$R uDemoPluginFrame.res}

////////////////////////
// Главный Функционал //
////////////////////////

// Отправка данных на сервер
procedure TWebThread.SendRequest(Artist, Song, Genre, Login, Pass: string);
var
  HTTP       :idHTTP.TIdHTTP;
  PostData   :TStringList;
  Text       :WideString;
  Response   :TStringStream;
begin

  if IsWorking = false then exit;

  Response   := TStringStream.Create;
  PostData   := TStringList.Create;
  HTTP       := TIdHTTP.Create;

  // Формируем строку
  PostData.Clear;
  PostData.Add('login=' + Login);
  PostData.Add('pass=' + Pass);
  PostData.Add('artist=' + Artist);
  PostData.Add('song=' + Song);
  PostData.Add('genre=' + Genre);
  PostData.Add('com_pass=7p7p7m7');

  // Настраиваем HTTP клиент
  HTTP.AllowCookies := false;
  HTTP.HandleRedirects := true;
  HTTP.Request.UserAgent := 'aNMusic Plugin';
  HTTP.Request.Host := 'http://annimon.com/';
  HTTP.Request.ContentLength := PostData.InstanceSize;
  HTTP.Request.Connection := 'Keep-Alive';
  HTTP.Request.CacheControl := 'no-cache';
  
  try
    // Отправляем запрос
    HTTP.Post('http://annimon.com/modules/siteclient/?com=nowplay', PostData, Response);
    Text := WideString(UTF8Encode(Response.DataString));

    // Если есть какая-то ошибка, выводим её
    //if (Text <> '') then
    //  MessageBox(0, PWideChar(Text), 'Done!', MB_OK);
  except 
    on E: Exception do
      //Отлавливаем ошибку, когда недоступен сайт
      if E.GetHashCode = 11004 then
         begin end
  end;
  
  // Освобождаем ресурсы
  Response.Free;
  PostData.Free;
  HTTP.Free;
  
  Terminate;
end;

// Собираем информацию о текущем треке
procedure TAIMPAddonDemoPlugin.SendInfo();
var 
  fInfo: TAIMPFileInfo;
  WebThread: TWebThread;
begin

  if IsWorking = false then exit;

  //128, 128, 16, MAX_PATH, 32, c
  fInfo.StructSize := SizeOf(TAIMPFileInfo);
  fInfo.AlbumLength := 128;
  fInfo.Album := AllocMem(128 * SizeOf(WideChar));
  fInfo.ArtistLength := 128;
  fInfo.Artist := AllocMem(128 * SizeOf(WideChar));
  fInfo.DateLength := 16;
  fInfo.Date := AllocMem(16 * SizeOf(WideChar));
  fInfo.FileNameLength := MAX_PATH;
  fInfo.FileName := AllocMem(MAX_PATH * SizeOf(WideChar));
  fInfo.GenreLength := 32;
  fInfo.Genre := AllocMem(32 * SizeOf(WideChar));
  fInfo.TitleLength := 128;
  fInfo.Title := AllocMem(128 * SizeOf(WideChar));
               
  if PlayerManager <> nil then
    try    
      if Succeeded(PlayerManager.FileInfoQuery(nil, @fInfo)) then
      begin
        //MessageBox(0, fInfo.Artist, fInfo.Title, MB_OK);
        
        // Создаем поток и отправляем данные
        WebThread := TWebThread.Create(True);
        
        WebThread.artist := fInfo.Artist;
        WebThread.song   := fInfo.Title;
        WebThread.genre  := fInfo.Genre;
        WebThread.login  := Login;
        WebThread.pass   := Password;
        
        WebThread.Priority:=tpNormal;
        WebThread.Execute;    
      end
      else
      begin
        //MessageBox(0, 'not Succeeded', ' ', 0);
      end;
    except
      on E: Exception do
        MessageBox(0, PWideChar(E.Message), PWideChar(E.ClassName), MB_OK);
    end;
  ZeroMemory(@fInfo, SizeOf(fInfo));
end;

/////////////////////////
//   Работа с формой   //
/////////////////////////

procedure _SubMenuClick(AUserData: TAIMPAddonDemoPlugin; AHandle: HAIMPMENU); stdcall;
var
  ASubMenuInfo: TAIMPMenuItemInfo;
  
  // Менеджер меню
  AMenuManager: IAIMPAddonsMenuManager;
begin
  if AUserData.GetMenuManager(AMenuManager) then
  try           
    IsWorking := not IsWorking;
    AUserData.FSettingsFrame.SaveSettings();
    
    ZeroMemory(@ASubMenuInfo, SizeOf(ASubMenuInfo));
    ASubMenuInfo.StructSize := SizeOf(ASubMenuInfo);
    ASubMenuInfo.Bitmap := 0;
    ASubMenuInfo.Caption := 'Отправлять данные';

    if IsWorking then
      ASubMenuInfo.Flags := AIMP_MENUITEM_ENABLED + AIMP_MENUITEM_CHECKED
    else ASubMenuInfo.Flags := AIMP_MENUITEM_ENABLED + AIMP_MENUITEM_CHECKBOX;

    ASubMenuInfo.Proc := @_SubMenuClick;
    ASubMenuInfo.UserData := AUserData;

    AMenuManager.MenuUpdate(AUserData.F2MenuHandle, @ASubMenuInfo);
  finally
    AMenuManager := nil;
  end;
end;

////////////////////////
function TEventManager.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;
function TEventManager._AddRef: Integer;
begin
  Result := -1;
end;
function TEventManager._Release: Integer;
begin
  Result := -1;
end;
procedure TEventManager.CoreMessage(AMessage: DWORD; AParam1: Integer; AParam2: Pointer; var AResult: HRESULT); stdcall;
begin
  // 0 = Stopped; 1 = Paused; 2 = Playing
  case AMessage of
    AIMP_MSG_EVENT_PLAYER_STATE:
      if AParam1 = 2 then
      begin
        IsEnabled := true; // Нужно ли оно?
        IsNewTrack := true;
        PlayerPosition := 0;
      end
      else IsEnabled := false;

    // Position changed
    AIMP_MSG_EVENT_PLAYER_UPDATE_POSITION:
      begin
        if IsEnabled then
        begin
        
          if not IsWorking then
          begin
            PlayerPosition := 0;
            exit;
          end;
          
          PlayerPosition := PlayerPosition + 1;
          if (PlayerPosition = 10) and (IsNewTrack) then
          begin
            Plugin.SendInfo();
            IsNewTrack := false;
          end
          else if PlayerPosition = 120 then
          begin
            PlayerPosition := 0;
            Plugin.SendInfo();
          end;
          
        end;
      end;  
    end;
end;
////////////////////////

{ TAIMPAddonDemoPlugin }

function TAIMPAddonDemoPlugin.Initialize(ACoreUnit: IAIMPCoreUnit): HRESULT;
var
  i: integer;
begin
  Result := inherited Initialize(ACoreUnit);
  if Succeeded(Result) then
  begin     
    // Инициализируем обработчик событий      
    FEventManager := TEventManager.Create;
    FEventManager.Plugin := Self;
    CoreUnit.MessageHook(FEventManager);

    // Получаем текущее состояние плеера
    CoreUnit.MessageSend(AIMP_MSG_PROPERTY_PLAYER_STATE, AIMP_MSG_PROPVALUE_GET, @i);
    if i = 2 then IsEnabled := true else IsEnabled := false; 
    LastState := i; PlayerPosition := 0;

    FSettingsFrame := TDemoPluginForm.Create(Self);   
    FSettingsFrame.LoadSettings();
    if not ConfigSectionExists(LocalStorage) then
    begin
      FSettingsFrame.Show();
    end;
    
    // Инициализируем меню
    MenuInitialize;

    // Инициализируем плеер
    if not GetPlayerManager(FPlayerManager) then
      FPlayerManager := nil;  
  end;
end;
function TAIMPAddonDemoPlugin.Finalize: HRESULT;
begin    
  CoreUnit.MessageUnhook(FEventManager);
  FreeAndNil(FEventManager);
  FreeAndNil(FSettingsFrame);

  MenuFinalize;
  
  if PlayerManager <> nil then
    FPlayerManager := nil;
            
    
  Result := inherited Finalize;   
end;
function TAIMPAddonDemoPlugin.GetPluginFlags: Cardinal;
begin
  Result := AIMP_ADDON_FLAGS_HAS_DIALOG;
end;
function TAIMPAddonDemoPlugin.ShowSettingsDialog(AParentWindow: HWND): HRESULT;
begin
  Result := FSettingsFrame.ShowModal(); // TODO
end;
function TAIMPAddonDemoPlugin.GetPluginAuthor(): PWideChar; stdcall;
begin
  Result := 'aNNiMON, web_demon & XakepPRO';
end;
function TAIMPAddonDemoPlugin.GetPluginInfo(): PWideChar; stdcall;
begin
  Result := 'Sends information about currently playing file to annimon.com';
end;
function TAIMPAddonDemoPlugin.GetPluginName(): PWideChar;
begin
  Result := 'aNMusic v1.2';
end;

// Инициализация меню
procedure TAIMPAddonDemoPlugin.MenuFinalize;
var
  AMenuManager: IAIMPAddonsMenuManager;
begin
  if GetMenuManager(AMenuManager) then
  try
    AMenuManager.MenuRemove(FMenuHandle);
    AMenuManager.MenuRemove(F2MenuHandle);
    FMenuHandle := nil;
    F2MenuHandle := nil;
  finally
    AMenuManager := nil;
  end;
end;
procedure TAIMPAddonDemoPlugin.MenuInitialize;
var
  // Пункт меню
  AMenuInfo: TAIMPMenuItemInfo;
  ASubMenuInfo: TAIMPMenuItemInfo;

  // Менеджер меню
  AMenuManager: IAIMPAddonsMenuManager;
begin
  if GetMenuManager(AMenuManager) then
  try
    // Заполняем нулями раздел памяти
    ZeroMemory(@AMenuInfo, SizeOf(AMenuInfo));
    ZeroMemory(@ASubMenuInfo, SizeOf(ASubMenuInfo));

    // Получаем размер структуры
    AMenuInfo.StructSize := SizeOf(AMenuInfo);
    ASubMenuInfo.StructSize := SizeOf(ASubMenuInfo);

    // Иконка пункта меню
    AMenuInfo.Bitmap := 0; //LoadBitmap(HInstance, 'AIMP');
    ASubMenuInfo.Bitmap := 0;

    // Заголовок
    AMenuInfo.Caption := 'aNMusic';
    ASubMenuInfo.Caption := 'Отправлять данные';

    // Тип
    AMenuInfo.Flags := AIMP_MENUITEM_ENABLED;
    if IsWorking then
      ASubMenuInfo.Flags := AIMP_MENUITEM_ENABLED + AIMP_MENUITEM_CHECKED
    else ASubMenuInfo.Flags := AIMP_MENUITEM_ENABLED + AIMP_MENUITEM_CHECKBOX;

    // Процедура-событие
    AMenuInfo.Proc := nil;
    ASubMenuInfo.Proc := @_SubMenuClick;

    AMenuInfo.UserData := Self;
    ASubMenuInfo.UserData := Self;

    FMenuHandle := AMenuManager.MenuCreate(AIMP_MENUID_UTILITIES, @AMenuInfo);
    F2MenuHandle := AMenuManager.MenuCreateEx(FMenuHandle, @ASubMenuInfo);
  finally
    AMenuManager := nil;
  end;
end;

// Инициализация формы настроек
constructor TDemoPluginForm.Create(APlugin: TAIMPAddonDemoPlugin);
begin
  inherited Create(nil);
  FPlugin := APlugin;
  Caption := Plugin.GetPluginName();
end;
destructor TDemoPluginForm.Destroy;
begin
  inherited Destroy;
end;

procedure TDemoPluginForm.FormShow(Sender: TObject);
begin
  Load();

  if sIsAuthorized then
  begin
    CheckAuthButton.Enabled := false;
    CheckAuthButton.Caption := 'Вход успешен';
  end
  else
  begin
    CheckAuthButton.Enabled := true;
    CheckAuthButton.Caption := 'Проверить';
  end;

  MustSendCheckBox.Checked := not sIsWorking;

  if sLogin <> '' then LoginTB.Text := sLogin
    else CheckAuthButton.Enabled := false;
  if sPass <> '' then PassTB.Text := sPass
    else CheckAuthButton.Enabled := false;
  
end;
procedure TDemoPluginForm.Save();      
begin
  Plugin.ConfigWriteString(LocalStorage, 'Login', WideString(sLogin));
  Plugin.ConfigWriteString(LocalStorage, 'Pass', WideString(sPass));
  Plugin.ConfigWriteBoolean(LocalStorage, 'IsAuthorized', sIsAuthorized);
  Plugin.ConfigWriteBoolean(LocalStorage, 'IsWorking', sIsWorking);
end;
procedure TDemoPluginForm.Label1Click(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', 'http://annimon.com', '', '', SW_SHOWNORMAL);
end;
procedure TDemoPluginForm.MustSendCheckBoxClick(Sender: TObject);
begin
  sIsWorking := not MustSendCheckBox.Checked;
end;

procedure TDemoPluginForm.CheckAuthButtonClick(Sender: TObject);
var
  HTTP       :idHTTP.TIdHTTP;
  PostData   :TStringList;
  Text       :WideString;
  Response   :TStringStream;
begin               
  CheckAuthButton.Enabled := false;
  loginTB.ReadOnly := true;
  passTB.ReadOnly := true;  

  Cursor := crAppStart;
  
  Response   := TStringStream.Create;
  PostData   := TStringList.Create;
  HTTP       := TIdHTTP.Create;
  
  // Формируем строку
  PostData.Clear;
  PostData.Add('login=' + LoginTB.Text);
  PostData.Add('pass=' + PassTB.Text);
  PostData.Add('artist=' + LoginTB.Text);
  PostData.Add('song=I have just installed aNMusic Plugin!');
  PostData.Add('genre=metal');
  PostData.Add('com_pass=7p7p7m7');

  // Настраиваем HTTP клиент
  HTTP.AllowCookies := false;
  HTTP.HandleRedirects := true;
  HTTP.Request.UserAgent := 'aNMusic Plugin';
  HTTP.Request.Host := 'http://annimon.com/';
  HTTP.Request.ContentLength := PostData.InstanceSize;
  HTTP.Request.Connection := 'Keep-Alive';
  HTTP.Request.CacheControl := 'no-cache';
  
  try
    // Отправляем запрос
    HTTP.Post('http://annimon.com/modules/siteclient/?com=nowplay', PostData, Response);
    Text := WideString(UTF8Encode(Response.DataString));

    // Если есть какая-то ошибка, выводим её
    if (Text <> '') then
    begin
      MessageBox(HWND_TOP, 'Неправильные логин или пароль!', 'Ошибка!', MB_OK);
      CheckAuthButton.Enabled := true;
      
      sIsAuthorized := false;  
    end
    else
    begin
      sLogin := LoginTB.Text;
      sPass := PassTB.Text;

      sIsAuthorized := true;

      CheckAuthButton.Enabled := false;
      CheckAuthButton.Caption := 'Вход успешен';
    end;
  except 
    on E: Exception do
      //Отлавливаем ошибку, когда недоступен сайт
      if E.GetHashCode = 11004 then
         begin end
  end;
  
  // Освобождаем ресурсы
  Response.Free;
  PostData.Free;
  HTTP.Free;
               
  loginTB.ReadOnly := false;
  passTB.ReadOnly := false;
  
  Cursor := crDefault;
end;

procedure TDemoPluginForm.Load();    
begin

  sLogin := string(Plugin.ConfigReadString(LocalStorage, 'Login'));
  sPass := string(Plugin.ConfigReadString(LocalStorage, 'Pass'));

  sIsAuthorized := Plugin.ConfigReadBoolean(LocalStorage, 'IsAuthorized', false);
  sIsWorking := Plugin.ConfigReadBoolean(LocalStorage, 'IsWorking', true);
  
end;
procedure TDemoPluginForm.LoadSettings();
begin
  Load();
  
  Login := sLogin;
  Password := sPass;
  IsAuthorized := sIsAuthorized;
  IsWorking := sIsWorking;
end;

procedure TDemoPluginForm.LoginTBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  prevLTBm := LoginTB.Text;
end; 
procedure TDemoPluginForm.PassTBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  prevPTBm := PassTB.Text;
end;
procedure TDemoPluginForm.TBKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (prevLTBm <> loginTB.Text) or (prevPTBm <> passTB.Text) then
    FieldChanged();
end;

procedure TDemoPluginForm.SaveSettings();
begin
  sLogin := Login;
  sPass := Password;
  sIsAuthorized := IsAuthorized;
  sIsWorking := IsWorking;

  Save();
end;
procedure TDemoPluginForm.SaveSettingsButtonClick(Sender: TObject);
var
  ASubMenuInfo: TAIMPMenuItemInfo;
  
  // Менеджер меню
  AMenuManager: IAIMPAddonsMenuManager;
begin    
  Save(); LoadSettings();
  
  if Plugin.GetMenuManager(AMenuManager) then
  try      
  
    ZeroMemory(@ASubMenuInfo, SizeOf(ASubMenuInfo));
    ASubMenuInfo.StructSize := SizeOf(ASubMenuInfo);
    ASubMenuInfo.Bitmap := 0;
    ASubMenuInfo.Caption := 'Отправлять данные';

    if IsWorking then
      ASubMenuInfo.Flags := AIMP_MENUITEM_ENABLED + AIMP_MENUITEM_CHECKED
    else ASubMenuInfo.Flags := AIMP_MENUITEM_ENABLED + AIMP_MENUITEM_CHECKBOX;

    ASubMenuInfo.Proc := @_SubMenuClick;
    ASubMenuInfo.UserData := Plugin;

    AMenuManager.MenuUpdate(Plugin.F2MenuHandle, @ASubMenuInfo);
  finally
    AMenuManager := nil;
  end;

  Self.Hide;
  Self.CloseModal();
  Self.Close;
end;

procedure TDemoPluginForm.FieldChanged;
begin
  sIsAuthorized := false;        
  CheckAuthButton.Enabled := true;
  CheckAuthButton.Caption := 'Проверить';
  
  if (LoginTB.Text = '') or (PassTB.Text = '') then
    CheckAuthButton.Enabled := false;
end;

/////////////////////////
//       Прочие        //
/////////////////////////
procedure TWebThread.Execute();
begin
  SendRequest(artist, song, genre, login, pass);
end; 

end.
