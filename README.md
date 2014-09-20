audio_cloverALC
============
Clover Patched Realtek ALC Audio - Native AppleHDA.kext/No Patching/Most Persistant

The Clover Patched Realtek ALC method, applied to the native AppleHDA.kext, enables full onboard, HDMI and DP audio. The Clover Patched AppleHDA ALC method installs renamed layout and platform files in the native AppleHDA.kext and injects binary patch and config data.

Update: v2.2 - X99 motherboard support (temporary, see Note 5)  
Update: v2.1 - 9 Series/EAPD added to 887, 892, 898, 1150, credit: kidalive  
Update: v2 - new script, no downloads, double click and done.  
Update: 10.10 - Yosemite Initial Realtek ALC support  
Update: 10.9 - 9series/Realtek ALC support (temporary, see Note 4)  

### Other OS X Realtek ALC Onboard Audio Solutions
  * [audio_pikeralphaALC](https://github.com/toleda/audio_pikeralphaALC)
  * [audio_RealtekALC](https://github.com/toleda/audio_RealtekALC)

### Unsupported Chipsets (OS X)
  * 9 Series motherboard support (see Note 4 below)
  * X99 motherboard support (see Note 5 below)

### Requirements
	* OS X/Clover
		1. 10.10 or newer/v2696 or newer
		2. 10.9 or newer/v2512 or newer
		3. 10.8 or newer/2512 or newer
	* Native AppleHDA.kext (If not installed, apply Combo Update)
	* Supported Realtek onboard audio codec

### Installation

1. Choose a codec/ALC  
	* 885  
	* 887  
	* 888  
	* 889  
	* 892  
	* 898  
	* 1150 (see Note 6.)  
2. Choose a Layout ID
	* Layout ID 1 supports 885, 887, 888, 889, 892, 898, 1150
	* Layout ID 2 supports 887, 888, 889, 892, 898, 1150
	* Layout ID 3 supports 887, 888, 889, 892, 898

Clover Patched AppleHDA Method ([Credit: abxite](http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647))
  1. Native AppleHDA.kext
      1. renamed layouts and platforms installed, persistent 
  2. Clover/Devices/Audio/Inject/Audio ID
  3. Clover/patch on boot
      1. KernelAndKextPatches/KextsToPatch/AppleHDA and AppleHDAController
      2. EFI/Clover/kexts/10.10 or 10.9/realtekALC.kext (ConfigData)

Clover Patched AppleHDA - Installation
  1. v2 Clover Realtek ALC AppleHDA.kext  (patch in place)
	1. https://github.com/toleda/audio_RealtekALC/blob/master/audio_cloverALC-90_v2.1_patch.command.zip
	2. Download (View Raw)
	3. Double click Downloads/clover-90_patch_v2.command
	4. Password?
	5. Verify Codec? (885, 887, 888, 889, 892, 898, 1150 only)
	6. Legacy_v100202 - y/n? (887, 888 only)
  2. Restart
  3. Verify ALC onboard audio
	1. System Preferences/Sound/Output/select audio device	

Notes
  1. HDMI/DP audio may require
	1. dsdt/ssdt edits
	2. framebuffer edits
  2. Layout Definitions
	1 - 3/5/6 audio port analog audio
	2 - 3 audio port analog audio
	3 - HD3000/HD4000 HDMI audio and analog audio
  3. Recommendations
	1. Rename backup AppleHDA.kext after each Software Update
	   1. Rename Desktop/AppleHDA-orig.kext to AppleHDA-10-9-x.kext
	2. If audio fails after Software Update
	   1. Install AppleHDA-10-9-x-1.kext (previous working native AppleHDA.kext)
  4. OS X/AppleHDA.kext/9 Series motherboard support (temporary, select one)
	1. Install/config.plist/KextsToPatch: config-audio_cloverALC-9series.plist.zip
	2. ApppleHDAController binary patch:
	   1. Find: 20 8C
	   2. Replace (4x): A0 8C
	   3. Save
	   4. Restart
  5. OS X/AppleHDA.kext/X99 motherboard support (temporary, select one)
	1. Install/config.plist/KextsToPatch: config-audio_cloverALC-9series.plist.zip
	   1. Edit patch for replace value below
	2. ApppleHDAController binary patch:
	   1. Find: 20 8C
	   2. Replace (4x): 20 8D
	   3. Save
	   4. Restart
  6. 1150 only: edit config.plist/KernelAndKextPatches/KextsToPatch/
	   "10.9/AppleHDA/Realtek ALC1150"
	   1. Clover Configurator/Property List Editor/Replace
	      1. Before: <09ec10>
	      2. After: <0009ec10>
	   2. TextEdit/Replace
	      1. Before: CewQ
	      2. After: AAnsEA==

### Tools
  * [Clover Configurator](http://www.osx86.net/files/file/49-clover-configurator/)
  * [Clover Wiki](http://clover-wiki.zetam.org/Home)
  * Property List Editor - [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12), Property List Editor, PlistEdit Pro, TextEdit, etc.
  * [IOReg](https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip)

### Problem Reporting (include the following information)
  * Description of onboard audio problem
  * OS X version/motherboard model/BIOS version/processor/graphics
  * Procedure/Guide Used
  * Copy of IOReg - IOReg_v2.1/File/Save a Copy As…, verify file (no ioreg.txt)
  * Clover
	1. EFI/Clover/config.plist
	2. EFI/Clover/misc/debug.log (Set config.plist/Boot/Debug/YES)
	3. EFI/Clover/ACPI/Patched/dsdt.aml (if installed) 
	4. EFI/Clover/ACPI/Patched/ssdt.aml (if installed)  
  * Post to:
	1. http://www.tonymacx86.com/audio/112461-mavericks-no-audio-realtek-alc-applehda.html
	2. http://www.insanelymac.com/forum/topic/298819-yosemite-audio-realtek-alc-applehda/
	3. http://www.insanelymac.com/forum/topic/293001-mavericks-realtek-alc-applehda-audio/

[Clover Patched AppleHDA Method/Terminal Output](output.txt)
