unit AIMPSDKAddons;

{************************************************}
{*                                              *}
{*                AIMP Plugins API              *}
{*             v3.55.1290 (03.09.2013)          *}
{*                 Addons Plugins               *}
{*                                              *}
{*              (c) Artem Izmaylov              *}
{*                 www.aimp.ru                  *}
{*             Mail: artem@aimp.ru              *}
{*              ICQ: 345-908-513                *}
{*                                              *}
{************************************************}

// WARNING! Addons API functions doesn't support multithreading

interface

uses
  Windows, AIMPSDKCore, AIMPSDKCommon, Messages;

const
  WM_AIMP_LANG_CHANGED = WM_USER + 101;

  // IAIMPAddonPlugin.GetPluginFlags
  AIMP_ADDON_FLAGS_HAS_DIALOG = 1;

  // TAIMPMenuItemInfo.Flags
  AIMP_MENUITEM_CHECKBOX   = 1;
  AIMP_MENUITEM_CHECKED    = 2;
  AIMP_MENUITEM_ENABLED    = 4;
  AIMP_MENUITEM_RADIOITEM  = 8;

  // IAIMPAddonsMenuManager.MenuCreate, MenuIDs
  AIMP_MENUID_MAIN_OPTIONS   = 0;
  AIMP_MENUID_MAIN_FUNCTION  = 2;
  AIMP_MENUID_MAIN_CONFIGS   = 3;
  AIMP_MENUID_UTILITIES      = 4;
  AIMP_MENUID_PLS_ADD        = 5;
  AIMP_MENUID_PLS_JUMP       = 6;
  AIMP_MENUID_PLS_FNC        = 7;
  AIMP_MENUID_PLS_SEND       = 8;
  AIMP_MENUID_PLS_DEL        = 9;
  AIMP_MENUID_ADD            = 10;
  AIMP_MENUID_DEL            = 11;
  AIMP_MENUID_SORT           = 13;
  AIMP_MENUID_MISC           = 14;
  AIMP_MENUID_PLS            = 15;
  AIMP_MENUID_TRAY           = 17;
  AIMP_MENUID_EQ_LIB         = 18;

  // PropertyIDs for IAIMPAddonsPlaylistManager.EntryPropertyGetValue / EntryPropertySetValue
  AIMP_PLAYLIST_ENTRY_PROPERTY_DISPLAYTEXT                = 0;  // READONLY! ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
  AIMP_PLAYLIST_ENTRY_PROPERTY_FILENAME                   = 1;  // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
  AIMP_PLAYLIST_ENTRY_PROPERTY_INFO                       = 2;  // ABuffer: Pointer to TAIMPFileInfo, ABufferSize: size of TAIMPFileInfo structure
  AIMP_PLAYLIST_ENTRY_PROPERTY_PLAYINGSWITCH              = 3;  // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_ENTRY_PROPERTY_STATISTICS                 = 4;  // READONLY! ABuffer: Pointer to TAIMPFileStatisticsInfo, ABufferSize: size of TAIMPFileStatisticsInfo structure
  AIMP_PLAYLIST_ENTRY_PROPERTY_MARK                       = 5;  // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
  AIMP_PLAYLIST_ENTRY_PROPERTY_INDEX                      = 6;  // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
  AIMP_PLAYLIST_ENTRY_PROPERTY_SELECTED                   = 7;  // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)

  // PropertyIDs for IAIMPAddonsPlaylistManager.StoragePropertyGetValue / StoragePropertySetValue
  AIMP_PLAYLIST_STORAGE_PROPERTY_NAME                     = 0;  // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
  AIMP_PLAYLIST_STORAGE_PROPERTY_READONLY                 = 1;  // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_GROUPPING                = 10; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_GROUPPING_OVERRIDEN      = 11; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_GROUPPING_TEMPLATE       = 12; // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
  AIMP_PLAYLIST_STORAGE_PROPERTY_GROUPPING_AUTOMERGING    = 13; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_FORMATING_OVERRIDEN      = 20; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_FORMATING_LINE1_TEMPLATE = 21; // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
  AIMP_PLAYLIST_STORAGE_PROPERTY_FORMATING_LINE2_TEMPLATE = 22; // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
  AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_OVERRIDEN           = 30; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_DURATION            = 31; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_EXPAND_BUTTONS      = 32; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_MARKS               = 33; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_NUMBERS             = 34; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_NUMBERS_ABSOLUTE    = 35; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_SECOND_LINE         = 36; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_SWITCHES            = 37; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_STORAGE_PROPERTY_FOCUSINDEX               = 50; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
  AIMP_PLAYLIST_STORAGE_PROPERTY_TRACKINGINDEX            = 51; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
  AIMP_PLAYLIST_STORAGE_PROPERTY_DURATION                 = 52; // READONLY! ABuffer: Pointer to Int64 (64-bit Integer), ABufferSize: SizeOf(Int64)
  AIMP_PLAYLIST_STORAGE_PROPERTY_SIZE                     = 53; // READONLY! ABuffer: Pointer to Int64 (64-bit Integer), ABufferSize: SizeOf(Int64)
  AIMP_PLAYLIST_STORAGE_PROPERTY_PLAYINGINDEX             = 54; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
  AIMP_PLAYLIST_STORAGE_PROPERTY_PREIMAGE                 = 60; // [v3.10] ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes

  // IAIMPAddonsPlaylistManager.StorageSort
  AIMP_PLAYLIST_SORT_TYPE_TITLE      = 1;
  AIMP_PLAYLIST_SORT_TYPE_FILENAME   = 2;
  AIMP_PLAYLIST_SORT_TYPE_DURATION   = 3;
  AIMP_PLAYLIST_SORT_TYPE_ARTIST     = 4;
  AIMP_PLAYLIST_SORT_TYPE_INVERSE    = 5;
  AIMP_PLAYLIST_SORT_TYPE_RANDOMIZE  = 6;

  // IAIMPAddonsPlaylistManager.StorageGetFiles:
  AIMP_PLAYLIST_GETFILES_VISIBLE  = 1; // Files from collapsed groups will be excluded from list
  AIMP_PLAYLIST_GETFILES_SELECTED = 2; // Only selected files will be processed

  // IAIMPAddonsPlaylistManager.ElementGetType
  AIMP_PLAYLIST_ELEMENT_TYPE_UNKNOWN = 0;
  AIMP_PLAYLIST_ELEMENT_TYPE_ENTRY   = 1;
  AIMP_PLAYLIST_ELEMENT_TYPE_GROUP   = 2;

  // IAIMPAddonsPlaylistManager.FormatString Flags
  AIMP_PLAYLIST_FORMAT_MODE_PREVIEW  = 1;
  AIMP_PLAYLIST_FORMAT_MODE_FILEINFO = 2;
  AIMP_PLAYLIST_FORMAT_MODE_CURRENT  = 3;

  // PropertyIDs for IAIMPAddonsPlaylistManager.GroupPropertyGetValue / GroupPropertySetValue
  AIMP_PLAYLIST_GROUP_PROPERTY_NAME     = 0;  // READONLY! ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
  AIMP_PLAYLIST_GROUP_PROPERTY_EXPANDED = 1;  // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_PLAYLIST_GROUP_PROPERTY_DURATION = 2;  // READONLY! ABuffer: Pointer to Int64 (64-bit Integer), ABufferSize: SizeOf(Int64)
  AIMP_PLAYLIST_GROUP_PROPERTY_INDEX    = 3;  // [v3.10] READONLY! ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
  AIMP_PLAYLIST_GROUP_PROPERTY_SELECTED = 4;  // [v3.10] ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)

  // Flags for IAIMPAddonsPlaylistManagerListener.StorageChanged
  AIMP_PLAYLIST_NOTIFY_NAME           = 1;
  AIMP_PLAYLIST_NOTIFY_SELECTION      = 2;
  AIMP_PLAYLIST_NOTIFY_TRACKINGINDEX  = 4;
  AIMP_PLAYLIST_NOTIFY_PLAYINDEX      = 8;
  AIMP_PLAYLIST_NOTIFY_FOCUSINDEX     = 16;
  AIMP_PLAYLIST_NOTIFY_CONTENT        = 32;
  AIMP_PLAYLIST_NOTIFY_ENTRYINFO      = 64;
  AIMP_PLAYLIST_NOTIFY_STATISTICS     = 128;
  AIMP_PLAYLIST_NOTIFY_PLAYINGSWITCHS = 256;
  AIMP_PLAYLIST_NOTIFY_READONLY       = 512;   // [v3.10]
  AIMP_PLAYLIST_NOTIFY_PREIMAGE       = 1024;  // [v3.10]

  // [v3.50]
  // Flags for IAIMPAddonsActionManager.ActionPropertyGetValue / ActionPropertySetValue
  AIMP_ACTION_PROPERTY_NAME                 = 1; // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
  AIMP_ACTION_PROPERTY_GROUPNAME            = 2; // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
  AIMP_ACTION_PROPERTY_ENABLED              = 3; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
  AIMP_ACTION_PROPERTY_DEFAULTLOCALHOTKEY   = 4; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
  AIMP_ACTION_PROPERTY_DEFAULTGLOBALHOTKEY  = 5; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
  AIMP_ACTION_PROPERTY_DEFAULTGLOBALHOTKEY2 = 6; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)

  // [v3.50]
  // Flags for IAIMPAddonsActionManager.ActionMakeHotkey
  AIMP_ACTION_HOTKEY_MODIFIER_CTRL  = 1;
  AIMP_ACTION_HOTKEY_MODIFIER_ALT   = 2;
  AIMP_ACTION_HOTKEY_MODIFIER_SHIFT = 4;
  AIMP_ACTION_HOTKEY_MODIFIER_WIN   = 8;

  // AConfigPathIDs for IAIMPAddonsPlayerManager.ConfigGetPath
  AIMP_CFG_PATH_PROFILE      = 0;
  AIMP_CFG_PATH_PLS          = 1;
  AIMP_CFG_PATH_LNG          = 2;
  AIMP_CFG_PATH_SKINS        = 3;
  AIMP_CFG_PATH_SKINS_COMMON = 11; // [v3.10]
  AIMP_CFG_PATH_PLUGINS      = 4;
  AIMP_CFG_PATH_ICONS        = 5;
  AIMP_CFG_PATH_MODULES      = 8;
  AIMP_CFG_PATH_HELP         = 9;
  AIMP_CFG_PATH_ML           = 6;

  // AFlags for IAIMPAddonsPlayerManager.SupportsExts
  AIMP_SUPPORTS_EXTS_FORMAT_AUDIO    = 2;
  AIMP_SUPPORTS_EXTS_FORMAT_PLAYLIST = 1;

const
  SID_IAIMPAddonsConfigFile = '{41494D50-0033-434F-5245-000000000010}';
  SID_IAIMPAddonsCoverArtManager = '{41494D50-0033-434F-5245-000000000011}';
  SID_IAIMPAddonsLanguageFile = '{41494D50-0033-434F-5245-000000000012}';
  SID_IAIMPAddonsMenuManager = '{41494D50-0033-434F-5245-000000000013}';
  SID_IAIMPAddonsOptionsDialog = '{41494D50-0033-434F-5245-000000000014}';
  SID_IAIMPAddonsPlayerManager = '{41494D50-0033-434F-5245-000000000015}';
  SID_IAIMPAddonsPlaylistManager = '{41494D50-0033-434F-5245-000000000016}';
  SID_IAIMPAddonsPlaylistManagerListener = '{41494D50-0033-434F-5245-000000000017}';
  SID_IAIMPAddonsPlaylistStrings = '{41494D50-0033-434F-5245-000000000018}';
  SID_IAIMPAddonsSkinsManager = '{41494D50-0033-434F-5245-000000000019}';
  SID_IAIMPAddonsProxySettings = '{41494D50-0033-434F-5245-000000000020}';
  SID_IAIMPAddonsPlaylistManager2 = '{41494D50-0033-434F-5245-000000000021}'; // [v3.10]
  SID_IAIMPAddonsPlaylistQueue = '{41494D50-0033-434F-5245-000000000022}'; // [v3.10]
  SID_IAIMPAddonsAudioLib = '{41494D50-0033-434F-5245-000000000024}'; // [v3.50]
  SID_IAIMPAddonsActionManager = '{41494D50-0033-434F-5245-000000000025}'; // [v3.50]
  SID_IAIMPAddonsMenuManager2 = '{41494D50-0033-434F-5245-000000000026}'; // [v3.50]
  SID_IAIMPAddonsPlayerManager2 = '{41494D50-0033-434F-5245-000000000027}'; // [v3.51]

  IID_IAIMPAddonsActionManager: TGUID = SID_IAIMPAddonsActionManager;
  IID_IAIMPAddonsConfigFile: TGUID = SID_IAIMPAddonsConfigFile;
  IID_IAIMPAddonsCoverArtManager: TGUID = SID_IAIMPAddonsCoverArtManager;
  IID_IAIMPAddonsLanguageFile: TGUID = SID_IAIMPAddonsLanguageFile;
  IID_IAIMPAddonsAudioLib: TGUID = SID_IAIMPAddonsAudioLib;
  IID_IAIMPAddonsMenuManager: TGUID = SID_IAIMPAddonsMenuManager;
  IID_IAIMPAddonsMenuManager2: TGUID = SID_IAIMPAddonsMenuManager2;
  IID_IAIMPAddonsOptionsDialog: TGUID = SID_IAIMPAddonsLanguageFile;
  IID_IAIMPAddonsPlayerManager: TGUID = SID_IAIMPAddonsPlayerManager;
  IID_IAIMPAddonsPlayerManager2: TGUID = SID_IAIMPAddonsPlayerManager2;
  IID_IAIMPAddonsPlaylistManager: TGUID = SID_IAIMPAddonsPlaylistManager;
  IID_IAIMPAddonsPlaylistManager2: TGUID = SID_IAIMPAddonsPlaylistManager2;
  IID_IAIMPAddonsPlaylistManagerListener: TGUID = SID_IAIMPAddonsPlaylistManagerListener;
  IID_IAIMPAddonsPlaylistQueue: TGUID = SID_IAIMPAddonsPlaylistQueue;
  IID_IAIMPAddonsPlaylistStrings: TGUID = SID_IAIMPAddonsPlaylistStrings;
  IID_IAIMPAddonsProxySettings: TGUID = SID_IAIMPAddonsProxySettings;
  IID_IAIMPAddonsSkinsManager: TGUID = SID_IAIMPAddonsSkinsManager;

type
  HAIMPACTION = type Pointer;
  HAIMPMENU = type Pointer;

  HPLS = type Pointer;
  HPLSELEMENT = type Pointer;
  HPLSENTRY = type Pointer;
  HPLSGROUP = type Pointer;

const
  // Universal Handle for Active Playlist
  ActivePlaylistHandle = HPLS(-1);

type
  TAIMPActionProc = procedure (UserData: Pointer; ID: Integer; Handle: HAIMPACTION); stdcall;

  { TAIMPMenuItemInfo }

  TAIMPMenuProc = procedure (UserData: Pointer; Handle: HAIMPMENU); stdcall;

  // refer to IAIMPAddonsMenuManager
  PAIMPMenuItemInfo = ^TAIMPMenuItemInfo;
  TAIMPMenuItemInfo = packed record
    StructSize: DWORD; // SizeOf(TAIMPMenuItemInfo)
    Bitmap: HBITMAP;   // 0 - no glyph
    Caption: PWideChar;
    Flags: DWORD;   // Combination of AIMP_MENUITEM_XXX flags
    Proc: TAIMPMenuProc;
    ShortCut: DWORD; // Obsolete, use HAIMPACTION instead (see IAIMPAddonsActionManager)
    UserData: Pointer; // User parameter for Proc callback event
  end;

  { TAIMPFileStatisticsInfo }

  PAIMPFileStatisticsInfo = ^TAIMPFileStatisticsInfo;
  TAIMPFileStatisticsInfo = packed record
    AddingTime: TDateTime;
    LastPlayTime: TDateTime;
    Mark: Double;
    PlayCount: Integer;
    Rating: Double; // Rating = file_play_count / max_play_count_in_db
  end;

  { TAIMPSkinInfo }

  PAIMPSkinInfo = ^TAIMPSkinInfo;
  TAIMPSkinInfo = packed record
    StructSize: DWORD; // SizeOf(TAIMPSkinInfo)
    AuthorBuffer: PWideChar;
    AuthorBufferSizeInChars: DWORD;
    InfoBuffer: PWideChar;
    InfoBufferSizeInChars: DWORD;
    NameBuffer: PWideChar;
    NameBufferSizeInChars: DWORD;
    Preview: HBITMAP;
  end;

  TAIMPAddonsPlaylistManagerCompareProc = function (AFileInfo1, AFileInfo2: PAIMPFileInfo; AUserData: Pointer): Integer; stdcall;
  TAIMPAddonsPlaylistManagerDeleteProc = function (AFileInfo: PAIMPFileInfo; AUserData: Pointer): LongBool; stdcall;

  { IAIMPAddonsOptionsDialogFrame }

  // Must be implemented by Plugin
  IAIMPAddonsOptionsDialogFrame = interface(IUnknown)
    function FrameCreate(AParentWindow: HWND): HWND; stdcall;
    function FrameData: Pointer; stdcall; // unused
    function FrameFlags: Integer; stdcall; // unused
    function FrameName: PWideChar; stdcall;
    procedure FrameFree(AWindow: HWND); stdcall;
    procedure FrameLoadConfigNotify; stdcall;
    procedure FrameSaveConfigNotify; stdcall;
  end;

  { IAIMPAddonsOptionsDialog }

  IAIMPAddonsOptionsDialog = interface(IUnknown)
  [SID_IAIMPAddonsOptionsDialog]
    // Add custom frame
    function FrameAdd(AFrame: IAIMPAddonsOptionsDialogFrame): HRESULT; stdcall;
    // Remove custom frame
    function FrameRemove(AFrame: IAIMPAddonsOptionsDialogFrame): HRESULT; stdcall;
    // Call this method, when something changed on your frame
    function FrameModified(AFrame: IAIMPAddonsOptionsDialogFrame): HRESULT; stdcall;
    // AForceShow - Execute Options Dialog, if dialog is not shown
    function FrameShow(AFrame: IAIMPAddonsOptionsDialogFrame; AForceShow: LongBool): HRESULT; stdcall;
  end;

  { IAIMPAddonsFileInfoRepository }

  // Must be implemented by Plugin
  IAIMPAddonsFileInfoRepository = interface(IUnknown)
    // You can fill custom info for AFile using AInfo property
    // If you has processed request, return S_OK
    function GetInfo(AFile: PWideChar; AInfo: PAIMPFileInfo): HRESULT; stdcall;
  end;

  { IAIMPAddonsPlayingQueueController }

  // Must be implemented by Plugin
  IAIMPAddonsPlayingQueueController = interface(IUnknown)
    // [In\Out] params
    // In: Current Playlist ID & EntryIndex
    // Out: Next / Previous Playlist ID & EntryIndex
    // Notes:
    //   If previous controller has processed request, you don't receive it
    //   return S_OK if you has processed request or E_FAIL otherwise
    // Priorities:
    //   1) Queue
    //   2) Plugins
    //   3) Shuffle Manager
    //   4) Playlist
    function GetFile(var ID: HPLS; var AEntryIndex: Integer; ANext: LongBool): HRESULT; stdcall;
  end;

  { IAIMPAddonsConfigFile }

  IAIMPAddonsConfigFile = interface(IUnknown)
  [SID_IAIMPAddonsConfigFile]
    // functions returns S_OK, if value exists in configuration file
    function ReadString(ASectionName, AItemName, AValueBuffer: PWideChar;
      ASectionNameSizeInChars, AItemNameSizeInChars, AValueBufferSizeInChars: Integer): HRESULT; stdcall;
    function ReadInteger(ASectionName, AItemName: PWideChar;
      ASectionNameSizeInChars, AItemNameSizeInChars: Integer; out AValue: Integer): HRESULT; stdcall;
    function WriteString(ASectionName, AItemName, AValueBuffer: PWideChar;
      ASectionNameSizeInChars, AItemNameSizeInChars, AValueBufferSizeInChars: Integer): HRESULT; stdcall;
    function WriteInteger(ASectionName, AItemName: PWideChar;
      ASectionNameSizeInChars, AItemNameSizeInChars: Integer; AValue: Integer): HRESULT; stdcall;
    function SectionExists(ASectionName: PWideChar; ASectionNameSizeInChars: Integer): HRESULT; stdcall;
    function SectionRemove(ASectionName: PWideChar; ASectionNameSizeInChars: Integer): HRESULT; stdcall;
  end;

  { IAIMPAddonsLanguageFile }

  IAIMPAddonsLanguageFile = interface(IUnknown)
  [SID_IAIMPAddonsLanguageFile]
    function Version: Integer; stdcall;
    function CurrentFile(ABuffer: PWideChar; ABufferSizeInChars: Integer): Integer; stdcall;
    function SectionExists(ASectionName: PWideChar; ASectionNameSizeInChars: Integer): HRESULT; stdcall;
    function ReadString(ASectionName, AItemName, AValueBuffer: PWideChar;
      ASectionNameSizeInChars, AItemNameSizeInChars, AValueBufferSizeInChars: Integer): HRESULT; stdcall;
    // When Language changed AIMP will send to WndHandle "WM_AIMP_LANG_CHANGED" message
    function Notification(AWndHandle: HWND; ARegister: LongBool): HRESULT; stdcall;
  end;

  { IAIMPAddonsMenuManager }

  IAIMPAddonsMenuManager = interface(IUnknown)
  [SID_IAIMPAddonsMenuManager]
    // AMenuID: see AIMP_MENUID_XXX
    function MenuCreate(AMenuID: DWORD; AItemInfo: PAIMPMenuItemInfo): HAIMPMENU; stdcall; 
    function MenuCreateEx(AParentMenu: HAIMPMENU; AItemInfo: PAIMPMenuItemInfo): HAIMPMENU; stdcall;
    // Deprecated, use IAIMPAddonsActionManager.ActionMakeHotkey instead
    function MenuTextToShortCut(ABuffer: PWideChar; ABufferSizeInChars: Integer): DWORD; stdcall;
    function MenuRemove(AHandle: HAIMPMENU): HRESULT; stdcall;
    function MenuUpdate(AHandle: HAIMPMENU; AItemInfo: PAIMPMenuItemInfo): HRESULT; stdcall;
  end;

  { IAIMPAddonsMenuManager2 }

  IAIMPAddonsMenuManager2 = interface(IAIMPAddonsMenuManager) // [v3.50]
  [SID_IAIMPAddonsMenuManager2]
    // set AActionHandle to nil to remove any action from specified menu item
    function MenuSetAction(AHandle: HAIMPMENU; AActionHandle: HAIMPACTION): HRESULT; stdcall;
  end;

  { IAIMPAddonsProxySettings }

  IAIMPAddonsProxySettings = interface(IUnknown)
  [SID_IAIMPAddonsProxySettings]
    // Receiving Proxy Server params in "server:port" format
    // Returns E_FAIL, if proxy doesn't use, and S_OK otherwise
    function GetProxyParams(AServerBuffer: PWideChar; AServerBufferSizeInChars: Integer): HRESULT; stdcall;
    // Receiving Proxy Server user autorization params
    // Returns E_FAIL, if proxy server or user authorization don't used
    function GetProxyAuthorizationParams(
      AUserNameBuffer: PWideChar; AUserNameBufferSizeInChars: Integer;
      AUserPassBuffer: PWideChar; AUserPassBufferSizeInChars: Integer): HRESULT; stdcall;
  end;

  { IAIMPAddonsPlaylistStrings }

  IAIMPAddonsPlaylistStrings = interface(IUnknown)
  [SID_IAIMPAddonsPlaylistStrings]
    function ItemAdd(AFileName: PWideChar; AInfo: PAIMPFileInfo): HRESULT; stdcall;
    function ItemGetCount: Integer; stdcall;
    function ItemGetFileName(AIndex: Integer; ABuffer: PWideChar; ABufferSizeInChars: Integer): HRESULT; stdcall;
    function ItemGetInfo(AIndex: Integer; AInfo: PAIMPFileInfo): HRESULT; stdcall;
  end;

  { IAIMPAddonsPlaylistManagerListener }

  // must be implemented by plugin
  IAIMPAddonsPlaylistManagerListener = interface(IUnknown)
  [SID_IAIMPAddonsPlaylistManagerListener]
    procedure StorageActivated(ID: HPLS); stdcall;
    procedure StorageAdded(ID: HPLS); stdcall;
	  // AFlags - combination of AIMP_PLAYLIST_NOTIFY_XXX
    procedure StorageChanged(ID: HPLS; AFlags: DWORD); stdcall;
    procedure StorageRemoved(ID: HPLS); stdcall;
  end;

  { IAIMPAddonsPlaylistManager }

  // See ActivePlaylistHandle constant
  IAIMPAddonsPlaylistManager = interface(IUnknown)
  [SID_IAIMPAddonsPlaylistManager]
    // AIMP_PLAYLIST_FORMAT_MODE_PREVIEW  - template will be expand as preview
    // AIMP_PLAYLIST_FORMAT_MODE_FILEINFO - put to AData param pointer to TAIMPFileInfo struct
    // AIMP_PLAYLIST_FORMAT_MODE_CURRENT  - format current file info
    // AString buffer will be automaticly freed, you must make copy
    function FormatString(ATemplate: PWideChar; ATemplateSizeInChars: Integer;
      AMode: Integer; AData: Pointer; out AString: PWideChar): HRESULT; stdcall;
    // Listeners
    function ListenerAdd(AListener: IAIMPAddonsPlaylistManagerListener): HRESULT; stdcall;
    function ListenerRemove(AListener: IAIMPAddonsPlaylistManagerListener): HRESULT; stdcall;
    // See AIMP_PLAYLIST_ENTRY_PROPERTY_XXX
    function EntryDelete(AEntry: HPLSENTRY): HRESULT; stdcall;
    function EntryGetGroup(AEntry: HPLSENTRY; out AGroup: HPLSGROUP): HRESULT; stdcall;
    function EntryPropertyGetValue(AEntry: HPLSENTRY; APropertyID: Integer; ABuffer: Pointer; ABufferSize: Integer): HRESULT; stdcall;
    function EntryPropertySetValue(AEntry: HPLSENTRY; APropertyID: Integer; ABuffer: Pointer; ABufferSize: Integer): HRESULT; stdcall;
    function EntryReloadInfo(AEntry: HPLSENTRY): HRESULT; stdcall;
    // See AIMP_PLAYLIST_GROUP_PROPERTY_XXX
    function GroupPropertyGetValue(AGroup: HPLSGROUP; APropertyID: Integer; ABuffer: Pointer; ABufferSize: Integer): HRESULT; stdcall;
    function GroupPropertySetValue(AGroup: HPLSGROUP; APropertyID: Integer; ABuffer: Pointer; ABufferSize: Integer): HRESULT; stdcall;
    // Storages
    function StorageActiveGet: HPLS; stdcall;
    function StorageActiveSet(ID: HPLS): HRESULT; stdcall;
    function StorageAddEntries(ID: HPLS; AObjects: IAIMPAddonsPlaylistStrings): HRESULT; stdcall; // Add Objects to playlist. "Objects" can contains: shortcuts, files, folder, playlists
    function StorageCreate(AName: PWideChar; AActivate: LongBool): HPLS; stdcall;
    function StorageCreateFromFile(AFileName: PWideChar; AActivate, AStartPlay: LongBool): HPLS; stdcall;
    function StoragePlayingGet: HPLS; stdcall;
    // Content
    function StorageGet(AIndex: Integer): HPLS; stdcall;
    function StorageGetCount: Integer; stdcall; // Count of loaded playlists
    function StorageGetEntry(ID: HPLS; AEntryIndex: Integer): HPLSENTRY; stdcall;
    function StorageGetEntryCount(ID: HPLS): Integer; stdcall;
    function StorageGetFiles(ID: HPLS; AFlags: Integer; out AFiles: IAIMPAddonsPlaylistStrings): HRESULT; stdcall; // Flags: Use combination of the AIMP_PLAYLIST_GETFILES_XXX flags
    function StorageGetGroup(ID: HPLS; AGroupIndex: Integer): HPLSGROUP; stdcall;
    function StorageGetGroupCount(ID: HPLS): Integer; stdcall;
    // Removing
    function StorageDelete(ID: HPLS; AEntryIndex: Integer): HRESULT; stdcall;
    function StorageDeleteAll(ID: HPLS): HRESULT; stdcall;
    function StorageDeleteByFilter(ID: HPLS; APhysically: LongBool;
      AFilterProc: TAIMPAddonsPlaylistManagerDeleteProc; AUserData: Pointer): HRESULT; stdcall;
    function StorageRemove(ID: HPLS): HRESULT; stdcall; // Remove playlist storage from manager (like "close playlist")
    // Sorting
    function StorageSort(ID: HPLS; ASortType: Integer): HRESULT; stdcall; // Predefined Sorting, see AIMP_PLAYLIST_SORT_TYPE_XXX
    function StorageSortCustom(ID: HPLS; ACompareProc: TAIMPAddonsPlaylistManagerCompareProc; AUserData: Pointer): HRESULT; stdcall;
    function StorageSortTemplate(ID: HPLS; ABuffer: PWideChar; ABufferSizeInChars: Integer): HRESULT; stdcall;
    // Lock / Unlock playlist calculation and drawing
    function StorageBeginUpdate(ID: HPLS): HRESULT; stdcall;
    function StorageEndUpdate(ID: HPLS): HRESULT; stdcall;
    // See AIMP_PLAYLIST_STORAGE_PROPERTY_XXX
    function StoragePropertyGetValue(ID: HPLS; APropertyID: Integer; ABuffer: Pointer; ABufferSize: Integer): HRESULT; stdcall;
    function StoragePropertySetValue(ID: HPLS; APropertyID: Integer; ABuffer: Pointer; ABufferSize: Integer): HRESULT; stdcall;
    // Queue
    function QueueEntryAdd(AEntry: HPLSENTRY; AInsertAtQueueBegining: LongBool): HRESULT; stdcall;
    function QueueEntryRemove(AEntry: HPLSENTRY): HRESULT; stdcall;
  end;

  { IAIMPAddonsPlaylistManager2 }

  IAIMPAddonsPlaylistManager2 = interface(IAIMPAddonsPlaylistManager) // [v3.10]
  [SID_IAIMPAddonsPlaylistManager2]
    // Element
    function ElementGetType(AElement: HPLSELEMENT): Integer; stdcall;
    // Groups
    function GroupGetEntry(AGroup: HPLSGROUP; AIndex: Integer; out AEntry: HPLSENTRY): HRESULT; stdcall;
    function GroupGetEntryCount(AGroup: HPLSGROUP): Integer; stdcall;
    // Storage
    // HPLSELEMENT - HPLSENTRY or HPLSGROUP, use ElementGetType to determine the type of element
    function StorageFocusGet(ID: HPLS; out AElement: HPLSELEMENT): HRESULT; stdcall;
    function StorageFocusSet(ID: HPLS; AElement: HPLSELEMENT): HRESULT; stdcall;
    function StorageReloadFromPreimage(ID: HPLS): HRESULT; stdcall;
  end;

  { IAIMPAddonsPlaylistQueue }

  IAIMPAddonsPlaylistQueue = interface // [v3.10]
  [SID_IAIMPAddonsPlaylistQueue]
    function QueueEntryAdd(AEntry: HPLSENTRY; AInsertAtQueueBegining: LongBool): HRESULT; stdcall;
    function QueueEntryRemove(AEntry: HPLSENTRY): HRESULT; stdcall;
    function QueueEntryGet(Index: Integer; out AEntry: HPLSENTRY): HRESULT; stdcall;
    function QueueEntryGetCount: Integer; stdcall;
    function QueueEntryMove(AEntry: HPLSENTRY; ANewIndex: Integer): HRESULT; stdcall;
    function QueueEntryMove2(AOldIndex, ANewIndex: Integer): HRESULT; stdcall;
    function QueueSuspendedGet: LongBool; stdcall;
    function QueueSuspendedSet(AValue: LongBool): HRESULT; stdcall;
  end;

  { IAIMPAddonsCoverArtManager }

  IAIMPAddonsCoverArtManager = interface
  [SID_IAIMPAddonsCoverArtManager]
    // Picture will be proportional stretched to ADisplaySize value, if it assigned
    // AFileName - [in] Full file name for audio track
    // ACoverArtFileName - [out] buffer for cover art file name, can be nil;
  	//                     Filled only if cover art loaded from the separate file
    // ACoverArtFileNameBufferSizeInChars - [in] size of ACoverArtFileName buffer in chars (should be 0, if ACoverArtFileName = nil)
    function CoverArtGetForFile(AFileName: PWideChar; ADisplaySize: PSize;
      ACoverArtFileNameBuffer: PWideChar; ACoverArtFileNameBufferSizeInChars: Integer): HBITMAP; stdcall;
    // Work with CoverArt of playing file,
    // if file is playing and CoverArt exists, functions returns S_OK
    function CoverArtDraw(DC: HDC; const R: TRect): HRESULT; stdcall; // CoverArt will be proportional stretched to R value
    function CoverArtGetFileName(ABuffer: PWideChar; ABufferSizeInChars: Integer): HRESULT; stdcall;
    function CoverArtGetSize(out ASize: TSize): HRESULT; stdcall;
  end;

  { IAIMPAddonsPlayerManager }

  IAIMPAddonsPlayerManager = interface(IUnknown)
  [SID_IAIMPAddonsPlayerManager]
    function PlayEntry(AEntry: HPLSENTRY): HRESULT; stdcall;
    function PlayFile(AFileName: PWideChar; AFailIfNotExistsInPlaylist: LongBool): HRESULT; stdcall;
    function PlayStorage(ID: HPLS; AEntryIndex: Integer = -1): HRESULT; stdcall;
    // Register / Unregister custom FileInfo repository, you can put own info about the any file
    function FileInfoRepository(ARepository: IAIMPAddonsFileInfoRepository; ARegister: LongBool): HRESULT; stdcall;
    // if AFileName = nil: Get information about currently playing file
    function FileInfoQuery(AFileName: PWideChar; AInfo: PAIMPFileInfo): HRESULT; stdcall;
    // Register / Unregister custom playing queue controller
    function PlayingQueueController(AController: IAIMPAddonsPlayingQueueController; ARegister: LongBool): HRESULT; stdcall;
    // see AIMP_CFG_PATH_XXX
    function ConfigGetPath(AConfigPathID: Integer; ABuffer: PWideChar; ABufferSizeInChars: Integer): HRESULT; stdcall;
    // see AIMP_SUPPORTS_EXTS_XXX
    function SupportsExts(AFlags: DWORD; ABuffer: PWideChar; ABufferSizeInChars: Integer): HRESULT; stdcall;
  end;

  { IAIMPAddonsPlayerAsyncHook }

  // must be implemented by plugin
  // WARNING: Interface implementation must support multi-threaded access
  IAIMPAddonsPlayerAsyncHook = interface
  ['{99ABC21E-5AC9-4519-9417-DB524EDA7662}']
    function PreparingForRemoteTrackPlayback(ATrackURI: IAIMPString; var AHandled: LongBool): HRESULT; stdcall;
  end;

  { IAIMPAddonsPlayerManager2 }

  IAIMPAddonsPlayerManager2 = interface(IAIMPAddonsPlayerManager) // [v3.51]
  [SID_IAIMPAddonsPlayerManager2]
    // Note: AEntry can be NIL
    function PlayingQueueGetNextTrack(out AEntry: HPLSENTRY): HRESULT; stdcall;
    function PlayingQueueGetPrevTrack(out AEntry: HPLSENTRY): HRESULT; stdcall;

    function PlayingQueueRegisterHook(AHook: IAIMPAddonsPlayerAsyncHook): HRESULT; stdcall;
    function PlayingQueueUnregisterHook(AHook: IAIMPAddonsPlayerAsyncHook): HRESULT; stdcall;
  end;

  { IAIMPAddonsSkinsManager }

  IAIMPAddonsSkinsManager = interface(IUnknown)
  [SID_IAIMPAddonsSkinsManager]
    // AColorHue & AColorHueIntensity - optional, can be nil
    function GetCurrentSettings(ASkinLocalFileNameBuffer: PWideChar;
      ASkinLocalFileNameBufferSizeInChars: Integer; AColorHue, AColorHueIntensity: PInteger): HRESULT; stdcall;
    // Get Info about Skin
    // + Skin can be placed anywhere
    // + if AFileNameBuffer contains empty string - function return information about build-in skin
    // WARNING!!! You must manually destroy TAIMPSkinInfo.Preview if it no longer need
    function GetSkinInfo(AFileNameBuffer: PWideChar; AFileNameBufferSizeInChars: Integer; ASkinInfo: PAIMPSkinInfo): HRESULT;
    // Skin must be placed in %AIMP_Skins% directory (see IAIMPAddonsPlayerManager.ConfigGetPath)
    // AColorHue: [0..255], Default: 0 (don't change hue)
    // AColorHueIntensity [0..100], Default: 100 (don't change Hue Intensity), depends from AColorHue value
    function Select(ASkinLocalFileName: PWideChar; AColorHue, AColorHueIntensity: Integer): HRESULT; stdcall;
    // Conversion between HSL and RGB color spaces
    function HSLToRGB(H, S, L: Byte; out R, G, B: Byte): HRESULT; stdcall;
    function RGBToHSL(R, G, B: Byte; out H, S, L: Byte): HRESULT; stdcall;
  end;

  { IAIMPAddonsAudioLib }

  IAIMPAddonsAudioLib = interface(IUnknown) // [v3.50]
  [SID_IAIMPAddonsAudioLib]
    // AMark - mark for the specified file, [0.0 .. 5.0]
    // Function returns E_NOTIMPL if Audio Library is not installed
    function MarkGet(AFileNameBuffer: PWideChar; AFileNameBufferSizeInChars: Integer; out AMark: Single): HRESULT; stdcall;
    function MarkSet(AFileNameBuffer: PWideChar; AFileNameBufferSizeInChars: Integer; AMark: Single): HRESULT; stdcall;
    // Function receive information about the specified file from DataBase
    // To get statistics information about the file, you should:
    // + Set to ABuffer pointer to TAIMPFileStatisticsInfo struct
    // + Set to ABufferSize value equals to SizeOf(TAIMPFileStatisticsInfo)
    // Function returns E_NOTIMPL if Audio Library is not installed
    function InfoGet(AFileNameBuffer: PWideChar; AFileNameBufferSizeInChars: Integer; ABuffer: Pointer; ABufferSize: Integer): HRESULT; stdcall;
  end;

  { IAIMPAddonsActionManager }

  IAIMPAddonsActionManager = interface(IUnknown) // [v3.50]
  [SID_IAIMPAddonsActionManager]
    // AInstance - A handle to an instance of the plugin
    // ID - Unique action id for the plugin, it uses for save / restore information about the action from config
    // AProc - callback procedure
    // AUserData - user data for callback procedure
    function ActionCreate(AInstance: HINST; ID: Integer; AProc: TAIMPActionProc; AUserData: Pointer; out AHandle: HAIMPACTION): HRESULT; stdcall;
    // APropertyID - see AIMP_ACTION_PROPERTY_XXX
    function ActionPropertyGetValue(AHandle: HAIMPACTION; APropertyID: Integer; ABuffer: Pointer; ABufferSize: Integer): HRESULT; stdcall;
    function ActionPropertySetValue(AHandle: HAIMPACTION; APropertyID: Integer; ABuffer: Pointer; ABufferSize: Integer): HRESULT; stdcall;
    function ActionRemove(AHandle: HAIMPACTION): HRESULT; stdcall;
    // AModifiers - combination of AIMP_ACTION_HOTKEY_MODIFIER_XXX flags
    // AKey - virtual key code, see VK_XXX consts from Windows.pas
    function ActionMakeHotkey(AModifiers: Word; AKey: Word): DWORD; stdcall;
  end;

  { IAIMPAddonPlugin }

  // Must be implemented by Plugin
  IAIMPAddonPlugin = interface
    function GetPluginAuthor: PWideChar; stdcall;
    function GetPluginInfo: PWideChar; stdcall;
    function GetPluginName: PWideChar; stdcall;
    function GetPluginFlags: DWORD; stdcall; // See AIMP_ADDON_FLAGS_XXX
    function Initialize(ACoreUnit: IAIMPCoreUnit): HRESULT; stdcall;
    function Finalize: HRESULT; stdcall;
    function ShowSettingsDialog(AParentWindow: HWND): HRESULT; stdcall;
  end;

  TAIMPAddonPluginHeaderProc = function (out AHeader: IAIMPAddonPlugin): LongBool; stdcall;
  // Export function name: AIMP_QueryAddon3

implementation

end.
