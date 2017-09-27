![alt text](https://github.com/toleda/audio_RealtekALC/blob/master/sound.jpeg)

#audio\_cloverALC#

**macOS/Clover Patched Desktop AppleHDA Realtek ALC Audio**

Native AppleHDA/Persistent

The Clover Patched Realtek ALC method enables macOS AppleHDA onboard audio with or without HDMI and DP audio. The script adds codec specific layout and platform files and injects binary patch and pin configuration data to the native installed AppleHDA.kext.

**Versions: audio_cloverALC-1x0**

1. Easy: .command, see C. Installation
2. Bash: .sh, see D. Terminal

**Updates**

1. 9-26-17 - 10.13 Support, 269/283 support and pikeralphaALC deprecated
2. 12-14-15 - audio_pikeralpha-110 (Clover version of Piker Aplha AppleHDA8Series.sh)
2. 11-8-15 - Skylake/Series 100 Update, Add 1150/Audio ID: 3
3. 7-19-15 - 283 Update
4. 6-15-15 - 10.11 - El Capitan Realtek ALC AppleHDA.kext Initial Support

**A. Requirements**

1.  macOS/Clover_v2696 or newer
    1.  10.13/High Sierra, disable SIP, mount EFI
    2.  10.12/Sierra, disable SIP, mount EFI
    2.  10.11/El Capitan, set boot flag: rootless=0 
    2.  10.10/Yosemite, set boot flag: kext-dev-mode=1
    3.  10.9/Mavericks
    4.  10.8/Mountain Lionon
2.  Native AppleHDA.kext
    1.  [Need native?](https://github.com/toleda/audio_ALC_guides/blob/master/Restore%20native%20AppleHDA%20%5BGuide%5D.pdf)
3.  Supported Realtek onboard audio codec
    1.  [Unknown codec?](https://github.com/toleda/audio_ALC_guides/blob/master/Identify%20Audio%20Codec%20%5BGuide%5D.pdf)

**B. Realtek ALCxxx** (verify codec and Audio ID)

1.  Supported codecs (* Not supported with audio_pikeralpha-110)
    1.  885
    4.  887
    5.  888
    6.  889
    7.  892
    8.  898
    9.  1150
    10. 1220

2.  Supported Audio IDs
    -  Audio ID: 1 supports 885, 887, 888, 889, 892, 898, 1150, 1220

        Realtek ALC audio (default, 1/2/3/5/6 motherboard audio ports)

    -  Audio ID: 2 supports 887, 888, 889, 892, 898, 1150, 1220

        Realtek ALC/5.1 surround sound (3 motherboard audio ports, 2 in/1 out becomes 3 out)

    -  Audio ID: 3 supports 887, 888, 889, 892, 898, 1150

        HD3000/HD4000 HDMI audio with Realtek ALC audio

**C. Installation**

1.  Clover patched AppleHDA

    1.  [Download (View Raw) audio\_cloverALC-1x0.command (above)
    2.  Double click: Downloads/audio_cloverALC-1x0.command
    3.  Password:
    4.  Confirm Codec ALCxxx: (885, 887, 888, 889, 892, 898, 1150, 1220 only)
    5.  Clover/Legacy: answer y to Confirm Clover Legacy Install (y/n)
    6.  Clover Audio ID Injection (y/n):
    7.  Use Audio ID: x (y/n):
    8.  Optional: Terminal/Terminal Saved Output
2.  Restart
3.  Verify ALC onboard audio
    1.  System Preferences/Sound/Output/select audio device

**D. Terminal**

1.  Clover patched AppleHDA

    1. Download audio\_cloverALC-1x0.sh (above)
    2. Terminal $ ./audio_cloverALC-1x0....sh
    3. Same (as above)

**E. More Information**

1. [Details](https://github.com/toleda/audio_RealtekALC/blob/master/DETAILS.md)
    1.  Onboard Audio Solutions
    2.  Requirements - Supported/Unsupported
    3.  Notes
    4.  Guides
    5.  Tools
    6.  Problem Reporting
2. Terminal Saved Output
    1.  [Clover/EFI](https://github.com/toleda/audio_CloverALC/blob/master/Terminal%20Saved%20Output_v1.0.4-efi.txt)
    2.  [Clover/Legacy](https://github.com/toleda/audio_CloverALC/blob/master/Terminal%20Saved%20Output_v1.0.4-leg.txt)

Credit
THe KiNG, bcc9, RevoGirl, PikeRAlpha, SJ\_UnderWater, RehabMan, TimeWalker75a, lisai9093, [abxite](http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647)

toleda https://github.com/toleda/audio_cloverALC