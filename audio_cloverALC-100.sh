#!/bin/sh
# Maintained by: toleda for: github.com/toleda/audio_cloverALC
gFile="audio_cloverALC-100.command_v1.0.4d"
# Credit: bcc9, RevoGirl, PikeRAlpha, SJ_UnderWater, RehabMan, TimeWalker75a
#
# OS X Clover Realtek ALC Onboard Audio
#
# Enables OS X Realtek ALC onboard audio in 10.10, 10.9 and 10.8, all versions
# 1. Supports Realtek ALC885, 887, 888, 889, 892, 898 and 1150
# 2. Clover patched native AppleHDA.kext installed in System/Library/Extensions
#
# Requirements
# 1. OS X/10.10/10.9/10.8, all versions
# 2. Native AppleHDA.kext  (If not installed, run Mavericks installer)
# 3. Supported Realtek ALC on board audio codec (see above)
# 4. Audio ID: 1, 2 or 3 Injection, see https://github.com/toleda/audio_ALCinjection
#
# Installation
# 1. Double click audio_cloverALC-100.command
# 2. Enter password at prompt
# 3. For Clover/EFI, EFI partition must be mounted before running script
# 4. For Clover/Legacy, answer y to Confirm Clover Legacy Install (y/n)
# 5. Confirm Realtek ALCxxx (y/n): (885, 887, 888, 889, 892, 898, 1150)
# 6. Clover Audio ID Injection (y/n):
#    If y:
# 7. Use Audio ID: x (y/n):
#    If n:
#    Audio IDs:
#    1 - 3/5/6 port Realtek ALCxxx audio
#    2 - 3 port (5.1) Realtek ALCxxx audio (n/a 885)
#    3 - HD3000/HD4000 HDMI audio w/Realtek ALCxxx audio (n/a 885/1150 & 887/888 Legacy)
# 8. Select Audio ID (1, 2 or 3)
# 9. Restart
#
# Change log:
# v1.0.4d - 2/17/15: 1. version bug fix
# v1.0.4c - 2/15/15: 1. validate supported realtek codecs, 2. bug fixes
# v1.0.4b - 1/10/15: add fi mistakenly deleted in 4a
# v1.0.4a - 1/9/15: remove error check for 269, 283, 885, remove 889 typo
# v1.0.4 - 1/5/15: 1. ALC1150 patch fix, 2. Clover Legacy support, 3. 887/888 legacy 
# codec detection, 4. bug fixes
#
echo " "
echo "Agreement"
echo "The audio_cloverALC-100 script is for personal use only. Do not distribute" 
echo "the patch, any or all of the files or the resulting patched AppleHDA.kext" 
echo "for any reason without permission. The audio_cloverALC-100 script is" 
echo "provided as is and without any kind of warranty."
echo " "

# set initial variables
gSysVer=`sw_vers -productVersion`
gSysName="Mavericks"
gStartupDisk=EFI
gCloverDirectory=/Volumes/$gStartupDisk/EFI/CLOVER/
gDesktopDirectory=/Users/$(whoami)/Desktop/
gExtensionsDirectory=/System/Library/Extensions
gHDAContentsDirectory=$gExtensionsDirectory/AppleHDA.kext/Contents
gHDAHardwarConfigDirectory=$gHDAContentsDirectory/Plugins/AppleHDAHardwareConfigDriver.kext/Contents
gHDAControllerbinaryDirectory=$gHDAContentsDirectory/Plugins/AppleHDAController.kext/Contents/MacOS
gAudioid=1
gLayoutid=1
gPatch="-toledaALC"
gCodec=892
gLegacy=n
gController=n
gMake=0
gDebug=0
# gCodecsinstalled
# gCodecVendor
# gCodecDevice
# gCodecName
# gCodec
gCloverALC=1
gRealtekALC=0
gAudioidvalid=n
gCodecvalid=n

# debug
if [ $gDebug = 1 ]; then
echo "gMake = $gMake"
echo "gCloverALC = $gCloverALC"
echo "gRealtekALC = $gRealtekALC"

# while true
# do
# read -p "OK (y/n): " choice3
# case "$choice3" in
# 	[yY]* ) break;;
# 	[nN]* ) exit;;
# 	* ) echo "Try again...";;
# esac
# done
fi

#verify system version
case ${gSysVer} in
10.10* ) gSysName="Yosemite"
gSysFolder=/kexts/10.10
;;
10.9* ) gSysName="Mavericks"
gSysFolder=/kexts/10.9
;;
10.8* ) gSysName="Mountain Lion"
gSysFolder=/kexts/10.8
;;
* ) echo "OS X Version: $gSysVer is not supported"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;
esac

# debug
if [ $gDebug = 1 ]; then
# gSysVer=10.9
echo "System version: supported"
echo "gSysVer = $gSysVer"
fi

echo "File: $gFile"

if [ $gCloverALC = 1 ]; then
echo "Verify EFI partition mounted, Finder/Devices/EFI"
fi

if [ $gSysName = "Yosemite" ]; then
if [ $gRealtekALC = 1 ]; then
echo "Verify kext-dev-mode=1 boot flag/argument"
fi
fi

# get password
gHDAversioninstalled=$(sudo /usr/libexec/PlistBuddy -c "Print ':CFBundleShortVersionString'" $gHDAContentsDirectory/Info.plist)

# exit if error
if [ "$?" != "0" ]; then
echo "Error occurred, no S/L/E/AppleHDA.kext installed"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# credit: mfram, http://forums.macrumors.com/showpost.php?p=18302055&postcount=6
gStartupDevice=$(mount | grep "on / " | cut -f1 -d' ')
gStartupDisk=$(mount | grep "on / " | cut -f1 -d' ' | xargs diskutil info | grep "Volume Name" | perl -an -F'/:\s+/' -e 'print "$F[1]"')

# debug
if [ $gDebug = 1 ]; then
echo "Boot device: $gStartupDevice"
echo "Boot volume: $gStartupDisk"
fi

# set up clover (efi or legacy)
if [ $gCloverALC = 1 ]; then

# initialize variable
choice8=n

# check for debug (debug=1 does not touch CLOVER folder)
case $gDebug in
0 )
if [ -d $gCloverDirectory ]; then
echo "EFI partition is mounted"
    if [ -f "$gCloverDirectory/config.plist" ]; then
        sudo cp -p $gCloverDirectory/config.plist /tmp/config.plist
        if [ -f "$gCloverDirectory/config-backup.plist" ]; then
            rm -R $gCloverDirectory/config-backup.plist
        fi
        sudo cp -p $gCloverDirectory/config.plist $gCloverDirectory/config-backup.plist
    else
        echo "$gCloverDirectory/config.plist is missing"
        echo "No system files were changed"
        echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
    fi
else
echo "EFI partition is not mounted"

# confirm Clover Legacy install
while true
do
read -p "Confirm Clover Legacy Install (y/n): " choice8
case "$choice8" in

[yY]* )
gStartupDisk=${gStartupDisk}
gCloverDirectory=/Volumes/$gStartupDisk/EFI/CLOVER
if [ -d $gCloverDirectory ]; then
echo "$gStartupDisk/EFI folder found"
    if [ -f "$gCloverDirectory/config.plist" ]; then
        sudo cp -p $gCloverDirectory/config.plist /tmp/config.plist
        if [ -f "$gCloverDirectory/config-backup.plist" ]; then
            rm -R $gCloverDirectory/config-backup.plist
        fi
        sudo cp -p $gCloverDirectory/config.plist $gCloverDirectory/config-backup.plist
    else
        echo "$gCloverDirectory/config.plist is missing"
        echo "No system files were changed"
        echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
    fi
else
echo "$gCloverDirectory not found"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

break
;;

[nN]* )
echo "User terminated, no EFI partition/folder"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;

* ) echo "Try again...";;
esac
done
fi
;;

1 )
echo "gHDAversioninstalled = $gHDAversioninstalled"
echo "Desktop/config-basic.plist copied to /tmp/config.plist"
sudo cp -R config-basic.plist /tmp/config.plist
;;
* )
echo "gDebug = $gDebug, fix"
exit 1
;;
esac

fi

# exit if error
if [ "$?" != "0" ]; then
if [ $choice8 != “y” ]; then
echo "Error, $gStartupDisk/EFI not found"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi
echo "Error, EFI partition not mounted"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# debug
if [ $gDebug = 1 ]; then
echo "EFI: success"
fi

# verify ioreg/HDEF
ioreg -rw 0 -p IODeviceTree -n HDEF > /tmp/HDEF.txt

if [ $(cat /tmp/HDEF.txt | grep -o "HDEF@1B") == "HDEF@1B" ]; then
gLayoutidioreg=$(cat /tmp/HDEF.txt | grep layout-id | sed -e 's/.*<//' -e 's/>//')
gLayoutidhex="0x${gLayoutidioreg:6:2}${gLayoutidioreg:4:2}${gLayoutidioreg:2:2}${gLayoutidioreg:0:2}"
let gAudioid=$gLayoutidhex
sudo rm -R /tmp/HDEF.txt
else
echo "Error: no IOReg/HDEF; BIOS/audio/disabled or ACPI problem"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# debug
if [ $gDebug = 1 ]; then
echo "gLayoutidioreg = $gLayoutidioreg"
echo "gLayoutidihex = $gLayoutidhex"
echo "gAudioid = $gAudioid"
echo "HDEF/Audio ID: success"
fi

# verify native s/l/e/applehda.kext 
if [ $gMake = 0 ]; then

if [ $(perl -le "print scalar grep /\x8b\x19\xd4\x11/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]; then
echo "S/L/E/AppleHDA.kext is not native"
echo "Install native AppleHDA.kext"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

if [ $(perl -le "print scalar grep /\x84\x19\xd4\x11/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]; then
echo "S/L/E/AppleHDA.kext is not native"
echo "Install native AppleHDA.kext"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

if [ $(perl -le "print scalar grep /\xff\x87\xec\x1a/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]; then
echo "S/L/E/AppleHDA.kext is not native"
echo "Install native AppleHDA.kext"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

if [ $(perl -le "print scalar grep /\x62\x02\xec\x10/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]; then
echo "S/L/E/AppleHDA.kext is not native"
echo "Install native AppleHDA.kext"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi
fi

# debug
if [ $gDebug = 1 ]; then
echo "Native AppleHDA: success"
fi

# get installed codec/revision
gCodecsInstalled=$(ioreg -rxn IOHDACodecDevice | grep VendorID | awk '{ print $4 }' | sed -e 's/ffffffff//')
gCodecsVersion=$(ioreg -rxn IOHDACodecDevice | grep RevisionID| awk '{ print $4 }')

# debug
if [ $gDebug = 1 ]; then
gCodecsInstalled=0x10ec0887
gCodecsVersion=0x100101
# gCodecsVersion=0x100202
# gCodecsVersion=0x100302
# gCodecsInstalled=0x10ec0900
# gCodecsVersion=0x100001
# gCodecsInstalled=0x10134206
# gCodecsVersion=0x100302
echo "gCodecsInstalled = $gCodecsInstalled"
echo "gCodecsVersion = $gCodecsVersion"
fi

# no codecs detected
if [ -z "${gCodecsInstalled}" ]; then
echo ""
echo "No audio codec detected"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# initialize variables
intel=n
amd=n
nvidia=n
realtek=n
unknown=n
alternate=n

# find realtek codecs
index=0
version=($gCodecsVersion)
for codec in $gCodecsInstalled
do

# debug
if [ $gDebug = 1 ]; then
echo "Index = $index, Codec = $codec, Version = ${version[$index]}"
fi
case ${codec:2:4} in

8086 ) Codecintelhdmi=$codec; intel=y
;;
1002 ) Codecamdhdmi=$codec; amd=y
;;
10de ) Codecnvidiahdmi=$codec; nvidia=y
;;
10ec ) Codecrealtekaudio=$codec; Versionrealtekaudio=${version[$index]}; realtek=y
;;
*) Codecunknownaudio=$codec; unknown=y
;;
esac
index=$((index + 1))
done

# debug
if [ $gDebug = 1 ]; then
echo "HDMI audio codec(s)"
if [ $intel = y ]; then
echo "Intel:    $Codecintelhdmi"
fi
if [ $amd = y ]; then
echo "AMD:      $Codecamdhdmi"
fi
if [ $nvidia = y ]; then
echo "Nvidia:   $Codecnvidiahdmi"
fi
echo ""
echo "Onboard audio codec"
if [ $realtek = y ]; then
echo "Realtek:  $Codecrealtekaudio"
echo "Version:  $Versionrealtekaudio"
fi
if [ $unknown = y ]; then
echo "Unknown:  $Codecunknownaudio"
fi
fi

if [ $unknown = y ]; then

while true
do
read -p "Codec $Codecunknownaudio is not supported, continue (y/n): " choice7
case "$choice7" in
	[yY]* )  break;;
	[nN]* ) echo "No system files were changed"
		echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."	
		exit 1;;
	* ) echo "Try again..."
;;
esac
done
fi

if [ $realtek = y ]; then

gCodecVendor=${Codecrealtekaudio:2:4}
gCodecDevice=${Codecrealtekaudio:6:4}

# debug
if [ $gDebug = 1 ]; then
echo "gCodecVendor = $gCodecVendor"
echo "gCodecDevice = $gCodecDevice"
fi

if [ ${gCodecDevice:0:1} = 0 ]; then
gCodecName=${gCodecDevice:1:3}
fi

if [ $gCodecDevice = "0899" ]; then
gCodecName=898
fi

if [ $gCodecDevice = "0900" ]; then
gCodecName=1150
fi

# debug
if [ $gDebug = 1 ]; then
echo "Codec identification: success"
fi

#  validate_realtek codec
case "$gCodecName" in
269|283|885|887|888|889|892|898|1150 )

# confirm codec, go button
while true
do
read -p "Confirm Realtek ALC$gCodecName (y/n): " choice3
case "$choice3" in
[yY]* ) gCodec=$gCodecName; gCodecvalid=y; break;;
[nN]* ) break;;
* ) echo "Try again...";;
esac
done
;;

* ) echo "Realtek ALC$gCodecName is not supported with $gFile"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;
esac

# exit if error
if [ "$?" != "0" ]; then
echo Error: ??
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

fi

if [ $gCodecvalid != y ]; then

#  get supported codec
echo "Supported RealtekALC codecs: 885, 887, 888, 889, 892, 898 or 1150"
while true
do
read -p "Enter codec: " choice0
case "$choice0" in
	269|283|885|887|888|889|892|898|1150 ) gCodec=$choice0; break;;
	* ) echo "Try again...";;
esac
done
# Versionrealtekaudio=0x100302

fi

# legacy

case "$gCodec" in

887|888 )
if [ $gMake = 0 ]; then

case "$Versionrealtekaudio" in

0x100302 ) echo "ALC$gCodec v_$Versionrealtekaudio (Current)"; gLegacy=n ;;

0x100202 ) echo "ALC$gCodec v_$Versionrealtekaudio (Legacy)"; gLegacy=y ;;

* ) echo "ALC$gCodec v_$Versionrealtekaudio not supported"
while true
do
read -p "Use Legacy (v100202) Patch (y/n): " choice1
case "$choice1" in
 	[yY]* ) gLegacy=y; break;;
	[nN]* ) echo "No system files were changed"
		echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
		exit;;
	* ) echo "Try again...";;
esac
done
esac

else
while true
do
read -p "887/888 Legacy (v100202) Patch (y/n): " choice1
case "$choice1" in
 	[yY]* ) gLegacy=y; break;;
	[nN]* ) gLegacy=n; break;;
	* ) echo "Try again...";;
esac
done

fi

esac

# HD4600 HDMI audio patch
if [ $gRealtekALC = 1 ]; then
if [ $gCodec = 887 -a $gLegacy = y ]; then gController=n; else
case "$gCodec" in

887|892|898|1150 )
while true
do
read -p "Enable HD4600 HDMI audio (y/n): " choice2
case "$choice2" in
	[yY]* ) gController=y; break;;
	[nN]* ) gController=n; break;;
	* ) echo "Try again...";;
esac
done
esac
fi
fi

# validate audio id
case $gAudioid in
# 0|1|2|3 ) gAudioidvalid=y;;
1|2|3 ) gAudioidvalid=y;;
* )  
while true
do
read -p "Audio ID: $gAudioid is not supported, continue (y/n): " choice9
case "$choice9" in
	[yY]* ) gAudioid=0; gAudioidvalid=n break;;
	[nN]* ) echo "No system files were changed"; exit;;
	* ) echo "Try again..."
;;
esac
done
;;
esac

if [ $gRealtekALC = 1 ]; then
if [ $gAudioidvalid = n ]; then
echo ""
echo "Note"
echo "Set Audio ID injection before restart; valid IDs are:"
# echo "0 - dsdt/ssdt HDMI audio (AMD/Nvidia/Intel)"
echo "1 - 3/5/6 port Realtek ALCxxx audio"
echo "2 - 3 port (5.1) Realtek ALCxxx audio (n/a 885)"
echo "3 - HD3000/HD4000 HDMI and Realtek ALCxxx audio (n/a 885/1150 & 887/888 Legacy)"
echo "Caution: if Audio ID: $gAudioid is not fixed, no audio after restart"
fi
fi

if [ $gCloverALC = 1 ]; then
while true
do
read -p "Clover Audio ID Injection (y/n): " choice4
case "$choice4" in
	[yY]* ) choice4=y; break;;
	[nN]* ) gAudioid=1; choice5=y; break;;
	* ) echo "Try again...";;
esac
done

if [ $choice4 = y ]; then
while true
do
read -p "Use Audio ID: $gAudioid (y/n): " choice5
case "$choice5" in
	[yY]* ) break;;
	[nN]* ) choice5=n; break;;
	* ) echo "Try again...";;
esac
done
fi

if [ $choice5 = n ]; then
echo "Audio IDs:"
# echo "0 - dsdt/ssdt HDMI audio (AMD/Nvidia/Intel)"
echo "1 - 3/5/6 port Realtek ALCxxx audio"
echo "2 - 3 port (5.1) Realtek ALCxxx audio (n/a 885)"
echo "3 - HD3000/HD4000 HDMI and Realtek ALCxxx audio (n/a 885/1150 & 887/888 Legacy)"
while true
do
# read -p "Select Audio ID? (0, 1, 2 or 3): " choice6
read -p "Select Audio ID: " choice6
case "$choice6" in
#	0* ) gAudioid=0; break;;
	1* ) gAudioid=1; break;;
	2* ) gAudioid=2; if [ $gCodec = 885 ]; then echo "ID: 2 n/a, try again..."; else break; fi;;
	3* ) gAudioid=3; valid=y;
		if [ $gCodec = 885 ]; then valid=n; fi;
		if [ $gCodec = 1150 ]; then valid=n; fi;
		if [ $gLegacy = y ]; then valid=n; fi;
		if [ $valid = n ]; then echo "ID: 3 n/a, try again..."; else break; fi;;
	* ) echo "Try again...";;
esac
done
fi
fi

# debug
if [ $gDebug = 1 ]; then
echo "gCodec = $gCodec"
echo "gAudioid = $gAudioid"
echo "gLegacy = $gLegacy"
echo "gController = $gController"
echo "Codec configuration: success"
fi
echo ""
echo "Download ALC$gCodec files ..."
gDownloadLink="https://raw.githubusercontent.com/toleda/audio_ALC$gCodec/master/$gCodec.zip"
if [ $gLegacy = y ]; then
Legacy=_v100202
gDownloadLinkLegacy="https://raw.githubusercontent.com/toleda/audio_ALC$gCodec/master/$gCodec$Legacy.zip"
sudo curl -o "/tmp/ALC$gCodec.zip" $gDownloadLinkLegacy
else
sudo curl -o "/tmp/ALC$gCodec.zip" $gDownloadLink
fi
unzip -qu "/tmp/ALC$gCodec.zip" -d "/tmp/"

# exit if error
if [ "$?" != "0" ]; then
echo "Error: Download failure, verify network"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# debug
if [ $gDebug = 1 ]; then
echo "gCloverALC = $gCloverALC"
echo "gRealtekALC = $gRealtekALC"
fi

######################

if [ $gCloverALC = 1 ]; then    # main loop

######################

# if no clover audio id injection, exit
configaudio=$(sudo /usr/libexec/PlistBuddy -c "Print ':Devices'" /tmp/config.plist | grep -c "Audio")
if [ $gAudioid != 0 ]; then
# set Devices/Audio/Inject/gLayout-id
echo "Edit config.plist/Devices/Audio/Inject/$gAudioid"
if [ $configaudio = 0 ]; then
sudo /usr/libexec/PlistBuddy -c "Add :Devices:Audio dict" /tmp/config.plist
sudo /usr/libexec/PlistBuddy -c "Add :Devices:Audio:Inject string '$gAudioid'" /tmp/config.plist
else
sudo /usr/libexec/PlistBuddy -c "Set :Devices:Audio:Inject $gAudioid" /tmp/config.plist
fi
fi

# debug
if [ $gDebug = 1 ]; then
echo "gAudioid = $gAudioid"
echo "configaudio = $configaudio"
fi

echo "Edit config.plist/SystemParameters/InjectKexts/YES"

injectkexts=$(sudo /usr/libexec/PlistBuddy -c "Print ':SystemParameters:InjectKexts:'" /tmp/config.plist)

# debug
if [ $gDebug = 1 ]; then
echo "SystemParameters:InjectKexts: = $injectkexts"
fi

if [ -z "${injectkexts}" ]; then
sudo /usr/libexec/PlistBuddy -c "Add :SystemParameters:InjectKexts string" /tmp/config.plist
echo "Edit config.plist: Add SystemParameters/InjectKexts - Fixed"
fi

if [ $(sudo /usr/libexec/PlistBuddy -c "Print ':SystemParameters:InjectKexts'" /tmp/config.plist | grep -c "YES") = 0 ]; then
sudo /usr/libexec/PlistBuddy -c "Set :SystemParameters:InjectKexts YES" /tmp/config.plist
fi

# debug 
if [ $gDebug = 1 ]; then
echo "After edit. :SystemParameters:InjectKexts; = $(sudo /usr/libexec/PlistBuddy -c "Print ':SystemParameters:InjectKexts:'" /tmp/config.plist)"
fi

# exit if error
if [ "$?" != "0" ]; then
echo Error: config.plst edit failed
echo “Original config.plist restored”
sudo cp -R $gCloverDirectory/config-backup.plist $gCloverDirectory/config.plist
sudo rm -R /tmp/ktp.plist
sudo rm -R /tmp/config.plist
sudo rm -R /tmp/config-audio_cloverALC.plist
sudo rm -R /tmp/$gCodec.zip
sudo rm -R /tmp/$gCodec
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

case $gSysName in

"Yosemite" )

echo "Edit config.plist/Boot/Arguments/kext-dev-mode=1"

bootarguments=$(sudo /usr/libexec/PlistBuddy -c "Print ':Boot:Arguments:'" /tmp/config.plist)

# debug
if [ $gDebug = 1 ]; then
echo "Boot:Arguments: = $bootarguments"
fi

if [ -z "${bootarguments}" ]; then
sudo /usr/libexec/PlistBuddy -c "Add :Boot:Arguments string" /tmp/config.plist
echo "Edit config.plist: Add Boot/Argument - Fixed"
fi

if [[ $bootarguments != *kext-dev-mode=1* ]]; then
newbootarguments="$bootarguments kext-dev-mode=1"
sudo /usr/libexec/PlistBuddy -c "Set :Boot:Arguments $newbootarguments" /tmp/config.plist
fi

# debug
if [ $gDebug = 1 ]; then
echo "After edit. Boot:Arguments: = $(sudo /usr/libexec/PlistBuddy -c "Print ':Boot:Arguments:'" /tmp/config.plist)"
fi

;;
esac

# exit if error
if [ "$?" != "0" ]; then
echo Error: config.plst edit failed
echo “Original config.plist restored”
sudo cp -R $gCloverDirectory/config-backup.plist $gCloverDirectory/config.plist
sudo rm -R /tmp/ktp.plist
sudo rm -R /tmp/config.plist
sudo rm -R /tmp/config-audio_cloverALC.plist
sudo rm -R /tmp/$gCodec.zip
sudo rm -R /tmp/$gCodec
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

echo "Download kext patches"

gDownloadLink="https://raw.githubusercontent.com/toleda/audio_cloverALC/master/config-audio_cloverALC.plist.zip"
sudo curl -o "/tmp/config-audio_cloverALC.plist.zip" $gDownloadLink
unzip -qu "/tmp/config-audio_cloverALC.plist.zip" -d "/tmp/"

# add KernelAndKextPatches/KextsToPatch codec patches
# remove existing audio patches


ktpexisting=$(sudo /usr/libexec/plistbuddy -c "Print ':KernelAndKextPatches:KextsToPatch:'" /tmp/config.plist)

if [ -z "${ktpexisting}" ]; then
sudo /usr/libexec/PlistBuddy -c "Add KernelAndKextPatches:KextsToPatch array" /tmp/config.plist
echo "Edit config.plist: Add KernelAndKextPatches/KextsToPatch - Fixed"
fi

ktpexisting=$(sudo /usr/libexec/plistbuddy -c "Print ':KernelAndKextPatches:KextsToPatch:'" /tmp/config.plist | grep -c "t1-")

index=0
while [ $ktpexisting -ge 1 ]; do
if [ $(sudo /usr/libexec/plistbuddy -c "Print ':KernelAndKextPatches:KextsToPatch:$index dict'" /tmp/config.plist | grep -c "t1-") = 1 ]; then
sudo /usr/libexec/plistbuddy -c "Delete ':KernelAndKextPatches:KextsToPatch:$index dict'" /tmp/config.plist
ktpexisting=$((ktpexisting - 1))
index=$((index - 1))
fi
index=$((index + 1))
# debug
if [ $gDebug = 1 ]; then
echo "index = $index"
echo "ktpexisting = $ktpexisting"
fi
done
# set patch for codec

case $gCodec in
885 ) patch1=1;;
887 ) patch1=2;;
888 ) patch1=3;;
889 ) patch1=4;;
892 ) patch1=5;;
898 ) patch1=6;;
1150 ) patch1=7;;
269 ) patch1=8;;
283) patch1=9;;
esac

patch=( 0 $patch1 )
index=0

while [ $index -lt 2 ]; do

sudo /usr/libexec/PlistBuddy -c "Print ':KernelAndKextPatches:KextsToPatch:${patch[$index]}'" /tmp/config-audio_cloverALC.plist -x > "/tmp/ktp.plist"

ktpcomment=$(sudo /usr/libexec/PlistBuddy -c "Print 'Comment'" "/tmp/ktp.plist")

sudo /usr/libexec/PlistBuddy -c "Set :Comment 't1-$ktpcomment'" "/tmp/ktp.plist"

sudo /usr/libexec/PlistBuddy -c "Add :KernelAndKextPatches:KextsToPatch:0 dict" /tmp/config.plist

sudo /usr/libexec/PlistBuddy -c "Merge /tmp/ktp.plist ':KernelAndKextPatches:KextsToPatch:0'" /tmp/config.plist

index=$((index + 1))
done
# exit if error
if [ "$?" != "0" ]; then
echo Error: config.plst edit failed
echo “Original config.plist restored”
sudo cp -R $gCloverDirectory/config-backup.plist $gCloverDirectory/config.plist
sudo rm -R /tmp/ktp.plist
sudo rm -R /tmp/config.plist
sudo rm -R /tmp/config-audio_cloverALC.plist
sudo rm -R /tmp/$gCodec.zip
sudo rm -R /tmp/$gCodec
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# install updated config.plst
# debug
if [ $gDebug = 0 ]; then
sudo cp -R /tmp/config.plist $gCloverDirectory/config.plist
else
echo "Debug mode"
sudo cp -R /tmp/config.plist gDesktopDirectory
echo "/tmp/config.plist copied to Desktop"
fi

# cleanup /tmp
sudo rm -R /tmp/ktp.plist
sudo rm -R /tmp/config.plist
sudo rm -R /tmp/config-audio_cloverALC.plist
sudo rm -R /tmp/config-audio_cloverALC.plist.zip

# echo "config.plist patching finished."

echo "Install $gCloverDirectory/$gSysFolder/realtekALC.kext"

echo "Download config kext and install ..."
gDownloadLink="https://raw.githubusercontent.com/toleda/audio_cloverALC/master/realtekALC.kext.zip"
sudo curl -o "/tmp/realtekALC.kext.zip" $gDownloadLink
unzip -qu "/tmp/realtekALC.kext.zip" -d "/tmp/"
# debug
if [ $gDebug = 0 ]; then
if [ -d "$gCloverDirectory/$gSysFolder/realtekALC.kext" ]; then
sudo rm -R $gCloverDirectory/$gSysFolder/realtekALC.kext
# echo "$gCloverDirectory/$gSysFolder/realtekALC.kext deleted"
fi
sudo cp -R /tmp/realtekALC.kext $gCloverDirectory/$gSysFolder/
else
echo "Debug mode"
echo "No system files were changed"
fi
sudo rm -R /tmp/realtekALC.kext.zip
sudo rm -R /tmp/realtekALC.kext
sudo rm -R /tmp/__MACOSX

# exit if error
if [ "$?" != "0" ]; then
echo Error: Download failure
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# debug
if [ $gDebug = 0 ]; then
if [ -d "$gHDAContentsDirectory/Resources/*.zml.zlib" ]; then
sudo rm -R $gHDAContentsDirectory/Resources/*.zml.zlib
# echo "System/Library/Extensions/AppleHDA.kext/ALC$gCodec zml files deleted"
fi

echo "Install System/Library/Extensions/AppleHDA.kext/ALC$gCodec zml files"

sudo install -m 644 -o root -g wheel /tmp/$gCodec/Platforms.xml.zlib  $gHDAContentsDirectory/Resources/Platforms.zml.zlib

sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout1.xml.zlib  $gHDAContentsDirectory/Resources/layout1.zml.zlib 

case $gCodec in

887|888|889|892|898 )
sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout2.xml.zlib  $gHDAContentsDirectory/Resources/layout2.zml.zlib

sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout3.xml.zlib  $gHDAContentsDirectory/Resources/layout3.zml.zlib
;;
1150 )
sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout2.xml.zlib  $gHDAContentsDirectory/Resources/layout2.zml.zlib
;;
esac
fi

# exit if error
if [ "$?" != "0" ]; then
echo "Error: Installation failure"
sudo rm -R $gHDAContentsDirectory/Resources/*zml.zlib
sudo touch $gExtensionsDirectory
echo "Original S/L/E/AppleHDA.kext restored"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

fi    # end: if [ $gCloverALC = 1 ]

sudo rm -R /tmp/ALC$gCodec.zip
sudo rm -R /tmp/$gCodec

case $gSysName in

"Yosemite" )
echo "Fix permissions ..."
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
echo "Kernel cache..."
sudo touch $gExtensionsDirectory
sudo kextcache -Boot -U /
;;

"Mavericks"|"Mountain Lion" )
echo "Fix permissions ..."
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
echo "Kernel cache..."
sudo touch $gExtensionsDirectory
echo "Allow a few minutes for kernel cache rebuild."
;;
esac

# exit if error
# if [ "$?" != "0" ]; then
# echo Error: Maintenance failure
# echo "Verify Permissions"
# echo "Rebuild Kernel Cache"
# echo "Verify S/L/E/AppleHDA.kext"
# echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
# exit 1
# fi

echo ""
echo "Install finished, restart required."
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit