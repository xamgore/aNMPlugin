#include "api/AIMPSDKHelpers.h"
#include "api/AIMPSDKAddons.h"

class aNMPlugin : public IUnknownInterfaceImpl<IAIMPAddonPlugin> {
    private:
    HMODULE pluginInstance;

    HAIMPACTION FActionHandle;
    HAIMPMENU FMenuHandle;
    IAIMPCoreUnit *FCoreUnit;

    public:

    aNMPlugin(HMODULE PluginInstance) : pluginInstance(PluginInstance) {}


    virtual HRESULT WINAPI Initialize(IAIMPCoreUnit *ACoreUnit) override;
    virtual HRESULT WINAPI Finalize() override;

    virtual PWCHAR WINAPI GetPluginName() override;
    virtual PWCHAR WINAPI GetPluginAuthor() override;
    virtual PWCHAR WINAPI GetPluginInfo() override;
    virtual  DWORD WINAPI GetPluginFlags() override;

    virtual HRESULT WINAPI ShowSettingsDialog(HWND AParentWindow) override;
};