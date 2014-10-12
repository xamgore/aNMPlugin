unit AIMPSDKCommon;

{************************************************}
{*                                              *}
{*                AIMP Plugins API              *}
{*             v3.00.960 (01.12.2011)           *}
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

type
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
    AlbumLength: DWORD;
    ArtistLength: DWORD;
    DateLength: DWORD;
    FileNameLength: DWORD;
    GenreLength: DWORD;
    TitleLength: DWORD;
    //
    Album: PWideChar;
    Artist: PWideChar;
    Date: PWideChar;
    FileName: PWideChar;
    Genre: PWideChar;
    Title: PWideChar;
  end;

implementation

end.
