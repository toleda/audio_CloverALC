audio_cloverALC
============
Clover Patched Realtek ALC Audio - Native AppleHDA.kext/No Patching/Most Persistant

The Clover Patched Realtek ALC method, applied to the native AppleHDA.kext, enables full onboard, HDMI and DP audio (Note 1). The Clover Patched AppleHDA ALC method installs renamed layout and platform files in the native AppleHDA.kext and injects binary patch and config data. 

Update: v3.1 - Yosemite/config-audio_cloverALC-x99.plist added
Update: v3 - Yosemite/10.10.x, Mavericks/10.9.x and Mountain Lion/10.8.x support
	Note: audio_cloverALC-90_v2.command deprecated
Update: v2.2 - x99 motherboard support (temporary, see Note 5)
Update: v2.1 - 9 Series/EAPD added to 887, 892, 898, 1150, credit: kidalive
Update: v2 - new script, no downloads, double click and done.
Update: 10.10 - Yosemite Initial Realtek ALC support
Update: 10.9 - 9series/Realtek ALC support (Mavericks, see Note 4)

Other OS X Realtek ALC Onboard Audio Solutions
  1. https://github.com/toleda/audio_pikeralphaALC
  2. https://github.com/toleda/audio_RealtekALC

Unsupported Chipsets (OS X)
  1. 9 Series motherboard support (Mavericks, see Note 4., below)
  2. X99 motherboard support (see Note 5., below)

Requirements
  1. OS X/Clover
	1. 10.10 or newer/v2696 or newer
	2. 10.9 or newer/v2512 or newer
	3. 10.8 or newer/2512 or newer
  2. Native AppleHDA.kext  (If not installed, run OS X Installer)
  3. Supported Realtek on board audio codec

Required Information (Select one from each category)
  1. Codec Support (Realtek ALC)
	1. 885
	2. 887
	3. 888
	4. 889
	5. 892
	6. 898
	7. 1150 (see Note 6.)
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
  1. Clover Realtek ALC AppleHDA.kext  (patch in place)
	1. https://github.com/toleda/audio_CloverALC/blob/master/audio_cloverALC-100.command.zip
	2. Download (View Raw)
	3. Double click Downloads/audio_cloverALC-100.command
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
  4. OS X/AppleHDA.kext/9 Series motherboard support (Mavericks only, select one)
	1. Install/config.plist/KextsToPatch: config-audio_cloverALC-9series.plist.zip
	2. ApppleHDAController binary patch:
	   1. Find: 20 8C
	   2. Replace (4x): A0 8C
	   3. Save
	   4. Restart
  5. OS X/AppleHDA.kext/x99 motherboard support (temporary, select one)
	1. Install/config.plist/KextsToPatch: config-audio_cloverALC-x99.plist.zip
	   1. Edit patch for replace value below
	2. ApppleHDAController binary patch:
	   1. Find: 20 8C
	   2. Replace (4x): 20 8D
	   3. Save
	   4. Restart
  6. 1150 only: edit config.plist/KernelAndKextPatches/KextsToPatch/
	   "10.9 or 10.10/AppleHDA/Realtek ALC1150"
	   1. Clover Configurator/Property List Editor/Replace/
	      1. Before: <09ec10>
	      2. After: <0009ec10>
	   2. TextEdit/Replace
	      1. Before: CewQ
	      2. After: AAnsEA==

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
  4. Clover
	1. EFI/Clover/config.plist
	2. EFI/Clover/misc/debug.log (Set config.plist/Boot/Debug/YES)
	3. EFI/Clover/ACPI/Patched/dsdt.aml (if installed) 
	4. EFI/Clover/ACPI/Patched/ssdt.aml (if installed)  
  5. Post to:
	1. http://www.tonymacx86.com/audio/112461-mavericks-no-audio-realtek-alc-applehda.html
	2. http://www.insanelymac.com/forum/topic/298819-yosemite-audio-realtek-alc-applehda/
	3. http://www.insanelymac.com/forum/topic/293001-mavericks-realtek-alc-applehda-audio/

Credit
abxite http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647

toleda
https://github.com/toleda/audio_cloverALC

Clover Patched AppleHDA Method/Terminal Output
Last login: Wed Aug  6 16:24:14 on ttys000
 
File: audio_cloverALC-100.command
Verify EFI partition mounted, Finder/Devices/EFI
Verify kext-dev-mode=1 boot flag/argument
Password:
Confirm Realtek ALC1150 (y/n): y
Clover Audio ID injection (y/n): n

Download ALC1150 files ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 21163  100 21163    0     0  15286      0  0:00:01  0:00:01 --:--:-- 15280
Edit config.plist/Devices/Audio/Inject
Edit config.plist/KernelAndKextPatches/KextsToPatch
Download kext patches and merge to config.plist ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1268  100  1268    0     0   5208      0 --:--:-- --:--:-- --:--:--  5218
Install /Volumes/EFI/EFI/CLOVER/kexts/10.10/realtekALC.kext
Download config kext and install ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  3122  100  3122    0     0  10870      0 --:--:-- --:--:-- --:--:-- 10840
Install System/Library/Extensions/AppleHDA.kext/ALC1150 zml files
Fix permissions ...
Kernel cache...
kextcache -Boot -U /
rebuilding //System/Library/Caches/com.apple.kext.caches/Startup/kernelcache
kextcache -arch x86_64 -local-root -all-loaded -kernel /System/Library/Kernels/kernel -prelinked-kernel /System/Library/Caches/com.apple.kext.caches/Startup/kernelcache -volume-root / /System/Library/Extensions /Library/Extensions
kext file:///System/Library/Extensions/Soundflower.kext/ is in hash exception list, allowing to load
kext com.jmicron.JMicronATA  101069000 is in exception list, allowing to load
kext com.intel.driver.EnergyDriver  200009000 is in exception list, allowing to load
kext-dev-mode allowing invalid signature -67030 0xFFFFFFFFFFFEFA2A for kext AppleKextExcludeList.kext
kext com.apple.driver.AppleHDA  26569009000 is in exception list, allowing to load
kext com.apple.driver.AppleHDA  26569009000 is in exception list, allowing to load
Install finished, restart required.
logout

[Process completed]


toleda
https://github.com/toleda/audio_CloverALC