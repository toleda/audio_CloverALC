audio_cloverALC
============
Clover Patched Realtek ALC Audio - Native AppleHDA.kext/No Patching/Most Persistent

The Clover Patched Realtek ALC method, applied to the native AppleHDA.kext, enables full onboard, HDMI and DP audio (Note A). The Clover Patched AppleHDA ALC method installs renamed layout and platform files in the native AppleHDA.kext and injects binary patch and config data. 

Update: v3.5 - Realtek ALC AppleHDA - No Audio After Sleep/Wake [Fixes]
        See https://github.com/toleda/audio_RealtekALC
Update: v3.4 - BRIX/ALC269, BRIX Pro/ALC283 and NUC/ALC283 Support, see Note G
Update: v3.3 - audio_cloverALC-100.sh (v1.0.3) release
Update: v3.2 - audio_cloverALC-100 UI update, ALC88x Current replaces ALC88x Legacy
Update: v3.1 - Yosemite/config-audio_cloverALC-x99.plist added
Update: v3 - Yosemite/10.10.x, Mavericks/10.9.x and Mountain Lion/10.8.x support
	Note: audio_cloverALC-90_v2.command deprecated
Update: v2.2 - x99 motherboard support (temporary, see Note E)
Update: v2.1 - 9 Series/EAPD added to 887, 892, 898, 1150, credit: kidalive
Update: v2 - new script, no downloads, double click and done.
Update: 10.10 - Yosemite Initial Realtek ALC support
Update: 10.9 - 9series/Realtek ALC support (Mavericks, see Note D)

Clover Patched AppleHDA Method, Credit: abxite
  A. Native AppleHDA.kext
	1. renamed layouts and platforms installed, persistent 
  B. Clover/Devices/Audio/Inject/Audio ID
  C. Clover/patch on boot
	1. KernelAndKextPatches/KextsToPatch/AppleHDA and AppleHDAController
	2. EFI/Clover/kexts/10.10 or 10.9/realtekALC.kext (ConfigData)

Clover Patched AppleHDA - Installation
  A. Clover Realtek ALC AppleHDA.kext  (patch in place)
	1. audio_cloverALC-100.command.zip (above)
	2. Download (View Raw)
	3. Double click Downloads/audio_cloverALC-100.command
	4. Password:
	5. Confirm Codec ALCxxx: (885, 887, 888, 889, 892, 898, 1150 only)
	6. Current_v100302 (y/n): (887, 888 only)
	7. Clover Audio ID Injection (y/n):
	8. Use Audio ID: x (y/n):
  B. 1150, see Note F
  C. Restart
  D. Verify ALC onboard audio
	1. System Preferences/Sound/Output/select audio device	

Other OS X Realtek ALC Onboard Audio Solutions
  A. https://github.com/toleda/audio_pikeralphaALC
  B. https://github.com/toleda/audio_RealtekALC

Requirements
  A. OS X/Clover
	1. 10.10 or newer/v2696 or newer
	2. 10.9 or newer/v2512 or newer
	3. 10.8 or newer/2512 or newer
  B. Native AppleHDA.kext  (If not installed, run OS X Installer)
  C. Supported Realtek onboard audio codec

Required Information (Select one from each category)
  A. Codec Support (Realtek ALC)
	1. 269 (BRIX only)
	2. 283 (BRIX Pro and NUC)
	3. 885
	4. 887
	5. 888
	6. 889
	7. 892
	8. 898
	9. 1150 (see Note F)
  B. Layout ID Support (Definitions, Note B)
	1. 269, 283. 885, 887, 888, 889, 892, 898, 1150
	2. 887, 888, 889, 892, 898, 1150
	3. 887, 888, 889, 892, 898

OS X Unsupported Chipsets
  A. 9 Series motherboard support (Mavericks, see Note D)
  B. X99 motherboard support (see Note E)

Notes
  A. HDMI/DP audio may require
	1. dsdt/ssdt edits
	2. framebuffer edits
  B. Layout Definitions
	1 - 3/5/6 audio port analog audio
	2 - 3 audio port analog audio
	3 - HD3000/HD4000 HDMI audio and analog audio
  C. Recommendations
	1. Rename backup AppleHDA.kext after each Software Update
	   a. Rename Desktop/AppleHDA-orig.kext to AppleHDA-10.10.x.kext
	2. If audio fails after Software Update
	   a. Install AppleHDA-10-10.x.kext (previous working native AppleHDA.kext)
  D. OS X/AppleHDA.kext/9 Series motherboard support (Mavericks only, select one)
	1. Install/config.plist/KextsToPatch: config-audio_cloverALC-9series.plist.zip
	2. ApppleHDAController binary patch:
	   a. Find: 20 8C
	   b. Replace (4x): A0 8C
	   c. Save
	   d. Restart
  E. OS X/AppleHDA.kext/x99 motherboard support (temporary, select one)
	1. Install/config.plist/KextsToPatch: config-audio_cloverALC-x99.plist.zip
	2. AppleHDAController binary patch:
	   a. Find: 20 8C
	   b. Replace (4x): 20 8D
	   c. Save
	   d. Restart
  F. 1150 only: edit config.plist/KernelAndKextPatches/KextsToPatch/
	   "10.9 or 10.10/AppleHDA/Realtek ALC1150"
	1. Clover Configurator/Property List Editor/Replace/
	   a. Before: <09ec10>
	   b. After: <0009ec10>
	2. TextEdit/Replace
	   a. Before: CewQ
	   b. After: AAnsEA==
  G. BRIX/ALC269, BRIX Pro/ALC283 and NUC/ALC283 Support
	1. Installation methods
	   a. cloverALC/Clover patched
	2. Audio Devices
	   a. ALC269 - BRIX/Headphones and SPDIF out
	   b. ALC283 - BRIX Pro and NUC/Headphones (Microphone is not supported)
	   c. HDMI audio with dsdt edits or ssdt, see
	      i.  HD4600 - https://github.com/toleda/audio_hdmi_8series
	      ii. HD4000 - https://github.com/toleda/audio_hdmi_hd4000

Tools
  A. Clover Configurator - http://www.osx86.net/files/file/49-clover-configurator/
  B. Clover Wiki - http://clover-wiki.zetam.org/Home
  C. Property List Editor - Xcode, Property List Editor, PlistEdit Pro, TextEdit, etc.
  D. IOReg (Download/Select View Raw) - https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip
  E. DPCIManger - http://sourceforge.net/projects/dpcimanager/

Problem Reporting (include the following information)
  A. Description of onboard audio problem
	1. OS X version/motherboard model/BIOS version/processor/graphics
	2. Procedure/Guide Used
	3. Copy of IOReg - IOReg_v2.1/File/Save a Copy As…, verify file (no ioreg.txt)
	4. Installed S/L/E/AppleHDA.kext
 	5. DPCIManager/Misc/Boot Log
	6. Screenshot of System Information/Hardware/Audio/Intel High
           Definition Audio (not Devices)
	7. Console/All Messages/kernel Sound assertions selected/Save
           Selection As….
	8. EFI/CLOVER/config.plist
	9. EFI/CLOVER/ACPI/Patched/dsdt.aml (if installed) 
	10. EFI/CLOVER/ACPI/Patched/ssdt.aml (if installed)  
  B. Post to:
	1. http://www.tonymacx86.com/audio/112461-mavericks-no-audio-realtek-alc-applehda.html
	2. http://www.insanelymac.com/forum/topic/298819-yosemite-audio-realtek-alc-applehda/
	3. http://www.insanelymac.com/forum/topic/293001-mavericks-realtek-alc-applehda-audio/

Credit
bcc9, RevoGirl, PikeRAlpha, SJ_UnderWater, RehabMan, TimeWalker75a
abxite http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647

toleda
https://github.com/toleda/audio_cloverALC