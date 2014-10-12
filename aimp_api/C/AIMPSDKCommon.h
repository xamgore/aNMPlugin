/* ******************************************** */
/*                                              */
/*                AIMP Plugins API              */
/*             v3.55.1290 (03.09.2013)          */
/*                Common Objects                */
/*                                              */
/*              (c) Artem Izmaylov              */
/*                 www.aimp.ru                  */
/*             Mail: artem@aimp.ru              */
/*              ICQ: 345-908-513                */
/*                                              */
/* ******************************************** */

#ifndef AIMPSDKCommonH
#define AIMPSDKCommonH

#include <windows.h>
#include <unknwn.h>

static const GUID IID_IAIMPString	= {0x41494D50, 0x0033, 0x434F, 0x00, 0x00, 0x53, 0x54, 0x52, 0x00, 0x00, 0x00};

/* IAIMPString */
class IAIMPString: public IUnknown // [v3.51]
{
	public:
		virtual HRESULT WINAPI GetChar(int AIndex, WCHAR *AChar) = 0;
		virtual PWCHAR WINAPI GetData() = 0;
		virtual int WINAPI GetLength() = 0;
		virtual HRESULT WINAPI SetData(PWCHAR AChars, int ACharsCount) = 0;
};

#pragma pack(push, 1)
struct TAIMPFileInfo
{
	DWORD StructSize;
	//
	BOOL  Active;
	DWORD BitRate;
	DWORD Channels;
	DWORD Duration;
	INT64 FileSize;
	DWORD Rating;
	DWORD SampleRate;
	DWORD TrackNumber;
	//
	DWORD AlbumBufferSizeInChars;
	DWORD ArtistBufferSizeInChars;
	DWORD DateBufferSizeInChars;
	DWORD FileNameBufferSizeInChars;
	DWORD GenreBufferSizeInChars;
	DWORD TitleBufferSizeInChars;
	//
	PWCHAR AlbumBuffer;
	PWCHAR ArtistBuffer;
	PWCHAR DateBuffer;
	PWCHAR FileNameBuffer;
	PWCHAR GenreBuffer;
	PWCHAR TitleBuffer;
};
#pragma pack(pop)

#endif