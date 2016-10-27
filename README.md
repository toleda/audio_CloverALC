![alt text](https://github.com/toleda/audio_RealtekALC/blob/master/sound.jpeg)
#audio\_cloverALC
Realtek ALC/Desktop: 269(1), 283(1), 885, 887, 888, 892, 898 and 1150 on board audio  (1) BRIX/NUC only  
Supports OS X: 10.12, 10.11, 10.10, 10.9 and 10.8  
Native AppleHDA/Persistent

**OS X/Clover patched AppleHDA Realtek ALC Audio**  

The Clover/kext patched Realtek ALC method enables OS X AppleHDA onboard audio with or without HDMI and DP audio. The script adds codec specific layout and platform files and injects binary patch and pin configuration data to the native installed AppleHDA.kext.

Clover version of Piker Alpha/AppleHDA8Series.sh. The script adds AppleHDA.kext kernel cache patches to config.plist and installs L/E/AppleHDAxxx.kext (xxx = codec)

**Updates**

1. 10/26/16 - 10.12 support
2. 7/15/16 - Initial 10.12 support, try -120 versions
2. 12/14/15 - audio_pikeralpha-110 (Clover version of Piker Aplha AppleHDA8Series.sh)
2. 11/8/15 - Skylake/Series 100 Update, Add 1150/Audio ID: 3
3. 7/19/15 - 283 Update
4. 6/15/15 - 10.11 - El Capitan Realtek ALC AppleHDA.kext Initial Support

**Versions: audio_cloverALC-120**

1. Easy: .command, see A. Installation
2. Bash: .sh, see B. Terminal

**A. Installation**

1.  Clover/kext patched AppleHDA
    1.  [audio\_cloverALC-120.command](https://github.com/toleda/audio_CloverALC/blob/master/audio_cloverALC-120.command.zip) (select View Raw) 
    or [audio\_pikeralphaALC-120.command](https://github.com/toleda/audio_CloverALC/blob/master/audio_pikeralphaALC-120.command.zip) (select View Raw)
    2.  Double click: Downloads/audio_cloverALC-120.command
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
    1. [audio\_cloverALC-120.sh](https://github.com/toleda/audio_CloverALC/blob/master/audio_cloverALC-120.sh) (select View Raw)
    2. Terminal $ cd Downloads
    3. Terminal $ mv audio\_cloverALC-120....command audio\_cloverALC-120....sh
    3. Terminal $ ./audio\_cloverALC-120....sh
    3. Same (as above)

**C. Requirements**

1.  OS X Versions (+ all)
    1.  10.12+/Sierra 
    2.  10.11+/El Capitan
    2.  10.10+/Yosemite
    3.  10.9+/Mavericks
    4.  10.8+/Mountain Lion
2. Boot Flags/Boot failure may result if ignored
	1.	10.11+/Disable SIP/set, restart, install, enable SIP, restart
		1.	CLOVER/config.plist/
			1. ACPI/DSDT/Fixes/NO (all or remove)
			2.	RtVariables/BooterConfig/0x28
			3.	RtVariables/CsrActiveConfig/0x3
	2.	10.10+/Allow unsigned kexts/set, restart, install
		1.	Clover/config.plist
			1. ACPI/DSDT/Fixes/NO (all or remove)
			2.	Boot/Arguments/kext-dev-mode=1
3.  [Native AppleHDA.kext](https://github.com/toleda/audio_ALC_guides/blob/master/Restore%20native%20AppleHDA%20%5BGuide%5D.pdf)
4.  Audio codec? See Tools 4.

**D. Realtek ALCxxx** - Verify, see Tools 4.

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
    1. Audio ID: 1 - supports 269, 283, 885, 887, 888, 889, 892, 898, 1150  
        Realtek ALC audio (default, 1/2/3/5/6 motherboard audio ports)

    2. Audio ID: 2 - supports 887, 888, 889, 892, 898, 1150  
        Realtek ALC/5.1 surround sound (3 motherboard audio ports)
    3. Audio ID: 3 - supports 887, 888, 889, 892, 898 
        HD3000/HD4000 HDMI audio with Realtek ALC audio

**E. More Information**

1. [Realtek ALC AppleHDA](https://github.com/toleda/audio_ALC_guides/blob/master/Realtek%20ALC%20AppleHDA.pdf)

    1. Installation
    2. Details/Support  
    3. Troubleshooting
2. [Realtek ALC guides](https://github.com/toleda/audio_ALC_guides)
	1. Enhancemants
		1. Customization
		2. Surround Sound
	2. Troubleshooting
		1. No Audio Devices
		2. No Sound
		3. No Audio After Sleep/Wake
	3. Utilities
		1. Identify Audio Codec
		2. Restore native AppleHDA  
3. Terminal Saved Output
 	   1.  [Clover/EFI](https://github.com/toleda/audio_CloverALC/blob/master/Terminal:audio_cloverALC-110-efi.txt)
 	   2.  [Clover/Legacy](https://github.com/toleda/audio_CloverALC/blob/master/Terminal:audio_cloverALC-110-legacy.txt)

**F. [Problem Reporting](https://github.com/toleda/audio_ALC_guides/blob/master/Problem%20Reporting.md)**

1.	Problem Reporting/Post to
2.	Problem Reporting/Attached requested files

Credit
THe KiNG, bcc9, RevoGirl, PikeRAlpha, SJ\_UnderWater, RehabMan, TimeWalker75a, lisai9093, [abxite](http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647)

toleda https://github.com/toleda/audio_cloverALC
