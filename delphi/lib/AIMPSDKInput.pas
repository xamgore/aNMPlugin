unit AIMPSDKInput;

{************************************************}
{*                                              *}
{*                AIMP Plugins API              *}
{*             v3.00.960 (01.12.2011)           *}
{*                 Input Plugins                *}
{*                                              *}
{*              (c) Artem Izmaylov              *}
{*                 www.aimp.ru                  *}
{*             Mail: artem@aimp.ru              *}
{*              ICQ: 345-908-513                *}
{*                                              *}
{************************************************}

interface

uses
  Windows, AIMPSDKCommon;

const
  AIMP_INPUT_BITDEPTH_08BIT      = 1;
  AIMP_INPUT_BITDEPTH_16BIT      = 2;
  AIMP_INPUT_BITDEPTH_24BIT      = 3;
  AIMP_INPUT_BITDEPTH_32BIT      = 4;
  AIMP_INPUT_BITDEPTH_32BITFLOAT = 5;
  AIMP_INPUT_BITDEPTH_64BITFLOAT = 6;

  AIMP_INPUT_FLAG_FILE           = 1; // IAIMPInputHeader.CreateDecoder supports
  AIMP_INPUT_FLAG_ISTREAM        = 2; // IAIMPInputHeader.CreateDecoderEx supports

const
  SID_IAIMPInputStream        = '{41494D50-0033-494E-0000-000000000010}';
  SID_IAIMPInputPluginDecoder = '{41494D50-0033-494E-0000-000000000020}';

  IID_IAIMPInputStream: TGUID = SID_IAIMPInputStream;
  IID_IAIMPInputPluginDecoder: TGUID = SID_IAIMPInputPluginDecoder;

type

  { IAIMPInputStream }

  IAIMPInputStream = interface(IUnknown)
  [SID_IAIMPInputStream]
    function GetSize: Int64; stdcall;
    function GetPosition: Int64; stdcall;
    function SetPosition(const AValue: Int64): Int64; stdcall;
    function ReadData(Buffer: PByte; Size: Integer): Integer; stdcall;
    function Skip(const ABytes: Int64): Int64; stdcall;
  end;

  { IAIMPInputPluginDecoder }

  IAIMPInputPluginDecoder = interface(IUnknown)
  [SID_IAIMPInputPluginDecoder]
    // Read Info about stream, ABitDepth: See AIMP_INPUT_BITDEPTH_XXX flags
    function DecoderGetInfo(out ASampleRate, AChannels, ABitDepth: Integer): LongBool; stdcall;
    // Uncompressed stream position in Bytes
    function DecoderGetPosition: Int64; stdcall;
    // Uncompressed stream size in Bytes
    function DecoderGetSize: Int64; stdcall;
    // Read Info about the file
    function DecoderGetTags(AFileInfo: PAIMPFileInfo): LongBool; stdcall;
    // Size of Buffer in Bytes
    function DecoderRead(Buffer: PByte; Size: Integer): Integer; stdcall;
    // Uncompressed stream position in Bytes
    function DecoderSetPosition(const AValue: Int64): LongBool; stdcall;
    // Is DecoderSetPosition supports?
    function DecoderIsSeekable: LongBool; stdcall;
    // Is speed, tempo and etc supports?
    // RealTime streams doesn't supports speed control
    function DecoderIsRealTimeStream: LongBool; stdcall;
    // Return format type for current file, (MP3, OGG, AAC+, FLAC and etc)
    function DecoderGetFormatType: PWideChar; stdcall;
  end;

  { IAIMPInputPluginHeader }

  IAIMPInputPluginHeader = interface(IUnknown)
    function GetPluginAuthor: PWideChar; stdcall;
    function GetPluginInfo: PWideChar; stdcall;
    function GetPluginName: PWideChar; stdcall;
    // Combination of the flags, See AIMP_INPUT_FLAG_XXX
    function GetPluginFlags: DWORD; stdcall;
    // Initialize / Finalize Plugin
    function Initialize: LongBool; stdcall;
    function Finalize: LongBool; stdcall;
    // Create decoder for the file / Stream
    function CreateDecoder(AFileName: PWideChar; out ADecoder: IAIMPInputPluginDecoder): LongBool; stdcall;
    function CreateDecoderEx(AStream: IAIMPInputStream; out ADecoder: IAIMPInputPluginDecoder): LongBool; stdcall;
    // Get FileInfo
    function GetFileInfo(AFileName: PWideChar; AFileInfo: PAIMPFileInfo): LongBool; stdcall;
    // Return string format: "My Custom Format1|*.fmt1;*.fmt2;|"
    function GetSupportsFormats: PWideChar; stdcall;
  end;

  TAIMPInputPluginHeaderProc = function (out AHeader: IAIMPInputPluginHeader): LongBool; stdcall;
  // Export function name: AIMP_QueryInput

implementation

end.
