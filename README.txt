Clover Realtek ALC Audio - No Patching/Persistant

The Realtek ALC AppleHDA Support kext installed with the native AppleHDA.kext enables full onboard, HDMI and DP audio (Note 1).  The ALC Support kext provides  pin configuration, layout and pathmap injection and Clover provides audio codec binary patching.

Requirements
  1. Clover
  2. Mavericks
  3. Native AppleHDA.kext  (If not installed, apply Combo Update)
  4. Supported Realtek on board audio codec

Required Information (Select one from each category)
  1. Codec/ALC
	1. 885
	2. 887 (Legacy, Note 2)
	3. 888 (Legacy, Note 2)
	4. 889
	5. 892
	6. 898
	7. 1150
  2. Layout  (Definitions, Note 3)
	1. 885, 887, 888, 889, 892, 898, 1150
	2. 887, 888, 889, 892, 898, 1150
	3. 887, 888, 889, 892, 898
  3. Mavericks version (Info.plist reference)
	1. 10.9 (-90),
	2. 10.9.1(-91)

Steps
  1. Clover (Use Clover Configurator, Xcode, Property List Editor, etc.)
	1. Downloads/audio_CloverALC-master/config-realtek_alc_audio.plist
	2. EFI/Clover/config.plist/Add
	  1. Kernel and KextsPatches/KextsToPatch/ALC---- Codec Patch
	  2. Devices/Audio/Inject/Layout
	  3. Save
  2. ALC Support kext (Use Terminal)
	1. https://github.com/Piker-Alpha/AppleHDA8Series.sh 
	2. Download Zip
	3. $ cd Downloads/AppleHDA8Series.sh-master 
	4. $ ./AppleHDA8Series  (no arguments required)
	5. Password
	6. Codec
	7. Layout
	8. Version
	9. Install S/L/E
  3. Restart
  4. Verify ALC AppleHDA Support kext installed
	1. S/L/E/AppleHDA885
	2. S/L/E/AppleHDA887 
	3. S/L/E/AppleHDA888
	4. S/L/E/AppleHDA889
	5. S/L/E/AppleHDA892
	6. S/L/E/AppleHDA898
	7. S/L/E/AppleHDA1150
  5. Verify ALC onboard audio

Notes
  1. HDMI/DP audio may require
	1. dsdt/ssdt edits
	2. framebuffer edits
  2. 887/888 Legacy
	1.  Replace AppleHDALoader.kext/Contents/Resources/Platforms.xml.zlib
            with Legacy Platforms.xml.zlib (v100202) from:
		1. https://github.com/toleda/audio_ALC887
		2. https://github.com/toleda/audio_ALC888
  3. Layout Definitions
	1 - 3/5/6 audio port analog audio
	2 - 3 audio port analog audiio
	3 - HD3000/HD4000 HDMI audio and analog audio
  4. Recommendations
	1. Backup native AppleHDA.kext after each Software Update
	2. If audio fails after Software Update
		1. Install AppleHDA.kext backup (previous working native
                   AppleHDA.kext)

Problem Reporting (include the following information)
  1. Description of audio problem
	1. OS X version/motherboard model/BIOS version/processor/graphics
	2. Procedure/Guide Used/AppleHDA.kext version
	3. AppleHDA(codec).kext (i.e., AppleHDA1150.kext)
	4. Copy of IOReg - IOReg_v2.1/File/Save a Copy As…, verify file (not
           ioreg.txt)
	5. Extra/dsdt.aml (if installed)
	6. Console/All Messages/kernel Sound assertions selected/Save
           Selection As…..
	7. Screenshot of System Information/Hardware/Audio/Intel High
           Definition Audio (not Devices)
  2. Post to:
	1. http://www.tonymacx86.com/audio/112461-mavericks-no-audio-realtek-alc-applehda.html
	2. http://www.insanelymac.com/forum/topic/293001-mavericks-realtek-alc-applehda-audio/

Credit: PikeRAlpha http://pikeralpha.wordpress.com/2014/01/05/new-style-of-applehda-kext-patching-take-ii/