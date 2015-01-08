![alt text](https://github.com/toleda/audio_RealtekALC/blob/master/sound.jpeg)
#audio\_cloverALC

**OS X/Clover Patched AppleHDA Realtek ALC Audio**
- Native AppleHDA/Persistent

The Clover Patched Realtek ALC method enables OS X AppleHDA onboard audio with or without HDMI and DP audio. The script adds codec specific layout and platform files and injects binary patch and pin configuration data to the native installed AppleHDA.kext.

**Versions: audio_cloverALC-100**

1. Easy: .command, see C. Installation
2. Bash: .sh, see D. Terminal

**Updates**

1.  v3.6 - audio_cloverALC-100.sh (v1.0.4) release: ALC1150 patch fix, 887/888
    legacy detection, Clover/Legacy support, bug fixes
2.  v3.5 - Realtek ALC AppleHDA - [No Audio After Sleep/Wake](https://github.com/toleda/audio_ALC_guides)
3.  v3.4 - BRIX/ALC269, BRIX Pro/ALC283 and NUC/ALC283 Support
4.  v3.3 - audio\_cloverALC-100.sh (v1.0.3) release
5.  v3.2 - audio\_cloverALC-100 UI update, ALC88x Current replaces ALC88x Legacy
6.  v3.1 - Yosemite/config-audio\_cloverALC-x99.plist added
7.  v3 - Yosemite/10.10.x, Mavericks/10.9.x and Mountain Lion/10.8.x support
    Note: audio\_cloverALC-90\_v2.command deprecated
8.  v2.2 - x99 motherboard support (D. More Information)
9.  v2.1 - 9 Series/EAPD added to 887, 892, 898, 1150, credit: kidalive
10. v2 - new script, no downloads, double click and done.
11. 10.10 - Yosemite Initial Realtek ALC support Update
12. 10.9 - 9 Series/Realtek ALC support

**A. Requirements**

1.  OS X/Clover_v2696 or newer
    1.  10.10/Yosemite
    2.  10.9/Mavericks
    3.  10.8/Mountain Lion
2.  Native AppleHDA.kext
3.  Supported Realtek onboard audio codec

**B. Realtek ALCxxx** (verify codec and Audio ID)

1.  Supported codecs
    1.  269 (BRIX only)
    2.  283 (BRIX Pro and NUC)
    3.  885
    4.  887
    5.  888
    6.  889
    7.  892
    8.  898
    9.  1150
2.  Supported Audio IDs
    1.  Audio ID: 1 supports 269, 283, 885, 887, 888, 889, 892, 898, 1150

        Realtek ALC audio (default, 1/2/3/5/6 motherboard audio ports)
    2.  Audio ID: 2 supports 887, 888, 889, 892, 898, 1150

        Realtek ALC/5.1 surround sound (3 motherboard audio ports)
    3.  Audio ID: 3 supports 887, 888, 889, 892, 898

        HD3000/HD4000 HDMI audio with Realtek ALC audio

**C. Installation**

1.  Clover patched AppleHDA

    1.  [Download (View Raw) audio\_cloverALC-100.command](https://github.com/toleda/audio_CloverALC/blob/master/audio_cloverALC-100.command.zip)
    2.  Double click: Downloads/audio\_cloverALC-100.command
    3.  Password:
    4.  Confirm Codec ALCxxx: (885, 887, 888, 889, 892, 898, 1150 only)
    5.  Clover/Legacy: answer y to Confirm Clover Legacy Install (y/n)
    6.  Clover Audio ID Injection (y/n):
    7.  Use Audio ID: x (y/n):
    8.  Optional: Terminal/Terminal Saved Output
2.  Restart
3.  Verify ALC onboard audio
    1.  System Preferences/Sound/Output/select audio device

**D. Terminal**

1. [audio_cloverALC-100_v1.0.4](https://github.com/toleda/audio_RealtekALC/blob/master/audio_realtekALC-100.sh): 887/888 legacy detection, bug fixes
2. v1.0.3: First release

**E. More Information**

1. [Details](https://github.com/toleda/audio_RealtekALC/blob/master/DETAILS.md)
    1.  Onboard Audio Solutions
    2.  Requirements - Supported/Unsupported
    3.  Notes
    4.  Guides
    5.  Tools
    6.  Problem Reporting
2. Terminal Saved Output
    1.  [Clover/EFI](https://github.com/toleda/audio_RealtekALC/blob/master/Terminal%20Saved%20Output_v1.0.4-efi)
    2.  [Clover/Legacy](https://github.com/toleda/audio_RealtekALC/blob/master/Terminal%20Saved%20Output_v1.0.4-leg)

Credit
THe KiNG, bcc9, RevoGirl, PikeRAlpha, SJ\_UnderWater, RehabMan, TimeWalker75a, [abxite](http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647)

toleda https://github.com/toleda/audio_cloverALC