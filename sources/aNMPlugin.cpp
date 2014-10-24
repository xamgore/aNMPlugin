#include "aNMPlugin.h"

void WINAPI ActionProc(void *UserData, int ID, HAIMPACTION Handle) {
    MessageBox(0, "Action executed!", "ActionsDemoPlugin", MB_ICONINFORMATION);
}

HRESULT WINAPI aNMPlugin::Initialize(IAIMPCoreUnit *ACoreUnit) {
    FCoreUnit = ACoreUnit;
    FCoreUnit->AddRef();

    IAIMPAddonsActionManager *AActionsManager;
    IAIMPAddonsMenuManager2 *AMenuManager;

    if (FCoreUnit->QueryInterface(IID_IAIMPAddonsActionManager, (void **) &AActionsManager) == S_OK) {
        if (AActionsManager->ActionCreate(pluginInstance, 1, ActionProc, nullptr, &FActionHandle) == S_OK) {
            WCHAR *AActionName = L"Demo Action";
            WCHAR *AGroupName = L"Demo Action Plugin Group";

            // Setup action display name
            AActionsManager->ActionPropertySetValue(FActionHandle, AIMP_ACTION_PROPERTY_NAME, AActionName, wcslen(AActionName) * sizeof(WCHAR));
            // Setup action group name
            AActionsManager->ActionPropertySetValue(FActionHandle, AIMP_ACTION_PROPERTY_GROUPNAME, AGroupName, wcslen(AGroupName) * sizeof(WCHAR));

            // Set default local hotkey for an action
            DWORD AHotKey = AActionsManager->ActionMakeHotkey(AIMP_ACTION_HOTKEY_MODIFIER_CTRL | AIMP_ACTION_HOTKEY_MODIFIER_SHIFT, BYTE('Z'));
            AActionsManager->ActionPropertySetValue(FActionHandle, AIMP_ACTION_PROPERTY_DEFAULTLOCALHOTKEY, &AHotKey, sizeof(AHotKey));
        }
        AActionsManager->Release();

        // Create menu item and link the action to it
        if (FCoreUnit->QueryInterface(IID_IAIMPAddonsMenuManager2, (void **) &AMenuManager) == S_OK) {
            TAIMPMenuItemInfo AMenuItem;

            memset(&AMenuItem, 0, sizeof(AMenuItem));
            AMenuItem.StructSize = sizeof(AMenuItem);
            AMenuItem.Caption = L"Menu Item with Action";
            FMenuHandle = AMenuManager->MenuCreate(AIMP_MENUID_UTILITIES, &AMenuItem);
            AMenuManager->MenuSetAction(FMenuHandle, FActionHandle);
            AMenuManager->Release();
        }
    }
    return S_OK;
};

HRESULT WINAPI aNMPlugin::Finalize() {
    IAIMPAddonsActionManager *AActionsManager;
    IAIMPAddonsMenuManager *AMenuManager;

    // Removing action handle
    if (FCoreUnit->QueryInterface(IID_IAIMPAddonsActionManager, (void **) &AActionsManager) == S_OK) {
        AActionsManager->ActionRemove(FActionHandle);
        AActionsManager->Release();
        FActionHandle = nullptr;
    }

    // Removing menu item
    if (FCoreUnit->QueryInterface(IID_IAIMPAddonsMenuManager, (void **) &AMenuManager) == S_OK) {
        AMenuManager->MenuRemove(FMenuHandle);
        AMenuManager->Release();
        FMenuHandle = nullptr;
    }

    // Release core unit
    FCoreUnit->Release();
    FCoreUnit = nullptr;
    return S_OK;
}

PWCHAR aNMPlugin::GetPluginName() {
    return L"aNMusic v1.3";
}

PWCHAR aNMPlugin::GetPluginAuthor() {
    return L"ksakep";
}

PWCHAR aNMPlugin::GetPluginInfo() {
    return L"Sends information about currently playing file to http://annimon.com/";
}

DWORD aNMPlugin::GetPluginFlags() {
    return AIMP_ADDON_FLAGS_HAS_DIALOG;
}

HRESULT aNMPlugin::ShowSettingsDialog(HWND AParentWindow) {
    return S_OK; // Create the settingsForm.ShowModal();
};
