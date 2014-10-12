// AddonDemo.cpp : Defines the exported functions for the DLL application.
//

#include "stdafx.h"
#include "aNMPlugin.h"
#include "aimp_api\AIMPSDKAddons.h"

HMODULE PluginInstance = 0;

BOOL WINAPI AIMP_QueryAddon3(IAIMPAddonPlugin **AHeader)
{
    aNMPlugin *Plugin = new aNMPlugin(PluginInstance);
    Plugin->AddRef();
    *AHeader = Plugin;
    return true;
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved)
{
    switch (ul_reason_for_call)
    {
        case DLL_PROCESS_ATTACH:
        case DLL_THREAD_ATTACH:
        case DLL_THREAD_DETACH:
        case DLL_PROCESS_DETACH:
            PluginInstance = hModule;
            break;
    }
    return TRUE;
}