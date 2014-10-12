/* ******************************************** */
/*                                              */
/*                AIMP Plugins API              */
/*             v3.55.1290 (03.09.2013)          */
/*                 Addons Plugins               */
/*                                              */
/*              (c) Artem Izmaylov              */
/*                 www.aimp.ru                  */
/*             Mail: artem@aimp.ru              */
/*              ICQ: 345-908-513                */
/*                                              */
/* ******************************************** */

// WARNING! Addons API functions doesn't support multi-threading

#ifndef AIMPSDKAddonsH
#define AIMPSDKAddonsH

#include <windows.h>
#include <unknwn.h>
#include "AIMPSDKCore.h"
#include "AIMPSDKCommon.h"

const int WM_AIMP_LANG_CHANGED = WM_USER + 101;

// IAIMPAddonPlugin.GetPluginFlags
const int AIMP_ADDON_FLAGS_HAS_DIALOG = 1;

// TAIMPMenuItemInfo.Flags
const int AIMP_MENUITEM_CHECKBOX   = 1;
const int AIMP_MENUITEM_CHECKED    = 2;
const int AIMP_MENUITEM_ENABLED    = 4;
const int AIMP_MENUITEM_RADIOITEM  = 8;

// IAIMPAddonsMenuManager.MenuCreate, MenuIDs
const int AIMP_MENUID_MAIN_OPTIONS   = 0;
const int AIMP_MENUID_MAIN_FUNCTION  = 2;
const int AIMP_MENUID_MAIN_CONFIGS   = 3;
const int AIMP_MENUID_UTILITIES      = 4;
const int AIMP_MENUID_PLS_ADD        = 5;
const int AIMP_MENUID_PLS_JUMP       = 6;
const int AIMP_MENUID_PLS_FNC        = 7;
const int AIMP_MENUID_PLS_SEND       = 8;
const int AIMP_MENUID_PLS_DEL        = 9;
const int AIMP_MENUID_ADD            = 10;
const int AIMP_MENUID_DEL            = 11;
const int AIMP_MENUID_SORT           = 13;
const int AIMP_MENUID_MISC           = 14;
const int AIMP_MENUID_PLS            = 15;
const int AIMP_MENUID_TRAY           = 17;
const int AIMP_MENUID_EQ_LIB         = 18;

// PropertyIDs for IAIMPAddonsPlaylistManager.EntryPropertyGetValue / EntryPropertySetValue
const int AIMP_PLAYLIST_ENTRY_PROPERTY_DISPLAYTEXT                = 0;  // READONLY! ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
const int AIMP_PLAYLIST_ENTRY_PROPERTY_FILENAME                   = 1;  // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
const int AIMP_PLAYLIST_ENTRY_PROPERTY_INFO                       = 2;  // ABuffer: Pointer to TAIMPFileInfo, ABufferSize: size of TAIMPFileInfo structure
const int AIMP_PLAYLIST_ENTRY_PROPERTY_PLAYINGSWITCH              = 3;  // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_ENTRY_PROPERTY_STATISTICS                 = 4;  // READONLY! ABuffer: Pointer to TAIMPFileStatisticsInfo, ABufferSize: size of TAIMPFileStatisticsInfo structure
const int AIMP_PLAYLIST_ENTRY_PROPERTY_MARK                       = 5;  // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
const int AIMP_PLAYLIST_ENTRY_PROPERTY_INDEX                      = 6;  // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
const int AIMP_PLAYLIST_ENTRY_PROPERTY_SELECTED                   = 7;  // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)

// PropertyIDs for IAIMPAddonsPlaylistManager.StoragePropertyGetValue / StoragePropertySetValue
const int AIMP_PLAYLIST_STORAGE_PROPERTY_NAME                     = 0;  // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
const int AIMP_PLAYLIST_STORAGE_PROPERTY_READONLY                 = 1;  // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_GROUPPING                = 10; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_GROUPPING_OVERRIDEN      = 11; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_GROUPPING_TEMPLATE       = 12; // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
const int AIMP_PLAYLIST_STORAGE_PROPERTY_GROUPPING_AUTOMERGING    = 13; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_FORMATING_OVERRIDEN      = 20; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_FORMATING_LINE1_TEMPLATE = 21; // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
const int AIMP_PLAYLIST_STORAGE_PROPERTY_FORMATING_LINE2_TEMPLATE = 22; // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
const int AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_OVERRIDEN           = 30; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_DURATION            = 31; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_EXPAND_BUTTONS      = 32; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_MARKS               = 33; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_NUMBERS             = 34; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_NUMBERS_ABSOLUTE    = 35; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_SECOND_LINE         = 36; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_VIEW_SWITCHES            = 37; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_FOCUSINDEX               = 50; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_TRACKINGINDEX            = 51; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_DURATION                 = 52; // READONLY! ABuffer: Pointer to Int64 (64-bit Integer), ABufferSize: SizeOf(Int64)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_SIZE                     = 53; // READONLY! ABuffer: Pointer to Int64 (64-bit Integer), ABufferSize: SizeOf(Int64)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_PLAYINGINDEX			  = 54; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
const int AIMP_PLAYLIST_STORAGE_PROPERTY_PREIMAGE                 = 60; // [v3.10]: ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes

// IAIMPAddonsPlaylistManager.ElementGetType
const int AIMP_PLAYLIST_ELEMENT_TYPE_UNKNOWN = 0;
const int AIMP_PLAYLIST_ELEMENT_TYPE_ENTRY   = 1;
const int AIMP_PLAYLIST_ELEMENT_TYPE_GROUP   = 2;

// IAIMPAddonsPlaylistManager.StorageSort
const int AIMP_PLAYLIST_SORT_TYPE_TITLE      = 1;
const int AIMP_PLAYLIST_SORT_TYPE_FILENAME   = 2;
const int AIMP_PLAYLIST_SORT_TYPE_DURATION   = 3;
const int AIMP_PLAYLIST_SORT_TYPE_ARTIST     = 4;
const int AIMP_PLAYLIST_SORT_TYPE_INVERSE    = 5;
const int AIMP_PLAYLIST_SORT_TYPE_RANDOMIZE  = 6;

// IAIMPAddonsPlaylistManager.StorageGetFiles:
const int AIMP_PLAYLIST_GETFILES_VISIBLE  = 1; // Files from collapsed groups will be excluded from list
const int AIMP_PLAYLIST_GETFILES_SELECTED = 2; // Only selected files will be processed

// IAIMPAddonsPlaylistManager.FormatString Flags
const int AIMP_PLAYLIST_FORMAT_MODE_PREVIEW  = 1;
const int AIMP_PLAYLIST_FORMAT_MODE_FILEINFO = 2;
const int AIMP_PLAYLIST_FORMAT_MODE_CURRENT  = 3;

// PropertyIDs for IAIMPAddonsPlaylistManager.GroupPropertyGetValue / GroupPropertySetValue
const int AIMP_PLAYLIST_GROUP_PROPERTY_NAME     = 0;  // READONLY! ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
const int AIMP_PLAYLIST_GROUP_PROPERTY_EXPANDED = 1;  // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_PLAYLIST_GROUP_PROPERTY_DURATION = 2;  // READONLY! ABuffer: Pointer to Int64 (64-bit Integer), ABufferSize: SizeOf(Int64)
const int AIMP_PLAYLIST_GROUP_PROPERTY_INDEX    = 3;  // [v3.10] READONLY! ABuffer: Pointer to Integer , ABufferSize: SizeOf(Integer)
const int AIMP_PLAYLIST_GROUP_PROPERTY_SELECTED = 4;  // [v3.10] ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)

// Flags for IAIMPAddonsPlaylistManagerListener.StorageChanged
const int AIMP_PLAYLIST_NOTIFY_NAME           = 1;
const int AIMP_PLAYLIST_NOTIFY_SELECTION      = 2;
const int AIMP_PLAYLIST_NOTIFY_TRACKINGINDEX  = 4;
const int AIMP_PLAYLIST_NOTIFY_PLAYINDEX      = 8;
const int AIMP_PLAYLIST_NOTIFY_FOCUSINDEX     = 16;
const int AIMP_PLAYLIST_NOTIFY_CONTENT        = 32;
const int AIMP_PLAYLIST_NOTIFY_ENTRYINFO      = 64;
const int AIMP_PLAYLIST_NOTIFY_STATISTICS     = 128;
const int AIMP_PLAYLIST_NOTIFY_PLAYINGSWITCHS = 256;
const int AIMP_PLAYLIST_NOTIFY_READONLY       = 512;   // [v3.10]
const int AIMP_PLAYLIST_NOTIFY_PREIMAGE       = 1024;  // [v3.10]


// [v3.50]
// Flags for IAIMPAddonsActionManager.ActionPropertyGetValue / ActionPropertySetValue
const int AIMP_ACTION_PROPERTY_NAME                 = 1; // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
const int AIMP_ACTION_PROPERTY_GROUPNAME            = 2; // ABuffer: Pointer to array of WideChar, ABufferSize: size of array in Bytes
const int AIMP_ACTION_PROPERTY_ENABLED              = 3; // ABuffer: Pointer to LongBool (32-bit Boolean), ABufferSize: SizeOf(LongBool)
const int AIMP_ACTION_PROPERTY_DEFAULTLOCALHOTKEY   = 4; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
const int AIMP_ACTION_PROPERTY_DEFAULTGLOBALHOTKEY  = 5; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)
const int AIMP_ACTION_PROPERTY_DEFAULTGLOBALHOTKEY2 = 6; // ABuffer: Pointer to Integer, ABufferSize: SizeOf(Integer)

// [v3.50]
// Flags for IAIMPAddonsActionManager.ActionMakeHotkey
const int AIMP_ACTION_HOTKEY_MODIFIER_CTRL  = 1;
const int AIMP_ACTION_HOTKEY_MODIFIER_ALT   = 2;
const int AIMP_ACTION_HOTKEY_MODIFIER_SHIFT = 4;
const int AIMP_ACTION_HOTKEY_MODIFIER_WIN   = 8;

// AConfigPathIDs for IAIMPAddonsPlayerManager.ConfigGetPath
const int AIMP_CFG_PATH_PROFILE  = 0;
const int AIMP_CFG_PATH_PLS      = 1;
const int AIMP_CFG_PATH_LNG      = 2;
const int AIMP_CFG_PATH_SKINS    = 3;
const int AIMP_CFG_PATH_SKINS_COMMON = 11; // [v3.10]
const int AIMP_CFG_PATH_PLUGINS  = 4;
const int AIMP_CFG_PATH_ICONS    = 5;
const int AIMP_CFG_PATH_ML       = 6;
const int AIMP_CFG_PATH_MODULES  = 8;
const int AIMP_CFG_PATH_HELP     = 9;
const int AIMP_CFG_PATH_ML_PLS   = 10; // not used in v3.10

// AFlags for IAIMPAddonsPlayerManager.SupportsExts
const int AIMP_SUPPORTS_EXTS_FORMAT_AUDIO    = 2;
const int AIMP_SUPPORTS_EXTS_FORMAT_PLAYLIST = 1;

static const GUID IID_IAIMPAddonsConfigFile	= {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10};
static const GUID IID_IAIMPAddonsCoverArtManager = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x11};
static const GUID IID_IAIMPAddonsLanguageFile  = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12};
static const GUID IID_IAIMPAddonsMenuManager = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x13};
static const GUID IID_IAIMPAddonsOptionsDialog = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14};
static const GUID IID_IAIMPAddonsPlayerManager = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15};
static const GUID IID_IAIMPAddonsPlaylistManager = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x16};
static const GUID IID_IAIMPAddonsPlaylistManagerListener = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x17};
static const GUID IID_IAIMPAddonsPlaylistStrings = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18};
static const GUID IID_IAIMPAddonsSkinsManager = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x19};
static const GUID IID_IAIMPAddonsProxySettings = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20};
static const GUID IID_IAIMPAddonsPlaylistManager2 = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x21}; // [v3.10]
static const GUID IID_IAIMPAddonsPlaylistQueue = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22}; // [v3.10]
static const GUID IID_IAIMPAddonsMediaBase = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x24}; // [v3.50]
static const GUID IID_IAIMPAddonsActionManager = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x25}; // [v3.50]
static const GUID IID_IAIMPAddonsMenuManager2 = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x26}; // [v3.50]
static const GUID IID_IAIMPAddonsPlayerManager2 = {0x41494D50, 0x0033, 0x434F, 0x52, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x27}; // [v3.51]

static const GUID IID_IAIMPAddonsPlayerAsyncHook = {0x99ABC21E, 0x5AC9, 0x4519, 0x94, 0x17, 0xDB, 0x52, 0x4E, 0xDA, 0x76, 0x62}; // [v3.51]

typedef void *HAIMPACTION;
typedef void *HAIMPMENU;
typedef void *HPLS;
typedef void *HPLSENTRY;
typedef void *HPLSGROUP;
typedef void *HPLSELEMENT;

// Universal Handle for Active Playlist
#define ActivePlaylistHandle HPLS(-1)

typedef void (WINAPI *TAIMPMenuProc)(void *UserData, HAIMPMENU Handle);
typedef int  (WINAPI *TAIMPAddonsPlaylistManagerCompareProc)(TAIMPFileInfo *AFileInfo1, TAIMPFileInfo *AFileInfo2, void *UserData);
typedef void (WINAPI *TAIMPActionProc)(void *UserData, int ID, HAIMPACTION Handle);
typedef BOOL (WINAPI *TAIMPAddonsPlaylistManagerDeleteProc) (TAIMPFileInfo *AFileInfo, void *AUserData);

#pragma pack(push, 1)

// refer to IAIMPAddonsMenuManager
struct TAIMPMenuItemInfo
{
    DWORD StructSize; // SizeOf(TAIMPMenuItemInfo)
    HBITMAP Bitmap;   // 0 - no glyph
    PWCHAR Caption;
    DWORD Flags;   // Combination of AIMP_MENUITEM_XXX flags
    TAIMPMenuProc Proc;
    DWORD ShortCut; // Obsolete, use HAIMPACTION instead (see IAIMPAddonsActionManager)
    void *UserData; // User parameter for Proc callback event
};

struct TAIMPFileStatisticsInfo
{
	double AddingTime;
	double LastPlayTime;
	double Mark;
	int PlayCount;
    double Rating; // Rating = file_play_count / max_play_count_in_db
};

struct TAIMPSkinInfo
{
    DWORD  StructSize; // SizeOf(TAIMPSkinInfo)
    PWCHAR AuthorBuffer;
	DWORD  AuthorBufferSizeInChars;
	PWCHAR InfoBuffer;
	DWORD  InfoBufferSizeInChars;
	PWCHAR NameBuffer;
	DWORD  NameBufferSizeInChars;
    HBITMAP Preview;
};


typedef TAIMPMenuItemInfo *PAIMPMenuItemInfo;
typedef TAIMPFileStatisticsInfo *PAIMPFileStatisticsInfo;
typedef TAIMPSkinInfo *PAIMPSkinInfo;
 
#pragma pack(pop)

/* IAIMPAddonsOptionsDialogFrame */
// Must be implemented by Plugin
class IAIMPAddonsOptionsDialogFrame: public IUnknown
{
	public:
		virtual HWND   WINAPI FrameCreate(HWND AParentWindow) = 0;
		virtual void * WINAPI FrameData() = 0; // unused
		virtual int    WINAPI FrameFlags() = 0; // unused
		virtual PWCHAR WINAPI FrameName() = 0;
		virtual void   WINAPI FrameFree(HWND AWindow) = 0;
		virtual void   WINAPI FrameLoadConfigNotify() = 0;
		virtual void   WINAPI FrameSaveConfigNotify() = 0;
};

/* IAIMPAddonsOptionsDialog */
class IAIMPAddonsOptionsDialog: public IUnknown
{
	public:
		// Add custom frame
		virtual HRESULT WINAPI FrameAdd(IAIMPAddonsOptionsDialogFrame *AFrame) = 0;
		// Remove custom frame
		virtual HRESULT WINAPI FrameRemove(IAIMPAddonsOptionsDialogFrame *AFrame) = 0;
		// Call this method, when something changed on your frame
		virtual HRESULT WINAPI FrameModified(IAIMPAddonsOptionsDialogFrame *AFrame) = 0;
		// AForceShow - Execute Options Dialog, if dialog is not shown
		virtual HRESULT WINAPI FrameShow(IAIMPAddonsOptionsDialogFrame *AFrame, BOOL AForceShow) = 0;
};

/* IAIMPAddonsFileInfoRepository */
// Must be implemented by Plugin
class IAIMPAddonsFileInfoRepository: public IUnknown
{
	public:
		// You can fill custom info for AFile using AInfo property
		// If you has processed request, return S_OK
		virtual HRESULT WINAPI GetInfo(PWCHAR AFile, TAIMPFileInfo *AInfo) = 0;
};

/* IAIMPAddonsPlayingQueueController */
// Must be implemented by Plugin
class IAIMPAddonsPlayingQueueController: public IUnknown
{
	public:
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
		virtual HRESULT WINAPI GetFile(HPLS *ID, int *AEntryIndex, BOOL ANext) = 0;
};

/* IAIMPAddonsConfigFile */
class IAIMPAddonsConfigFile: public IUnknown
{
	public:
		// functions returns S_OK, if value exists in configuration file
		virtual HRESULT WINAPI ReadString(PWCHAR ASectionName, PWCHAR AItemName, PWCHAR AValueBuffer,
			int ASectionNameSizeInChars, int AItemNameSizeInChars, int AValueBufferSizeInChars) = 0;
		virtual HRESULT WINAPI ReadInteger(PWCHAR ASectionName, PWCHAR AItemName,
			int ASectionNameSizeInChars, int AItemNameSizeInChars, int *AValue) = 0;
		virtual HRESULT WINAPI WriteString(PWCHAR ASectionName, PWCHAR AItemName, PWCHAR AValueBuffer,
			int ASectionNameSizeInChars, int AItemNameSizeInChars, int AValueBufferSizeInChars) = 0;
		virtual HRESULT WINAPI WriteInteger(PWCHAR ASectionName, PWCHAR AItemName,
			int ASectionNameSizeInChars, int AItemNameSizeInChars, int AValue) = 0;
		virtual HRESULT WINAPI SectionExists(PWCHAR ASectionName, int ASectionNameSizeInChars) = 0;
		virtual HRESULT WINAPI SectionRemove(PWCHAR ASectionName, int ASectionNameSizeInChars) = 0;
};

/* IAIMPAddonsLanguageFile */
class IAIMPAddonsLanguageFile: public IUnknown
{
	public:
		virtual int WINAPI Version() = 0;
		virtual int WINAPI CurrentFile(PWCHAR ABuffer, int ABufferSizeInChars) = 0;
		virtual HRESULT WINAPI SectionExists(PWCHAR ASectionName, int ASectionNameSizeInChars) = 0;
		virtual HRESULT WINAPI ReadString(PWCHAR ASectionName, PWCHAR AItemName, PWCHAR AValueBuffer,
			int ASectionNameSizeInChars, int AItemNameSizeInChars, int AValueBufferSizeInChars) = 0;
		// When Language changed AIMP will send to WndHandle "WM_AIMP_LANG_CHANGED" message
		virtual HRESULT WINAPI Notification(HWND AWndHandle, BOOL ARegister) = 0;
};

/* IAIMPAddonsMenuManager */
class IAIMPAddonsMenuManager: public IUnknown
{
	public:
	    // AMenuID: see AIMP_MENUID_XXX
		virtual HAIMPMENU WINAPI MenuCreate(DWORD AMenuID, PAIMPMenuItemInfo AItemInfo) = 0;
		virtual HAIMPMENU WINAPI MenuCreateEx(HAIMPMENU AParentMenu, PAIMPMenuItemInfo AItemInfo) = 0;
		// Deprecated, use IAIMPAddonsActionManager.ActionMakeHotkey instead
		virtual DWORD WINAPI MenuTextToShortCut(PWCHAR ABuffer, int ABufferSizeInChars) = 0;
		virtual HRESULT WINAPI MenuRemove(HAIMPMENU AHandle) = 0;
		virtual HRESULT WINAPI MenuUpdate(HAIMPMENU AHandle, PAIMPMenuItemInfo AItemInfo) = 0;
};

// [v3.50]
/* IAIMPAddonsMenuManager2 */
class IAIMPAddonsMenuManager2: public IAIMPAddonsMenuManager 
{  
	public:
		// set AActionHandle to nil to remove any action from specified menu item
		virtual HRESULT WINAPI MenuSetAction(HAIMPMENU AHandle, HAIMPACTION AActionHandle) = 0;
};

/* IAIMPAddonsProxySettings */
class IAIMPAddonsProxySettings: public IUnknown
{
	public:
		// Receiving Proxy Server params in "server:port" format
		// Returns E_FAIL, if proxy doesn't use, and S_OK otherwise
		virtual HRESULT WINAPI GetProxyParams(PWCHAR AServerBuffer, int AServerBufferSizeInChars) = 0;
		// Receiving Proxy Server user autorization params
		// Returns E_FAIL, if proxy server or user authorization don't used
		virtual HRESULT WINAPI GetProxyAuthorizationParams(
			PWCHAR AUserNameBuffer, int AUserNameBufferSizeInChars,
			PWCHAR AUserPassBuffer, int AUserPassBufferSizeInChars) = 0;
};

/* IAIMPAddonsPlaylistStrings */  
class IAIMPAddonsPlaylistStrings: public IUnknown
{
	public:
		virtual HRESULT WINAPI ItemAdd(PWCHAR AFileName, TAIMPFileInfo *AInfo) = 0;
		virtual int     WINAPI ItemGetCount() = 0;
		virtual HRESULT WINAPI ItemGetFileName(int AIndex, PWCHAR ABuffer, int ABufferSizeInChars) = 0;
		virtual HRESULT WINAPI ItemGetInfo(int AIndex, TAIMPFileInfo *AInfo) = 0;
};

/* IAIMPAddonsPlaylistManagerListener */
// must be implemented by plugin
class IAIMPAddonsPlaylistManagerListener: public IUnknown
{
	public:
		virtual void WINAPI StorageActivated(HPLS ID) = 0;
		virtual void WINAPI StorageAdded(HPLS ID) = 0;
		// AFlags - combination of AIMP_PLAYLIST_NOTIFY_XXX
		virtual void WINAPI StorageChanged(HPLS ID, DWORD AFlags) = 0;
		virtual void WINAPI StorageRemoved(HPLS ID) = 0;
};

/* IAIMPAddonsPlaylistManager */
// See ActivePlaylistHandle constant
class IAIMPAddonsPlaylistManager: public IUnknown
{
	public:
		// AIMP_PLAYLIST_FORMAT_MODE_PREVIEW  - template will be expand as preview
		// AIMP_PLAYLIST_FORMAT_MODE_FILEINFO - put to AData param pointer to TAIMPFileInfo struct
		// AIMP_PLAYLIST_FORMAT_MODE_CURRENT  - format current file info
		// AString buffer will be automaticly freed, you must make copy
		virtual HRESULT WINAPI FormatString(PWCHAR ATemplate, int ATemplateSizeInChars,	int AMode, void *AData, PWCHAR *AString) = 0;
		// Listeners
		virtual HRESULT WINAPI ListenerAdd(IAIMPAddonsPlaylistManagerListener *AListener) = 0;
		virtual HRESULT WINAPI ListenerRemove(IAIMPAddonsPlaylistManagerListener *AListener) = 0;
		// See AIMP_PLAYLIST_ENTRY_PROPERTY_XXX
		virtual HRESULT WINAPI EntryDelete(HPLSENTRY AEntry) = 0;
		virtual HRESULT WINAPI EntryGetGroup(HPLSENTRY AEntry, HPLSGROUP *AGroup) = 0;
		virtual HRESULT WINAPI EntryPropertyGetValue(HPLSENTRY AEntry, int APropertyID, void *ABuffer, int ABufferSize) = 0;
		virtual HRESULT WINAPI EntryPropertySetValue(HPLSENTRY AEntry, int APropertyID, void *ABuffer, int ABufferSize) = 0;
		virtual HRESULT WINAPI EntryReloadInfo(HPLSENTRY AEntry) = 0;
		// See AIMP_PLAYLIST_GROUP_PROPERTY_XXX
		virtual HRESULT WINAPI GroupPropertyGetValue(HPLSGROUP AGroup, int APropertyID, void *ABuffer, int ABufferSize) = 0;
		virtual HRESULT WINAPI GroupPropertySetValue(HPLSGROUP AGroup, int APropertyID, void *ABuffer, int ABufferSize) = 0;
		//
		virtual HPLS 	WINAPI StorageActiveGet() = 0;
		virtual HRESULT WINAPI StorageActiveSet(HPLS ID);
		virtual HRESULT WINAPI StorageAddEntries(HPLS ID, IAIMPAddonsPlaylistStrings *AObjects) = 0; // Add Objects to playlist. "Objects" can contains: shortcuts, files, folder, playlists
		virtual HPLS 	WINAPI StorageCreate(PWCHAR AName, BOOL AActivate) = 0;
		virtual HPLS 	WINAPI StorageCreateFromFile(PWCHAR AFileName, BOOL AActivate, BOOL AStartPlay) = 0;
		virtual HPLS 	WINAPI StoragePlayingGet() = 0;
		//
		virtual HPLS 	  WINAPI StorageGet(int AIndex) = 0;
		virtual int  	  WINAPI StorageGetCount() = 0;
		virtual HPLSENTRY WINAPI StorageGetEntry(HPLS ID, int AEntryIndex) = 0;
		virtual int  	  WINAPI StorageGetEntryCount(HPLS ID) = 0;
		virtual HRESULT   WINAPI StorageGetFiles(HPLS ID, int AFlags, IAIMPAddonsPlaylistStrings **AFiles) = 0; // Flags: Use combination of the AIMP_PLAYLIST_GETFILES_XXX flags
		virtual HPLSGROUP WINAPI StorageGetGroup(HPLS ID, int AGroupIndex) = 0;
		virtual	int		  WINAPI StorageGetGroupCount(HPLS ID) = 0;
		//
		virtual HRESULT WINAPI StorageDelete(HPLS ID, int AEntryIndex) = 0;
		virtual HRESULT WINAPI StorageDeleteAll(HPLS ID) = 0;
		virtual HRESULT WINAPI StorageDeleteByFilter(HPLS ID, BOOL APhysically,	TAIMPAddonsPlaylistManagerDeleteProc AFilterProc, void *AUserData) = 0;
		virtual HRESULT WINAPI StorageRemove(HPLS ID) = 0; // Remove playlist storage from manager (like "close playlist")
		//
		virtual HRESULT WINAPI StorageSort(HPLS ID, int ASortType) = 0; // Predefined Sorting, see AIMP_PLAYLIST_SORT_TYPE_XXX
		virtual HRESULT WINAPI StorageSortCustom(HPLS ID, TAIMPAddonsPlaylistManagerCompareProc ACompareProc, void *AUserData) = 0;
		virtual HRESULT WINAPI StorageSortTemplate(HPLS ID, PWCHAR ABuffer, int ABufferSizeInChars) = 0;
		// Lock / Unlock playlist calculation and drawing
		virtual HRESULT WINAPI StorageBeginUpdate(HPLS ID) = 0;
		virtual HRESULT WINAPI StorageEndUpdate(HPLS ID) = 0;
		// See AIMP_PLAYLIST_STORAGE_PROPERTY_XXX
		virtual HRESULT WINAPI StoragePropertyGetValue(HPLS ID, int APropertyID, void *ABuffer, int ABufferSize) = 0;
		virtual HRESULT WINAPI StoragePropertySetValue(HPLS ID, int APropertyID, void *ABuffer, int ABufferSize) = 0;
		// Queue
		virtual HRESULT WINAPI QueueEntryAdd(HPLSENTRY AEntry, BOOL AInsertAtQueueBegining) = 0;
		virtual HRESULT WINAPI QueueEntryRemove(HPLSENTRY AEntry) = 0;
};

/* IAIMPAddonsPlaylistManager2 */
// [v3.10]
class IAIMPAddonsPlaylistManager2: public IAIMPAddonsPlaylistManager
{
	public:
		// Element
		virtual int 	WINAPI ElementGetType(HPLSELEMENT AElement);
		// Groups
		virtual HRESULT WINAPI GroupGetEntry(HPLSGROUP AGroup, int AIndex, HPLSENTRY *AEntry);
		virtual int		WINAPI GroupGetEntryCount(HPLSGROUP AGroup);
		// Storage
		virtual HRESULT WINAPI StorageFocusGet(HPLS ID, HPLSELEMENT *AElement);
		virtual HRESULT WINAPI StorageFocusSet(HPLS ID, HPLSELEMENT  AElement);
		virtual HRESULT WINAPI StorageReloadFromPreimage(HPLS ID);
};

/* IAIMPAddonsPlaylistQueue */
// [v3.10]
class IAIMPAddonsPlaylistQueue: public IUnknown
{
	public:
		virtual HRESULT WINAPI QueueEntryAdd(HPLSENTRY AEntry, BOOL AInsertAtQueueBegining) = 0;
		virtual HRESULT WINAPI QueueEntryRemove(HPLSENTRY AEntry) = 0;
		virtual HRESULT WINAPI QueueEntryGet(int Index, HPLSENTRY *AENTRY) = 0;
		virtual int		WINAPI QueueEntryGetCount() = 0;
		virtual HRESULT WINAPI QueueEntryMove(HPLSENTRY AEntry, int ANewIndex) = 0;
		virtual HRESULT WINAPI QueueEntryMove2(int AOldIndex, int ANewIndex) = 0;
		virtual BOOL 	WINAPI QueueSuspendedGet() = 0;
		virtual HRESULT WINAPI QueueSuspendedSet(BOOL AValue) = 0;
};

/* IAIMPAddonsCoverArtManager */
class IAIMPAddonsCoverArtManager: public IUnknown
{
	public:
		// AFileName - [in] Full file name for audio track
		// ACoverArtFileName - [out] buffer for cover art file name, can be NULL; 
		//                     Filled only if cover art loaded from the separate file
		// ACoverArtFileNameBufferSizeInChars - [in] size of ACoverArtFileName buffer in chars (should be 0, if ACoverArtFileName == NULL)
		virtual HBITMAP WINAPI CoverArtGetForFile(PWCHAR AFileName, SIZE *ADisplaySize,
			PWCHAR ACoverArtFileNameBuffer, int ACoverArtFileNameBufferSizeInChars) = 0;
		// Work with CoverArt of playing file,
		// if file is playing and CoverArt exists, functions returns S_OK
		virtual HRESULT WINAPI CoverArtDraw(HDC DC, RECT *R) = 0; // CoverArt will be proportional stretched to R value
		virtual HRESULT WINAPI CoverArtGetFileName(PWCHAR ABuffer, int ABufferSizeInChars) = 0;
		virtual HRESULT WINAPI CoverArtGetSize(SIZE *ASize) = 0;
};

/* IAIMPAddonsPlayerManager */
class IAIMPAddonsPlayerManager: public IUnknown
{
	public:
		virtual HRESULT WINAPI PlayEntry(HPLSENTRY AEntry) = 0;
		virtual HRESULT WINAPI PlayFile(PWCHAR AFileName, BOOL AFailIfNotExistsInPlaylist) = 0;
		virtual HRESULT WINAPI PlayStorage(HPLS ID, int AEntryIndex /* -1 - default*/) = 0;
		// Register / Unregister custom FileInfo repository, you can put own info about the any file
		virtual HRESULT WINAPI FileInfoRepository(IAIMPAddonsFileInfoRepository *ARepository, BOOL ARegister) = 0;
		// if AFileName = nil: Get information about currently playing file
		virtual HRESULT WINAPI FileInfoQuery(PWCHAR AFileName, TAIMPFileInfo *AInfo) = 0;
		// Register / Unregister custom playing queue controller
		virtual HRESULT WINAPI PlayingQueueController(IAIMPAddonsPlayingQueueController *AController, BOOL ARegister) = 0;
		// see AIMP_CFG_PATH_XXX
		virtual HRESULT WINAPI ConfigGetPath(int AConfigPathID, PWCHAR ABuffer, int ABufferSizeInChars) = 0;
		// see AIMP_SUPPORTS_EXTS_XXX
		virtual HRESULT WINAPI SupportsExts(DWORD AFlags, PWCHAR ABuffer, int ABufferSizeInChars) = 0;
};

/* IAIMPAddonsPlayerAsyncHook */
// must be implemented by plugin
// WARNING: Interface implementation must support multi-threaded access
class IAIMPAddonsPlayerAsyncHook: public IUnknown
{
	public:
		virtual HRESULT WINAPI PreparingForRemoteTrackPlayback(IAIMPString *ATrackURI, BOOL *AHandled) = 0;
};

/* IAIMPAddonsPlayerManager2 */

class IAIMPAddonsPlayerManager2: public IUnknown // [v3.51]
{
	public:
		// Note: function can return NULL
		virtual HRESULT WINAPI PlayingQueueGetNextTrack(HPLSENTRY *AEntry) = 0;
		virtual HRESULT WINAPI PlayingQueueGetPrevTrack(HPLSENTRY *AEntry) = 0;
	
		virtual HRESULT WINAPI PlayingQueueRegisterHook(IAIMPAddonsPlayerAsyncHook *AHook) = 0;
		virtual HRESULT WINAPI PlayingQueueUnregisterHook(IAIMPAddonsPlayerAsyncHook *AHook) = 0;
};

/* IAIMPAddonsSkinsManager */
class IAIMPAddonsSkinsManager: public IUnknown
{
	public:
		// AColorHue & AColorHueIntensity - optional
		virtual HRESULT WINAPI GetCurrentSettings(PWCHAR ASkinLocalFileNameBuffer,
			int ASkinLocalFileNameBufferSizeInChars, int *AColorHue, int *AColorHueIntensity) = 0;
		// Get Info about Skin
		// + Skin can be placed anywhere
		// + if AFileNameBuffer contains empty string - function return information about build-in skin
		// WARNING!!! You must manually destroy TAIMPSkinInfo.Preview if it no longer need
		virtual HRESULT WINAPI GetSkinInfo(PWCHAR AFileNameBuffer, int AFileNameBufferSizeInChars, PAIMPSkinInfo ASkinInfo) = 0;
		// Skin must be placed in %AIMP_Skins% directory (see IAIMPAddonsPlayerManager.ConfigGetPath)
		// AColorHue: [0..255], Default: 0 (don't change hue)
		// AColorHueIntensity [0..100], Default: 100 (don't change Hue Intensity), depends from AColorHue value
		virtual HRESULT WINAPI Select(PWCHAR ASkinLocalFileName, int AColorHue, int AColorHueIntensity) = 0;
		// Conversion between HSL and RGB color spaces
		virtual HRESULT WINAPI HSLToRGB(BYTE H, BYTE S, BYTE L, BYTE *R, BYTE *G, BYTE *B) = 0;
		virtual HRESULT WINAPI RGBToHSL(BYTE R, BYTE G, BYTE B, BYTE *H, BYTE *S, BYTE *L) = 0;
};

// [v3.50]
/* IAIMPAddonsMediaBase */
class IAIMPAddonsMediaBase: public IUnknown  
{
	public:
		// AMark - mark for the specified file, [0.0 .. 5.0]
		// Function returns E_NOTIMPL if Audio Library is not installed
		virtual HRESULT WINAPI MarkGet(PWCHAR AFileNameBuffer, int AFileNameBufferSizeInChars, float *AMark) = 0;
		virtual HRESULT WINAPI MarkSet(PWCHAR AFileNameBuffer, int AFileNameBufferSizeInChars, float AMark) = 0;
		// Function receive information about the specified file from DataBase
		// To get statistics information about the file, you should:
		// + Set to ABuffer pointer to TAIMPFileStatisticsInfo struct
		// + Set to ABufferSize value equals to SizeOf(TAIMPFileStatisticsInfo)
		// Function returns E_NOTIMPL if Audio Library is not installed
		virtual HRESULT WINAPI InfoGet(PWCHAR AFileNameBuffer, int AFileNameBufferSizeInChars, void *ABuffer, int ABufferSize) = 0;
};


// [v3.50]
/* IAIMPAddonsActionManager */
class IAIMPAddonsActionManager: public IUnknown 
{
	public:
		// AInstance - A handle to an instance of the plugin
		// ID - Unique action id for the plugin, it uses for save / restore information about the action from config
		// AProc - callback procedure
		// AUserData - user data for callback procedure
		virtual HRESULT WINAPI ActionCreate(HINSTANCE AInstance, int ID, TAIMPActionProc AProc, void *AUserData, /* out */ HAIMPACTION *AHandle) = 0;
		// APropertyID - see AIMP_ACTION_PROPERTY_XXX
		virtual HRESULT WINAPI ActionPropertyGetValue(HAIMPACTION AHandle, int APropertyID, void *ABuffer, int ABufferSize) = 0;
		virtual HRESULT WINAPI ActionPropertySetValue(HAIMPACTION AHandle, int APropertyID, void *ABuffer, int ABufferSize) = 0;
		virtual HRESULT WINAPI ActionRemove(HAIMPACTION AHandle) = 0;
		// AModifiers - combination of AIMP_ACTION_HOTKEY_MODIFIER_XXX flags
		// AKey - virtual key code, see VK_XXX consts from Windows.pas
		virtual DWORD WINAPI ActionMakeHotkey(WORD AModifiers, WORD AKey);
};

/* IAIMPAddonPlugin */
// Must be implemented by Plugin

class IAIMPAddonPlugin: public IUnknown
{
	public:
		virtual PWCHAR WINAPI GetPluginAuthor() = 0;
		virtual PWCHAR WINAPI GetPluginInfo() = 0;
		virtual PWCHAR WINAPI GetPluginName() = 0;
		virtual DWORD  WINAPI GetPluginFlags() = 0; // See AIMP_ADDON_FLAGS_XXX
		virtual HRESULT WINAPI Initialize(IAIMPCoreUnit *ACoreUnit) = 0;
		virtual HRESULT WINAPI Finalize() = 0;
		virtual HRESULT WINAPI ShowSettingsDialog(HWND AParentWindow) = 0;
};

// Export function name: AIMP_QueryAddon3
typedef BOOL (WINAPI *TAIMPAddonPluginHeaderProc)(IAIMPAddonPlugin **AHeader);
#endif