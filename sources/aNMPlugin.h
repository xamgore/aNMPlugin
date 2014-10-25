#include "api/AIMPSDKHelpers.h"
#include "api/AIMPSDKAddons.h"

typedef class aNMPlugin : public IAIMPAddonPlugin {
    HMODULE pluginInstance;
    HAIMPACTION FActionHandle;
    HAIMPMENU FMenuHandle;
    IAIMPCoreUnit *FCoreUnit;

public:
    virtual HRESULT WINAPI Initialize(IAIMPCoreUnit *coreUnit) override;
    virtual HRESULT WINAPI Finalize() override;

    virtual HRESULT WINAPI ShowSettingsDialog(HWND AParentWindow) override;

    virtual PWCHAR WINAPI GetPluginName() override;
    virtual PWCHAR WINAPI GetPluginInfo() override;
    virtual  DWORD WINAPI GetPluginFlags() override;
    virtual PWCHAR WINAPI GetPluginAuthor() override;


    virtual HRESULT WINAPI QueryInterface(const IID &, void **) override;
    virtual ULONG WINAPI AddRef() override;
    virtual ULONG WINAPI Release() override;
} _aNMPlugin;