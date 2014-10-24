#include "api/AIMPSDKHelpers.h"
#include "api/AIMPSDKAddons.h"

class aNMPlugin : public IUnknownInterfaceImpl<IAIMPAddonPlugin> {
    private:
    HMODULE pluginInstance;

    HAIMPACTION FActionHandle;
    HAIMPMENU FMenuHandle;
    IAIMPCoreUnit *FCoreUnit;

    public:

    aNMPlugin(HMODULE PluginInstance) {
        pluginInstance = PluginInstance;
    };


    virtual HRESULT WINAPI Initialize(IAIMPCoreUnit *ACoreUnit);

    virtual HRESULT WINAPI Finalize();


    virtual PWCHAR WINAPI GetPluginName() {
        return L"aNMusic v1.3";
    };

    virtual PWCHAR WINAPI GetPluginAuthor() {
        return L"ksakep";
    };

    virtual PWCHAR WINAPI GetPluginInfo() {
        return L"Sends information about currently playing file to http://annimon.com";
    };

    virtual DWORD  WINAPI GetPluginFlags() {
        return AIMP_ADDON_FLAGS_HAS_DIALOG;
    }

    virtual HRESULT WINAPI ShowSettingsDialog(HWND AParentWindow) {
        return S_OK; // Create the settingsForm.ShowModal();
    };
};