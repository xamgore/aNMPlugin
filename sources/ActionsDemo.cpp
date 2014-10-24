/* Defines the exported functions for the DLL application. */

#include "aNMPlugin.h"
#include "api\AIMPSDKAddons.h"

HMODULE PluginInstance = nullptr;

BOOL WINAPI AIMP_QueryAddon3(IAIMPAddonPlugin **AHeader) {
    aNMPlugin *Plugin = new aNMPlugin(PluginInstance);
    Plugin->AddRef();
    *AHeader = Plugin;
    return true;
}

BOOL WINAPI DllMain(HMODULE module, DWORD reasonForCall, LPVOID lpReserved) {
    switch (reasonForCall) {
        case DLL_PROCESS_ATTACH:
        case DLL_THREAD_ATTACH:
        case DLL_THREAD_DETACH:
        case DLL_PROCESS_DETACH:
            PluginInstance = module;
            break;
    }
    return TRUE;
}