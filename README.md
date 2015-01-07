![](<../audio_hdmi_guides_rtf/sound.jpeg>)

audio\_cloverALC
================

**Clover Patched Realtek ALC Audio - Native AppleHDA/No Patching/Persistent**

The Clover Patched Realtek ALC method, applied to the native AppleHDA.kext,
enables full onboard, HDMI and DP audio (Note 1). The Clover Patched AppleHDA
ALC method installs renamed layout and platform files in the native
AppleHDA.kext and injects binary patch and config data.

 

**Updates​**

1.  v3.6 - audio\_cloverALC-100.sh (v1.0.4) release: ALC1150 patch fix, 887/888
    legacy detection, Clover/Legacy support, bug fixes

2.  v3.5 - Realtek ALC AppleHDA - [No Audio After Sleep/Wake [Fixes]][1]

    [1]: <https://github.com/toleda/audio_RealtekALC >

3.  v3.4 - BRIX/ALC269, BRIX Pro/ALC283 and NUC/ALC283 Support (Note 6)

4.  v3.3 - audio\_cloverALC-100.sh (v1.0.3) release

5.  v3.2 - audio\_cloverALC-100 UI update, ALC88x Current replaces ALC88x Legacy

6.  v3.1 - Yosemite/config-audio\_cloverALC-x99.plist added

7.  v3 - Yosemite/10.10.x, Mavericks/10.9.x and Mountain Lion/10.8.x support
    Note: audio\_cloverALC-90\_v2.command deprecated

8.  v2.2 - x99 motherboard support (temporary, Note 5)

9.  v2.1 - 9 Series/EAPD added to 887, 892, 898, 1150, credit: kidalive

10. v2 - new script, no downloads, double click and done.

11. 10.10 - Yosemite Initial Realtek ALC support Update:

12. 10.9 - 9series/Realtek ALC support (Mavericks only, Note 4)

 

**Installation**

1.  Clover patched AppleHDA

    1.  audio\_cloverALC-100.command.zip (above)

    2.  Download (View Raw)

    3.  Double click: Downloads/audio\_cloverALC-100.command

    4.  Password:

    5.  Confirm Codec ALCxxx: (885, 887, 888, 889, 892, 898, 1150 only)

    6.  Clover/Legacy: answer y to Confirm Clover Legacy Install (y/n)

    7.  Clover Audio ID Injection (y/n):

    8.  Use Audio ID: x (y/n):

2.  Restart

3.  Verify ALC onboard audio

    1.  System Preferences/Sound/Output/select audio device

 

**Requirements**

1.  OS X/Clover

    1.  10.10 or newer/v2696 or newer

    2.  10.9 or newer/v2512 or newer

    3.  10.8 or newer/2512 or newer

2.  Native AppleHDA.kext (If not installed, run OS X Installer)

3.  Supported Realtek onboard audio codec

 

**Required Information **(Select one codec and Audio ID)

1.  Supported codecs (Realtek ALC)

    1.  269 (BRIX only, Note 6)

    2.  283 (BRIX Pro and NUC, Note 6)

    3.  885

    4.  887

    5.  888

    6.  889

    7.  892

    8.  898

    9.  1150

2.  Supported Audio IDs (Definitions, Note 2)

    1.  Audio ID: 1 supports 269, 283, 885, 887, 888, 889, 892, 898, 1150

    2.  Audio ID: 2 supports 887, 888, 889, 892, 898, 1150

    3.  Audio ID: 3 supports 887, 888, 889, 892, 898

 

**OS X Unsupported Chipsets**

1.  9 Series motherboard support (Mavericks, Note 4)

2.  X99 motherboard support (Note 5)

 

**Other OS X Realtek ALC Onboard Audio Solutions**

1.  [audio\_pikeralphaALC][2]

    [2]: <https://github.com/toleda/audio_pikeralphaALC>

2.  [audio\_RealtekALC][3]

    [3]: <https://github.com/toleda/audio_RealtekALC>

 

**Notes**

1.  HDMI/DP audio may require (see [audio/CloverHDMI][4])

    [4]: <https://github.com/toleda/audio_CloverHDMI>

    1.  dsdt/ssdt edits

    2.  framebuffer edits

2.  Audio ID definitions (Audio ID = HDEF/layout-id)

    1.  Audio ID: 1 for 3/5/6 audio port analog audio

    2.  Audio ID: 2 for 3 audio port analog 5.1 surround sound

    3.  Audio ID: 3 for HD3000/HD4000 HDMI audio and analog audio

3.  Recommendation

    1.  If audio fails after Software Update

        1.  Install AppleHDA.kext (previous working native AppleHDA.kext)

        2.  Run audio\_cloverALC-100.command

4.  OS X/AppleHDA.kext/9 Series motherboard support (Mavericks only, select 1 or
    2)

    1.  Install/config.plist/KextsToPatch:
        config-audio\_cloverALC-9series.plist.zip

    2.  ApppleHDAController binary patch:

        1.  Find: 20 8C

        2.  Replace (4x): A0 8C

        3.  Save

        4.  Restart

5.  OS X/AppleHDA.kext/x99 motherboard support (temporary, select 1 or 2)

    1.  Install/config.plist/KextsToPatch: config-audio\_cloverALC-x99.plist.zip

    2.  AppleHDAController binary patch:

        1.  Find: 20 8C

        2.  Replace (4x): 20 8D

        3.  Save

        4.  Restart

6.  BRIX/ALC269, BRIX Pro/ALC283 and NUC/ALC283 Support

    1.  Installation methods

        1.  cloverALC/Clover patched

    2.  Audio Devices

        1.  ALC269 - BRIX/Headphones and SPDIF out

        2.  ALC283 - BRIX Pro and NUC/Headphones (Microphone is not supported)

        3.  HDMI audio with dsdt edits or ssdt, see

            1.  [HD4600][5]

                [5]: <https://github.com/toleda/audio_hdmi_8series>

            2.  [HD4000][6]

                [6]: <https://github.com/toleda/audio_hdmi_hd4000>

**Tools**

1.  [Clover Configurator][7]

    [7]: <http://www.osx86.net/files/file/49-clover-configurator/>

2.  [Clover Wiki][8]

    [8]: <http://clover-wiki.zetam.org/Home>

3.  Property List Editor - Xcode, Property List Editor, PlistEdit Pro, TextEdit,
    etc.

4.  [IOReg (Download/Select View Raw)][9]

    [9]: <https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip>

5.  [DPCIManger][10]

    [10]: <http://sourceforge.net/projects/dpcimanager/>

 

**Problem Reporting** (include the following information)

1.  Description of onboard audio problem

    1.  OS X version/motherboard model/BIOS version/processor/graphics

    2.  Procedure/Guide Used

    3.  Copy of IOReg - IOReg/File/Save a Copy As…, verify file (no ioreg.txt)

    4.  Installed S/L/E/AppleHDA.kext

    5.  DPCIManager/Misc/Boot Log

    6.  Screenshot of System Information/Hardware/Audio/Intel High Definition
        Audio (not Devices)

    7.  Console/All Messages/kernel Sound assertions selected/Save Selection
        As….

    8.  EFI/CLOVER/config.plist

    9.  EFI/CLOVER/ACPI/Patched/dsdt.aml (if installed)

    10. EFI/CLOVER/ACPI/Patched/ssdt.aml (if installed)

2.  Post to:

    1.  [tonymacx86 - Realtek ALC AppleHDA][11]

        [11]: <http://www.tonymacx86.com/audio/143752-no-audio-devices-realtek-alc-applehda-guide.html#post886726>

    2.  [InsanelyMac- Realtek ALC AppleHDA][12]

        [12]: <http://www.insanelymac.com/forum/topic/298819-yosemite-audio-realtek-alc-applehda/>

 

**Clover Patched AppleHDA Method** Credit: abxite

1.  Native AppleHDA.kext

    1.  renamed layouts and platforms installed, persistent

2.  Clover/Devices/Audio/Inject/Audio ID

3.  Clover/patch kernel cache on boot

    1.  KernelAndKextPatches/KextsToPatch/AppleHDA

    2.  EFI/Clover/kexts/10.10 or 10.9 or 10.8/realtekALC.kext (ConfigData)

 

Credit

bcc9, RevoGirl, PikeRAlpha, SJ\_UnderWater, RehabMan, TimeWalker75a,
[abxite][13]

[13]: <http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647>

toleda https://github.com/toleda/audio\_cloverALC
