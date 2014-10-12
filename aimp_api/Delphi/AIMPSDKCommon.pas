unit AIMPSDKCommon;

{************************************************}
{*                                              *}
{*                AIMP Plugins API              *}
{*             v3.55.1290 (03.09.2013)          *}
{*                Common Objects                *}
{*                                              *}
{*              (c) Artem Izmaylov              *}
{*                 www.aimp.ru                  *}
{*             Mail: artem@aimp.ru              *}
{*              ICQ: 345-908-513                *}
{*                                              *}
{************************************************}

interface

uses
  Windows;

const
  SID_IAIMPString = '{41494D50-0033-434F-0000-535452000000}';
  IID_IAIMPString: TGUID = SID_IAIMPString;

type

  { IAIMPString }

  IAIMPString = interface // [v3.51]
  [SID_IAIMPString]
    function GetChar(AIndex: Integer; out AChar: WideChar): HRESULT; stdcall;
    function GetData: PWideChar; stdcall;
    function GetLength: Integer; stdcall;
    function SetData(AChars: PWideChar; ACharsCount: Integer): HRESULT; stdcall;
  end;

  PAIMPFileInfo = ^TAIMPFileInfo;
  TAIMPFileInfo = packed record
    StructSize: DWORD; // SizeOf(TAIMPFileInfo)
    //
    Active: LongBool;
    BitRate: DWORD;
    Channels: DWORD;
    Duration: DWORD;
    FileSize: Int64;
    Mark: DWORD;
    SampleRate: DWORD;
    TrackNumber: DWORD;
    //
    AlbumBufferSizeInChars: DWORD;
    ArtistBufferSizeInChars: DWORD;
    DateBufferSizeInChars: DWORD;
    FileNameBufferSizeInChars: DWORD;
    GenreBufferSizeInChars: DWORD;
    TitleBufferSizeInChars: DWORD;
    //
    AlbumBuffer: PWideChar;
    ArtistBuffer: PWideChar;
    DateBuffer: PWideChar;
    FileNameBuffer: PWideChar;
    GenreBuffer: PWideChar;
    TitleBuffer: PWideChar;
  end;

procedure FileInfoClear(AInfo: PAIMPFileInfo);
function FileInfoIsValid(AInfo: PAIMPFileInfo): Boolean;
implementation

procedure FileInfoClearBuffer(ABuffer: PWideChar; ASizeInChars: Integer);
begin
  if ABuffer <> nil then
    ZeroMemory(ABuffer, ASizeInChars * SizeOf(WideChar));
end;

procedure FileInfoClear(AInfo: PAIMPFileInfo);
begin
  if FileInfoIsValid(AInfo) then
  begin
    AInfo.Active := False;
    AInfo.BitRate := 0;
    AInfo.Channels := 0;
    AInfo.Duration := 0;
    AInfo.FileSize := 0;
    AInfo.Mark := 0;
    AInfo.SampleRate := 0;
    AInfo.TrackNumber := 0;

    FileInfoClearBuffer(AInfo.AlbumBuffer, AInfo.AlbumBufferSizeInChars);
    FileInfoClearBuffer(AInfo.ArtistBuffer, AInfo.ArtistBufferSizeInChars);
    FileInfoClearBuffer(AInfo.DateBuffer, AInfo.DateBufferSizeInChars);
    FileInfoClearBuffer(AInfo.FileNameBuffer, AInfo.FileNameBufferSizeInChars);
    FileInfoClearBuffer(AInfo.GenreBuffer, AInfo.GenreBufferSizeInChars);
    FileInfoClearBuffer(AInfo.TitleBuffer, AInfo.TitleBufferSizeInChars);
  end;
end;

function FileInfoIsValid(AInfo: PAIMPFileInfo): Boolean;
begin
  try
    Result := Assigned(AInfo) and not IsBadReadPtr(AInfo, 4) and (AInfo^.StructSize = SizeOf(TAIMPFileInfo));
  except
    Result := False
  end;
end;

end.
