#include "..\..\..\Helpers\AIMPSDKHelpers.h"

class ActionsDemoPlugin: public IUnknownInterfaceImpl<IAIMPAddonPlugin> 
{
	private:
		HAIMPACTION FActionHandle;
		HAIMPMENU FMenuHandle;	
		HMODULE FPluginInstance;
		IAIMPCoreUnit *FCoreUnit;

	public:
		ActionsDemoPlugin(HMODULE PluginInstance)
		{
			FPluginInstance = PluginInstance;
		};

		// IAIMPAddonPlugin
		virtual PWCHAR WINAPI GetPluginAuthor()
		{
			return L"Unknown";
		};
		
		virtual PWCHAR WINAPI GetPluginInfo()
		{
			return L"Some plugin info";
		};

		virtual PWCHAR WINAPI GetPluginName()
		{
			return L"Actions Demo plugin";
		};

		virtual DWORD  WINAPI GetPluginFlags()
		{
			return 0;
		}

		virtual HRESULT WINAPI Initialize(IAIMPCoreUnit *ACoreUnit);

		virtual HRESULT WINAPI Finalize();

		virtual HRESULT WINAPI ShowSettingsDialog(HWND AParentWindow)
		{
			return S_OK;
		};
};