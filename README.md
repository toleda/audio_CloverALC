![alt text](https://github.com/toleda/audio_RealtekALC/blob/master/sound.jpeg)
#audio\_cloverALC

**OS X/Clover/kext patched AppleHDA Realtek ALC Audio**  
Native AppleHDA/Persistent

The Clover/kext patched Realtek ALC method enables OS X AppleHDA onboard audio with or without HDMI and DP audio. The script adds codec specific layout and platform files and injects binary patch and pin configuration data to the native installed AppleHDA.kext.

Clover version of Piker Alpha/AppleHDA8Series.sh. The script adds AppleHDA.kext kernel cache patches to config.plist and installs L/E/AppleHDAxxx.kext (xxx = codec)

**Updates**

1. 12/14/15 - audio_pikeralpha-110 (Clover version of Piker Aplha AppleHDA8Series.sh)
2. 11/8/15 - Skylake/Series 100 Update, Add 1150/Audio ID: 3
3. 7/19/15 - 283 Update
4. 6/15/15 - 10.11 - El Capitan Realtek ALC AppleHDA.kext Initial Support

**Versions: audio_cloverALC-110**

1. Easy: .command, see A. Installation
2. Bash: .sh, see B. Terminal

**A. Installation**

1.  Clover/kext patched AppleHDA
    1.  [audio\_cloverALC-110.command](https://github.com/toleda/audio_CloverALC/blob/master/  audio_cloverALC-110.command.zip) (select View Raw) 
    or [audio\_pikeralphaALC-110.command](https://github.com/toleda/audio_CloverALC/blob/master/audio_pikeralphaALC-110.command.zip) (select View Raw)
    2.  Double click: Downloads/audio_cloverALC-110.command
    3.  Password:
    4.  Confirm Codec ALCxxx: (885, 887, 888, 889, 892, 898, 1150 only)
    5.  Clover/Legacy: answer y to Confirm Clover Legacy Install (y/n)
    6.  Clover Audio ID Injection (y/n):
    7.  Use Audio ID: x (y/n):
    8.  Optional: Terminal/Terminal Saved Output
2.  Restart
3.  Verify ALC onboard audio
    1.  System Preferences/Sound/Output/select audio device

**B. Terminal**

1.  Clover/kext patched AppleHDA
    1. [audio\_cloverALC-110.sh](https://github.com/toleda/audio_CloverALC/blob/master/audio_cloverALC-110.sh) (select View Raw)
    2. Terminal $ ./audio_cloverALC-110....sh
    3. Same (as above)

**C. Requirements**

1.  OS X Versions (+ all)
    1.  10.11+/El Capitan 
    2.  10.10+/Yosemite
    3.  10.9+/Mavericks
    4.  10.8+/Mountain Lion
2. Boot Flags/Boot failure may result if ignored
	1.	10.11+/Disable SIP/set, restart, install, enable SIP, restart
		1.	CLOVER/config.plist/RtVariables/
			1.	BooterConfig/0x28
			2.	CsrActiveConfig/0x3
	2.	10.10+/Allow unsigned kexts/set, restart, install
		1.	Clover/config.plist
			1.	Mandatory, Add: Boot/Arguments/kext-dev-mode=1
3.  Native AppleHDA.kext
    1.  [Need native?](https://github.com/toleda/audio_ALC_guides/blob/master/Restore%20native%20AppleHDA%20%5BGuide%5D.pdf)
4.  Supported Realtek onboard audio codec
    1.  [Unknown codec?](https://github.com/toleda/audio_ALC_guides/blob/master/Identify%20Audio%20Codec%20%5BGuide%5D.pdf)

**D. Realtek ALCxxx** (verify codec and Audio ID)**

1.  Supported codecs (* Not supported with audio_pikeralpha-110)
    1.  269 (BRIX only) *
    2.  283 (BRIX Pro and NUC only) *
    3.  885
    4.  887
    5.  888
    6.  889
    7.  892
    8.  898
    9.  1150

2.  Supported Audio IDs
    -  Audio ID: 1 - supports 269, 283, 885, 887, 888, 889, 892, 898, 1150  
        Realtek ALC audio (default, 1/2/3/5/6 motherboard audio ports)

    -  Audio ID: 2 - supports 887, 888, 889, 892, 898, 1150  
        Realtek ALC/5.1 surround sound (3 motherboard audio ports)
    -  Audio ID: 3 - supports 887, 888, 889, 892, 898, 1150  
        HD3000/HD4000 HDMI audio with Realtek ALC audio

**E. More Information**

1. [Details](https://github.com/toleda/audio_RealtekALC/blob/master/DETAILS.md)
    1.  Onboard Audio Solutions
    2.  Requirements - Supported/Unsupported
    3.  Notes
    4.  Guides
    5.  Tools
    6.  Problem Reporting
2. [Realtek ALC guides](https://github.com/toleda/audio_ALC_guides)
2. Terminal Saved Output
    1.  [Clover/EFI](https://github.com/toleda/audio_CloverALC/blob/master/Terminal:audio_cloverALC-110-efi.txt)
    2.  [Clover/Legacy](https://github.com/toleda/audio_CloverALC/blob/master/Terminal:audio_cloverALC-110-legacy.txt)

**F - Tools**

1. [IOReg_v2.1](https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip) (select View Raw)
2. [DPCIManger](http://sourceforge.net/projects/dpcimanager/)  
3. [MaciASL](http://sourceforge.net/projects/maciasl/)
4. Property List Editors -
	1. [Xcode](https://developer.apple.com/xcode/)  
	2. Property List Editor, PlistEdit Pro, TextEdit, etc.
	3. TextEdit, TextWrangler (last resort)
4. [Clover Configurator](http://www.osx86.net/files/file/49-clover-configurator/)
6. [Clover Wiki](http://clover-wiki.zetam.org/Home)

**G - Problem Reporting** (no files atached, no reply)

1.	Description of audio problem
2.	OS X version/motherboard model/BIOS version/processor/graphics
3.	Procedure/Guide used
4.	Installed S/L/E/AppleHDA.kext
5.	Copy of IOReg - IOReg_v2.1/File/Save a Copy As…, verify file (Tools 1.)
6.	Screenshot: DPCIManager/Status (Tools 2.) 
7.	DPCIManager/Misc/Boot Log, atttach text file
8.	MaciASL/File/Export Tableset As... (Tools 3.)
9.	Terminal/Shell/File/Export Text As. . . /
	1. audio_cloverALC-110...command
	2. audio_pikeralphaALC-110...command
10.	Clover
	1.	EFI/CLOVER/config.plist
	2.	DPCIManager/Misc/Boot Log (Tools 2.)
	3.	EFI/CLOVER/ACPI/Patched/dsdt.aml (if installed)
	4.	EFI/CLOVER/ACPI/Patched/ssdt.aml (if installed)
11.	Post to:
	1.	[Realtek ALC Audio - InsanelyMac.com](http://www.insanelymac.com/forum/topic/308387-el-capitan-realtek-alc-applehda-audio/page-1)
	2. [Realtek ALC Audio - tonymacx86.com](http://www.tonymacx86.com/audio/143752-no-audio-devices-realtek-alc-applehda-guide.html)


Credit
THe KiNG, bcc9, RevoGirl, PikeRAlpha, SJ\_UnderWater, RehabMan, TimeWalker75a, lisai9093, [abxite](http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647)

toleda https://github.com/toleda/audio_cloverALC