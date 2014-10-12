unit AIMP_RemInfoUnit;

interface

uses
  AIMPSDKRemote, AIMPSDKCommon,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    Button1: TButton;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  protected
    FAIMPWindow: HWND;
    procedure RefreshTrackInfo;
    procedure RefreshTrackPositionInfo;
    procedure WMAIMPNotify(var Message: TMessage); message WM_AIMP_NOTIFY;
    procedure WMCopyData(var Message: TWMCopyData); message WM_COPYDATA;
    //
    function AIMPGetPropertyValue(APropertyID: Integer): Integer;
    function AIMPSetPropertyValue(APropertyID, AValue: Integer): Boolean;
    procedure AIMPExecuteCommand(ACommand: Integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  //Available in D2010 or newer
  //For old Delphi versions you can download it from: http://pngdelphi.sourceforge.net/
  pngimage;

function AIMPGetHandle: HWND;
begin
  Result := FindWindow(AIMPRemoteAccessClass, AIMPRemoteAccessClass)
end;

{ TForm1 }

function TForm1.AIMPGetPropertyValue(APropertyID: Integer): Integer;
begin
  if FAIMPWindow <> 0 then
    Result := SendMessage(FAIMPWindow, WM_AIMP_PROPERTY, APropertyID or AIMP_RA_PROPVALUE_GET, 0)
  else
    Result := 0;
end;

function TForm1.AIMPSetPropertyValue(APropertyID, AValue: Integer): Boolean;
begin
  if FAIMPWindow <> 0 then
    Result := SendMessage(FAIMPWindow, WM_AIMP_PROPERTY, APropertyID or AIMP_RA_PROPVALUE_SET, AValue) <> 0
  else
    Result := False
end;

procedure TForm1.AIMPExecuteCommand(ACommand: Integer);
begin
  if FAIMPWindow <> 0 then
    SendMessage(FAIMPWindow, WM_AIMP_COMMAND, ACommand, 0);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  S: string;
begin
  S := '0';
  if InputQuery('Jump To Time', 'Enter time (in seconds)', S) then
    AIMPSetPropertyValue(AIMP_RA_PROPERTY_PLAYER_POSITION, StrToInt(S) * 1000);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  AIMPExecuteCommand(AIMP_RA_CMD_PREV);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  AIMPExecuteCommand(AIMP_RA_CMD_NEXT);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  AIMPExecuteCommand(AIMP_RA_CMD_PLAY);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  AIMPExecuteCommand(AIMP_RA_CMD_PAUSE);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  AIMPExecuteCommand(AIMP_RA_CMD_STOP);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  AVersion: Integer;
begin
  FAIMPWindow := AIMPGetHandle;
  if FAIMPWindow = 0 then
  begin
    MessageDlg('AIMP not running!', mtWarning, [mbOK], 0);
    Exit;
  end;

  AVersion := AIMPGetPropertyValue(AIMP_RA_PROPERTY_VERSION);
  Caption := FormatFloat('0.00', HiWord(AVersion) / 100) + ' Build ' + IntToStr(LoWord(AVersion));

  // hook notifications
  SendMessage(FAIMPWindow, WM_AIMP_COMMAND, AIMP_RA_CMD_REGISTER_NOTIFY, Handle);
  // Refresh TrackInfo
  RefreshTrackInfo;
end;

procedure TForm1.WMAIMPNotify(var Message: TMessage);
begin
  case Message.WParam of
    AIMP_RA_NOTIFY_TRACK_INFO:
      begin
        RefreshTrackInfo;
        // Trying to get CoverArtData:
        if SendMessage(FAIMPWindow, WM_AIMP_COMMAND, AIMP_RA_CMD_GET_COVER_ART, Handle) = 0 then
          Image1.Picture.Graphic := nil;
      end;
    AIMP_RA_NOTIFY_PROPERTY:
      case Message.LParam of
        AIMP_RA_PROPERTY_PLAYER_POSITION, AIMP_RA_PROPERTY_PLAYER_DURATION:
          RefreshTrackPositionInfo;
      end;
  end;
end;

procedure TForm1.WMCopyData(var Message: TWMCopyData);
var
  AImage: TPngImage;
  AStream: TMemoryStream;
begin
  if Message.CopyDataStruct^.dwData = WM_AIMP_COPYDATA_COVER_ID then
  begin
    AStream := TMemoryStream.Create;
    try
      AStream.WriteBuffer(Message.CopyDataStruct^.lpData^, Message.CopyDataStruct^.cbData);
      AStream.Position := 0;
      AImage := TPngImage.Create;
      try
        AImage.LoadFromStream(AStream);
        Image1.Picture.Graphic := AImage;
      except
        Image1.Picture.Graphic := nil;
        AImage.Free;
      end;
    finally
      AStream.Free;
    end;
  end;
end;

procedure TForm1.RefreshTrackInfo;

  function ExtractString(var B: PByte; ALength: Integer): UnicodeString;
  begin
    SetString(Result, PWideChar(B), ALength);
    Inc(B, SizeOf(WideChar) * ALength);
  end;

var
  ABuffer: PByte;
  AFile: Cardinal;
  AInfo: PAIMPFileInfo;
begin
  ListBox1.Items.Clear;
  AFile := OpenFileMapping(FILE_MAP_READ, True, AIMPRemoteAccessClass);
  try
    AInfo := MapViewOfFile(AFile, FILE_MAP_READ, 0, 0, AIMPRemoteAccessMapFileSize);
    if AInfo <> nil then
    try
      if AInfo <> nil then
      begin
        ABuffer := Pointer(DWORD(AInfo) + SizeOf(TAIMPFileInfo));
        Listbox1.Items.Add(Format('%d Hz, %d kbps, %d chans', [AInfo^.SampleRate, AInfo^.BitRate, AInfo^.Channels]));
        Listbox1.Items.Add(Format('%d seconds, %d bytes', [AInfo^.Duration div 1000, AInfo^.FileSize]));
        Listbox1.Items.Add('Album: ' + ExtractString(ABuffer, AInfo^.AlbumBufferSizeInChars));
        Listbox1.Items.Add('Artist: ' + ExtractString(ABuffer, AInfo^.ArtistBufferSizeInChars));
        Listbox1.Items.Add('Date: ' + ExtractString(ABuffer, AInfo^.DateBufferSizeInChars));
        Listbox1.Items.Add('FileName: ' + ExtractString(ABuffer, AInfo^.FileNameBufferSizeInChars));
        Listbox1.Items.Add('Genre: ' + ExtractString(ABuffer, AInfo^.GenreBufferSizeInChars));
        Listbox1.Items.Add('Title: ' + ExtractString(ABuffer, AInfo^.TitleBufferSizeInChars));
      end;
    finally
      UnmapViewOfFile(AInfo);
    end;
  finally
    CloseHandle(AFile);
  end;
end;

procedure TForm1.RefreshTrackPositionInfo;
begin
  Label1.Caption :=
    IntToStr(AIMPGetPropertyValue(AIMP_RA_PROPERTY_PLAYER_POSITION) div 1000) + ' / ' +
    IntToStr(AIMPGetPropertyValue(AIMP_RA_PROPERTY_PLAYER_DURATION) div 1000) + ' seconds';
end;

end.
