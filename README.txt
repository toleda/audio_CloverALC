audio_cloverALC
============
Clover Patched Realtek ALC Audio - Native AppleHDA.kext/No Patching/Most Persistant

The Clover Patched Realtek ALC method, applied to the native AppleHDA.kext, enables full onboard, HDMI and DP audio (Note 1). The Clover Patched AppleHDA ALC method installs renamed layout and platform files in the native AppleHDA.kext and injects binary patch and config data. 
____________________________________________________________Download ZIP >  > 

Update: 10.10 - Yosemite Initial Realtek ALC support
Update: 10.9 - 9series/Realtek ALC support (temporary), see Note 5

Requirements
  1. OS X/Clover
	1. 10.10 or newer/v2696 or newer
	2. 10.9 or newer/v2512 or newer
  2. Native AppleHDA.kext  (If not installed, apply Combo Update)
  3. Supported Realtek on board audio codec

Required Information (Select one from each category)
  1. Codec/ALC - Select link/Select Download ZIP
	1. 885 https://github.com/toleda/audio_ALC885
	2. 887 https://github.com/toleda/audio_ALC887
	   1. for 887 Legacy, Note 2
	3. 888 https://github.com/toleda/audio_ALC888
	   1. for 888 Legacy, Note 2
	4. 889 https://github.com/toleda/audio_ALC889
	5. 892 https://github.com/toleda/audio_ALC892
	6. 898 https://github.com/toleda/audio_ALC898
	7. 1150 https://github.com/toleda/audio_ALC1150
  2. Layout ID Support (Definitions, Note 3)
	1. 885, 887, 888, 889, 892, 898, 1150
	2. 887, 888, 889, 892, 898, 1150
	3. 887, 888, 889, 892, 898

Clover Patched AppleHDA Method, Credit: abxite
  1. Native AppleHDA.kex
      1. renamed layouts and platforms installed, persistent 
  2. Clover/Devices/Audio/Inject/Audio ID
  3. Clover/patch on boot
      1. KernelAndKextPatches/KextsToPatch/AppleHDA and AppleHDAController
      2. EFI/Clover/kexts/10.10 or 10.9/realtekALC.kext (ConfigData)

Clover Patched AppleHDA - Installation
  1. https://github.com/toleda/audio_CloverALC
	1. Select Download ZIP
  2. Clover/config.plist (Use Clover Configurator, Xcode, Property List Editor, etc.)
	1. Open Downloads/audio_CloverALC-master/config-audio_cloverALC.plist
	   1. Double click to open zip
	2. EFI/Clover/config.plist/Add
	   1. Devices/Audio/Inject/Layout (1, 2 or 3)  
	   2. KernelAndKextPatches/KextsToPatch/AppleHDA/Resources/xml>zml
	   3. KernelAndKextPatches/KextsToPatch/AppleHDA/RealtekALCxxx
	   4. Save
  3. Install realtekALC.kext
	1. Copy Downloads/audio_CloverALC-master/realtekALC.kext to:
	   1. EFI/Clover/kexts/10.10/realtekALC.kext
	   2. EFI/Clover/kexts/10.9/realtekALC.kext
  4. Install codec layouts and Platforms (Terminal output below)
	1. Downloads/audio_ALCxxx-master/cloverALC/audio_cloverALCxxx-90_patch.command
	   1. audio_ALCxxx implies specific codec, i.e., ALC898
	   2. If no, Downloads/audio_ALCxxx-master, see Codec/ALC links above
	2. Double click audio_cloverALCxxxx-90_patch.command 
	   1. Verify audio_cloverALCxxxx..., not audio_alcxxx...
	   1. Do not move folder or file
	3. Enter password at prompt
  5. Restart
  6. Verify ALC onboard audio
	1. System Preferences/Sound/Output/select audio device	

Notes
  1. HDMI/DP audio may require
	1. dsdt/ssdt edits
	2. framebuffer edits
  2. 887/888 Legacy
	1.  Rename Platforms.xml.zlib(v100202, below) to Platforms.zml.zlib and copy to
	    S/L/E/AppleHDA.kext/Contents/Resources/Platforms.zml.zlib:
	    1. https://github.com/toleda/audio_ALC887
	    2. https://github.com/toleda/audio_ALC888
  3. Layout Definitions
	1 - 3/5/6 audio port analog audio
	2 - 3 audio port analog audio
	3 - HD3000/HD4000 HDMI audio and analog audio
  4. Recommendations
	1. Rename backup AppleHDA.kext after each Software Update
	   1. Rename Desktop/AppleHDA-orig.kext to AppleHDA-10-9-x.kext
	2. If audio fails after Software Update
	   1. Install AppleHDA-10-9-x-1.kext (previous working native AppleHDA.kext)
  5. Mavericks/10.9.3 and newer/9series/AppleHDA.kext support (Temporary)
	1. See screenshot above
	   1. Clover Configurator-Kernel and Kext Patches-10.9-9series-cloverALC
	2. ApppleHDAController binary patch:
	   1. Find: 20 8C
	   2. Replace (4x): A0 8C
	   3. Save
	   4. Restart

Tools
  1. Clover Configurator - http://www.osx86.net/files/file/49-clover-configurator/
  2. Clover Wiki - http://clover-wiki.zetam.org/Home
  3. Property List Editor - Xcode, Property List Editor, PlistEdit Pro, TextEdit, etc.
  4. IOReg (Download/Select View Raw) - https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip

Problem Reporting (include the following information)
  1. Description of onboard audio problem
  2. OS X version/motherboard model/BIOS version/processor/graphics
  3. Procedure/Guide Used
  3. Copy of IOReg - IOReg_v2.1/File/Save a Copy As…, verify file (no ioreg.txt)
  4. Chimera/Chameleon
	1. Extra/org.chameleon.Boot.plist
	2. DPCIManager/Misc/Boot Log
	3. Extra/dsdt.aml (if installed) 
	4. Extra/ssdt.aml (if installed)
  5. Clover
	1. EFI/Clover/config.plist
	2. EFI/Clover/misc/debug.log (Set config.plist/Boot/Debug/YES)
	3. EFI/Clover/ACPI/Patched/dsdt.aml (if installed) 
	4. EFI/Clover/ACPI/Patched/ssdt.aml (if installed)  
  6. Post to:
	1. http://www.tonymacx86.com/audio/112461-mavericks-no-audio-realtek-alc-applehda.html
	2. http://www.insanelymac.com/forum/topic/298819-yosemite-audio-realtek-alc-applehda/
	3. http://www.insanelymac.com/forum/topic/293001-mavericks-realtek-alc-applehda-audio/

Credit
abxite http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647

toleda
https://github.com/toleda/audio_cloverALC

Clover Patched AppleHDA MethodTerminal Output
$ .../Downloads/audio_ALC1150-master/clover/audio_cloverALC1150-90_patch.command; exit;

Backup AppleHDA.kext to Desktop
Password:
Permissions...
Kernel cache...
Finished.
logout

[Process completed]


toleda
https://github.com/toleda/audio_CloverALC