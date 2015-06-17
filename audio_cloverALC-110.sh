#!/bin/sh
# Maintained by: toleda for: github.com/toleda/audio_realtekALC
gFile="File: audio_realtekALC-110.command_v1.0b"
# Credit: bcc9, RevoGirl, PikeRAlpha, SJ_UnderWater, RehabMan, TimeWalker, lisai9093
#
# OS X Realtek ALC Onboard Audio
#
# Enables OS X Realtek ALC onboard audio in 10.11, 10.10, 10.9 and 10.8, all versions
# 1. Supports Realtek ALC885, 887, 888, 889, 892, 898 and 1150
# 2. Patches native AppleHDA.kext installed in System/Library/Extensions
#
# Requirements
# 1. OS X: 10.11/10.10/10.9/10.8, all versions
# 2. Native AppleHDA.kext  (If not installed, run Mavericks installer)
# 3. Supported Realtek ALC on board audio codec (see above)
# 4. Audio ID: 1, 2 or 3 Injection, see https://github.com/toleda/audio_ALCinjection
#
# Installation
# 1. Double click audio_cloverALC-110.command
# 2. Enter password at prompt
# 3. Confirm Realtek ALC . . . (y/n): (885, 887, 888, 889, 892, 898, 1150 only)
# 4. Enable HD4600 HDMI audio (y/n): (887, 892, 898, 1150 only)
# 5. Restart
#
# Change log:
# v1.0a - 6/15/15: 1. Initial 10.11 support
#
echo " "
echo "Agreement"
echo "The audio_realtekALC-110 script is for personal use only. Do not distribute" 
echo "the patch, any or all of the files or the resulting patched AppleHDA.kext" 
echo "for any reason without permission. The audio_realtekALC-110 script is" 
echo "provided as is and without any kind of warranty."
echo " "

# set initial variables
gSysVer=`sw_vers -productVersion`
gSysName="Mavericks"
gStartupDisk=EFI
gCloverDirectory=/Volumes/$gStartupDisk/EFI/CLOVER
gDesktopDirectory=/Users/$(whoami)/Desktop
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
gCloverALC=0
gRealtekALC=1
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

# verify system version
case ${gSysVer} in

10.11* ) gSysName="El Capitan"
gSysFolder=/kexts/10.11
;;
10.10* ) gSysName="Yosemite"
gSysFolder=/kexts/10.10
;;
10.9* ) gSysName="Mavericks"
gSysFolder=/kexts/10.9
;;
10.8* ) gSysName="Mountain Lion"
gSysFolder=/kexts/10.8
;;

* )
echo "OS X Version: $gSysVer is not supported"
echo "No system files were changed"
echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
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

# debug
if [ $gMake = 1 ]; then
    if [ -d "$gDesktopDirectory/AppleHDA.kext" ]; then
        sudo rm -R $gExtensionsDirectory/AppleHDA.kext
    else
        echo "Error, no Desktop/AppleHDA.kext (native)"
        echo "No system files were changed"
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
    exit 1
    fi

    sudo cp -R $gDesktopDirectory/AppleHDA.kext $gExtensionsDirectory/AppleHDA.kext
    sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
    sudo touch $gExtensionsDirectory
    gHDAversioninstalled=$(sudo /usr/libexec/PlistBuddy -c "Print ':CFBundleShortVersionString'" $gHDAContentsDirectory/Info.plist)
    echo "Desktop/AppleHDA.kext installed in $gExtensionsDirectory"
fi

# credit: mfram, http://forums.macrumors.com/showpost.php?p=18302055&postcount=6
# get startup disk name
gStartupDevice=$(mount | grep "on / " | cut -f1 -d' ')
gStartupDisk=$(mount | grep "on / " | cut -f1 -d' ' | xargs diskutil info | grep "Volume Name" | perl -an -F'/:\s+/' -e 'print "$F[1]"')

# debug
if [ $gDebug = 1 ]; then
    echo "Boot device: $gStartupDevice"
    echo "Boot volume: $gStartupDisk"
fi

# if [ $gCloverALC = 1 ]; then
#     echo "Verify EFI partition mounted, Finder/Devices/EFI"
#     echo "If not set, Terminal/Quit"
# fi

if [ $gRealtekALC = 1 ]; then
    gChameleonDirectory=/Volumes/"$gStartupDisk"/Extra

# debug
    if [ $gDebug = 1 ]; then
        echo "gChameleonDirectory = $gChameleonDirectory"
        echo "gSysName = $gSysName"
    fi

    if [ -d $gChameleonDirectory ]; then
        if [ -f "$gChameleonDirectory/org.chameleon.Boot.plist" ]; then
            cp -p $gChameleonDirectory/org.chameleon.Boot.plist /tmp/org.chameleon.Boot.txt

# debug
            if [ $gDebug = 1 ]; then
                echo "$gChameleonDirectory/org.chameleon.Boot.plist found"
            fi

        else
            echo "$$gChameleonDirectory/org.chameleon.Boot.plist not found"
            echo "No system files were changed"
            echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
            exit 1
        fi

        case $gSysName in

        "El Capitan" )
        if [[ $(cat /tmp/org.chameleon.Boot.txt | grep -o "rootless=0") = "rootless=0" ]]; then
            echo "Kernel Flags = rootless=0 found"
        else
            rm -R /tmp/org.chameleon.Boot.txt
            echo "Kernel Flags = rootless=0 not found; patching not possible"
            echo "Add org.chameleon.Boot.plist/Kernel Flags = rootless=0 and restart"
            echo "No system files were changed"
            echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
            exit 1
        fi
        ;;

        "Yosemite" )
        if [[ $(cat /tmp/org.chameleon.Boot.txt | grep -o "kext-dev-mode=1") = "kext-dev-mode=1" ]]; then
            echo "Kernel Flags = kext-dev-mode=1 found"
        else
            rm -R /tmp/org.chameleon.Boot.txt
            echo "Kernel Flags = kext-dev-mode=1 not found; patching not possible"
            echo "Add org.chameleon.Boot.plist/Kernel Flags = kext-dev-mode=1 and restart"
            echo "No system files were changed"
            echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
        fi
        ;;

        esac
    fi
rm -R /tmp/org.chameleon.Boot.txt
fi

# get password
gHDAversioninstalled=$(sudo /usr/libexec/PlistBuddy -c "Print ':CFBundleShortVersionString'" $gHDAContentsDirectory/Info.plist)

# exit if error
if [ "$?" != "0" ]; then
    echo "Error occurred, AppleHDA.kext/Contents/Info.plist/BundleShortVersionString not found"
    echo "No system files were changed"
    echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
    exit 1
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
        cp -p $gCloverDirectory/config.plist /tmp/config.txt

        case $gSysName in

        "El Capitan" )
        if [[ $(cat /tmp/config.txt | grep -o "rootless=0") = "rootless=0" ]]; then
            echo "Boot/Arguments/rootless=0 found"
        else
            rm -R /tmp/config.txt
            echo "Boot/Arguments/rootless=0 not found; patching not possible"
            echo "Add config.plist/Boot/Arguments/rootless=0 and restart"
            echo "No system files were changed"
            echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
            exit 1
        fi
        ;;

        "Yosemite" )
        if [[ $(cat /tmp/config.txt | grep -o "kext-dev-mode=1") = "kext-dev-mode=1" ]]; then
            echo "Boot/Arguments = kext-dev-mode=1 found"
        else
            rm -R /tmp/config.txt
            echo "Boot/Arguments/kext-dev-mode=1 not found; patching not possible"
            echo "Add config.plist/Boot/Arguments/kext-dev-mode=1 and restart"
            echo "No system files were changed"
            echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
        fi
        ;;

        esac

        rm -R /tmp/config.txt
        cp -p $gCloverDirectory/config.plist /tmp/config.plist
        if [ -f "$gCloverDirectory/config-backup.plist" ]; then
            rm -R $gCloverDirectory/config-backup.plist
        fi
        cp -p $gCloverDirectory/config.plist $gCloverDirectory/config-backup.plist
    else
        echo "$gCloverDirectory/config.plist is missing"
        echo "No system files were changed"
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
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
    gCloverDirectory=/Volumes/"$gStartupDisk"/EFI/CLOVER
    if [ -d $gCloverDirectory ]; then
    echo "$gStartupDisk/EFI folder found"
        if [ -f "$gCloverDirectory/config.plist" ]; then

            cp -p $gCloverDirectory/config.plist /tmp/config.txt

            case $gSysName in

            "El Capitan" )
            if [[ $(cat /tmp/config.txt | grep -o "rootless=0") = "rootless=0" ]]; then
                echo "Boot/Arguments/rootless=0 found"
            else
                rm -R /tmp/config.txt
                echo "Boot/Arguments/rootless=0 not found; patching not possible"
                echo "Add config.plist/Boot/Arguments/rootless=0 and restart"
                echo "No system files were changed"
                echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
                exit 1
            fi
            ;;

            "Yosemite" )
            if [[ $(cat /tmp/config.txt | grep -o "kext-dev-mode=1") = "kext-dev-mode=1" ]]; then
                echo "Boot/Arguments = kext-dev-mode=1 found"
            else
                rm -R /tmp/config.txt
                echo "Boot/Arguments/kext-dev-mode=1 not found; patching not possible"
                echo "Add config.plist/Boot/Arguments/kext-dev-mode=1 and restart"
                echo "No system files were changed"
                echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
            exit 1
            fi
            ;;

            esac

            rm -R /tmp/config.txt
            sudo cp -p $gCloverDirectory/config.plist /tmp/config.plist
            if [ -f "$gCloverDirectory/config-backup.plist" ]; then
                rm -R $gCloverDirectory/config-backup.plist
            fi
            sudo cp -p $gCloverDirectory/config.plist $gCloverDirectory/config-backup.plist
        else
            echo "$gCloverDirectory/config.plist is missing"
            echo "No system files were changed"
            echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
        fi

    else
    echo "$gCloverDirectory not found"
    echo "No system files were changed"
    echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
    exit 1
    fi

    break
    ;;

    [nN]* )
    echo "User terminated, EFI partition/folder not mounted"
    echo “Mount EFI partition and Restart“
    echo "No system files were changed"
    echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
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
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
    fi
    echo "Error, EFI partition not mounted"
    echo "No system files were changed"
    echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
    exit 1
fi

# debug
if [ $gDebug = 1 ]; then
    echo "EFI: success"
fi

# verify ioreg/HDEF
ioreg -rw 0 -p IODeviceTree -n HDEF > /tmp/HDEF.txt

if [[ $(cat /tmp/HDEF.txt | grep -o "HDEF@1B") = "HDEF@1B" ]]; then
    gLayoutidioreg=$(cat /tmp/HDEF.txt | grep layout-id | sed -e 's/.*<//' -e 's/>//')
    gLayoutidhex="0x${gLayoutidioreg:6:2}${gLayoutidioreg:4:2}${gLayoutidioreg:2:2}${gLayoutidioreg:0:2}"
    let gAudioid=$gLayoutidhex
    sudo rm -R /tmp/HDEF.txt
else
    echo "Error: no IOReg/HDEF; BIOS/audio/disabled or ACPI problem"
    echo "No system files were changed"
    echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
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

    if [[ $(perl -le "print scalar grep /\x8b\x19\xd4\x11/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]]; then
        echo "codec: 8b19d411 is missing"
        echo "S/L/E/AppleHDA.kext is not native"
        echo "Install native AppleHDA.kext"
        echo "No system files were changed"
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
    fi

    if [[ $(perl -le "print scalar grep /\x84\x19\xd4\x11/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]]; then
        echo "codec: 8419d411 is missing"
        echo "S/L/E/AppleHDA.kext is not native"
        echo "Install native AppleHDA.kext"
        echo "No system files were changed"
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
    fi

    if [[ $(perl -le "print scalar grep /\x62\x02\xec\x10/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]]; then
        echo "codec: 6202ec10 is missing"
        echo "S/L/E/AppleHDA.kext is not native"
        echo "Install native AppleHDA.kext"
        echo "No system files were changed"
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
    fi

    case $gSysName in

    "Mountain Lion" )
    if [[ $(perl -le "print scalar grep /\xff\x87\xec\x1a/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]]; then
        echo "codec: ff87ec10 is missing"
        echo "S/L/E/AppleHDA.kext is not native"
        echo "Install native AppleHDA.kext"
        echo "No system files were changed"
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
    fi
    ;;

    esac

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
    echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
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

# sort vendors and devices
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
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1;;
    * ) echo "Try again..."
;;
esac

done

fi

# special names
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
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
    ;;
    esac

# exit if error
    if [ "$?" != "0" ]; then
        echo Error: ??
        echo "No system files were changed"
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
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
            echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
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
    echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
    exit 1
fi

# debug
if [ $gDebug = 1 ]; then
    echo "gCloverALC = $gCloverALC"
    echo "gRealtekALC = $gRealtekALC"
fi

# debug
if [ $gMake = 1 ]; then
    if [ -d "$gDesktopDirectory/AppleHDA.kext" ]; then
        sudo rm -R $gExtensionsDirectory/AppleHDA.kext
    else
        echo "Error, no Desktop/AppleHDA.kext (native)"
        echo "No system files were changed"
        echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
        exit 1
    fi
    sudo cp -R $gDesktopDirectory/AppleHDA.kext $gExtensionsDirectory/AppleHDA.kext
    sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
    sudo touch $gExtensionsDirectory
    gHDAversioninstalled=$(sudo /usr/libexec/PlistBuddy -c "Print ':CFBundleShortVersionString'" $gHDAContentsDirectory/Info.plist)
    echo "Desktop/AppleHDA.kext installed in $gExtensionsDirectory"
fi

######################

if [ $gRealtekALC = 1 ]; then    # main loop

######################

echo " "
echo "Preparing $gSysVer ALC$gCodec AppleHDA.kext_v$gHDAversioninstalled"

# manage backup folders
if [ -d "$gDesktopDirectory/audio_ALC$gCodec-$gSysVer-archive" ]; then
    sudo rm -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer-archive
    echo "$gDesktopDirectory/audio_ALC$gCodec-$gSysVer-archive deleted, too late"
fi
if [ -d "$gDesktopDirectory/audio_ALC$gCodec-$gSysVer" ]; then
    sudo mv -f $gDesktopDirectory/audio_ALC$gCodec-$gSysVer $gDesktopDirectory/audio_ALC$gCodec-$gSysVer-archive
    echo "$gDesktopDirectory/audio_ALC$gCodec-$gSysVer-archive created, max 1 archive"
fi
sudo mkdir -p $gDesktopDirectory/audio_ALC$gCodec-$gSysVer
sudo chown $(whoami) $gDesktopDirectory/audio_ALC$gCodec-$gSysVer
sudo cp -R $gExtensionsDirectory/AppleHDA.kext $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext

# exit if error
if [ "$?" != "0" ]; then
    echo "Error: Backup failed"
    echo "No system files were changed"
    echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
    exit 1
fi

echo "Patch binaries ..."

if [ $gController = y ]; then

    case $gSysVer in

    10.10*|10.11* )
    echo "$gSysVer controller patch"
# HD4600/0c0c HDMI audio patch (10.10)
    sudo xxd -ps $gHDAControllerbinaryDirectory/AppleHDAController | tr -d '\n' > /tmp/AppleHDAController.txt
    sudo /usr/bin/perl -pi -e 's|3d0c0a0000|3d0c0c0000|g' /tmp/AppleHDAController.txt
    sudo /usr/bin/perl -pi -e 's|3d0b0c0000|3d0c0c0000|g' /tmp/AppleHDAController.txt
    sudo xxd -r -p /tmp/AppleHDAController.txt $gHDAControllerbinaryDirectory/AppleHDAController
    sudo rm -R /tmp/AppleHDAController.txt
    ;;

    10.9* )
    echo "$gSysVer controller patch"
# HD4600/0c0c HDMI audio patch (10.9)
    sudo xxd -ps $gHDAControllerbinaryDirectory/AppleHDAController | tr -d '\n' > /tmp/AppleHDAController.txt
    sudo /usr/bin/perl -pi -e 's|0b0c0000|0c0c0000|g' /tmp/AppleHDAController.txt
    sudo /usr/bin/perl -pi -e 's|0c0a0000|0c0c0000|g' /tmp/AppleHDAController.txt
    sudo xxd -r -p /tmp/AppleHDAController.txt $gHDAControllerbinaryDirectory/AppleHDAController
    sudo rm -R /tmp/AppleHDAController.txt
    ;;

    * ) echo "OS X Version: $gSysVer does not support HD46000 HDMI audio"
    echo "No system files were changed"
    echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
    exit 1
    ;;
    esac

fi

# exit if error
if [ "$?" != "0" ]; then
    echo "Error: $gCodec  controller patch failure"
    sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
    sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
    sudo touch $gExtensionsDirectory
    echo "Original S/L/E/AppleHDA.kext restored"
    echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
    exit 1
fi

# codec binary patch
case $gSysVer in

10.8.5|10.9*|10.10*|10.11* )
echo "$gSysVer codec patch"

# patch out codec, el capitan only/credit lisai9093
case $gSysName in

"El Capitan" ) sudo perl -pi -e 's|\x83\x19\xd4\x11|\x00\x00\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

esac

# patch codec
case $gCodec in
269 ) sudo perl -pi -e 's|\x62\x02\xec\x10|\x69\x02\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

283 ) sudo perl -pi -e 's|\x62\x02\xec\x10|\x83\x02\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

885 ) echo “No patch, native ALC885”  
# Optional patch, remove "# " from the following two lines
# sudo perl -pi -e 's|\x85\x08\xec\x10|\x80\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
# sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x85\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

887 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x87\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

888 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x88\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

889 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x89\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

892 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x92\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

898 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x99\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

1150 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x00\x09\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

* )
echo "$gCodec not supported with this script"
echo "No system files were changed"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;
esac

;;

10.8|10.8.*[1-4] )
echo "$gSysVer codec patch"

# patch codec
case $gCodec in

885 ) echo “No patch, native ALC885, optional patch available, see script”  
# Optional patch, remove "# " from the following 3 lines
# sudo perl -pi -e 's|\x85\x08\xec\x10|\x80\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
# sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x99\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
# sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x99\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA
;;

887 ) sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x87\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x87\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA-pi -e 's|\x8b\x19\xd4\x11|\x87\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

888 ) sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x88\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x88\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA
;;

889 ) sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x89\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x89\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA
;;

892 ) sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x92\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x99\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA
;;

898 ) sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x92\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x99\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA
;;

1150 ) echo "ALC1150 supported in OS X 10.8.5 and newer"
sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
sudo touch $gExtensionsDirectory
echo "Original S/L/E/AppleHDA.kext restored"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;

* )
echo "$gCodec not supported with this script"
sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
sudo touch $gExtensionsDirectory
echo "Original S/L/E/AppleHDA.kext restored"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;
esac

;;

* )
echo "$gSysVer not supported with this script"
sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
sudo touch $gExtensionsDirectory
echo "Original S/L/E/AppleHDA.kext restored"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;

esac

# exit if error
if [ "$?" != "0" ]; then
    echo "Error: $gCodec codec patch failure"
    sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
    sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
    sudo touch $gExtensionsDirectory
    echo "Original S/L/E/AppleHDA.kext restored"
    echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
    exit 1
fi

echo "Install files ..."
gPatchversion=$gHDAversioninstalled$gPatch$gCodec
sudo /usr/libexec/PlistBuddy -c "Set ':CFBundleShortVersionString' $gPatchversion" $gHDAContentsDirectory/Info.plist
sudo /usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource:HDAConfigDefault'" $gHDAHardwarConfigDirectory/Info.plist
sudo /usr/libexec/PlistBuddy -c "Merge /tmp/$gCodec/hdacd.plist ':IOKitPersonalities:HDA Hardware Config Resource'" $gHDAHardwarConfigDirectory/Info.plist

sudo rm -R $gHDAContentsDirectory/Resources/*.zlib

sudo install -m 644 -o root -g wheel /tmp/$gCodec/Platforms.xml.zlib  $gHDAContentsDirectory/Resources

sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout1.xml.zlib  $gHDAContentsDirectory/Resources

case $gCodec in

887|888|889|892|898 )
sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout2.xml.zlib  $gHDAContentsDirectory/Resources

sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout3.xml.zlib  $gHDAContentsDirectory/Resources
;;
1150 )
sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout2.xml.zlib  $gHDAContentsDirectory/Resources
;;
esac

# exit if error
if [ "$?" != "0" ]; then
    echo "Error: Installation failure"
    sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
    sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
    sudo touch $gExtensionsDirectory
    echo "Original S/L/E/AppleHDA.kext restored"
    echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
    exit 1
fi

fi    # end: if [ $gRealtekALC = 1 ]

sudo rm -R /tmp/ALC$gCodec.zip
sudo rm -R /tmp/$gCodec
sudo cp -R $gExtensionsDirectory/AppleHDA.kext $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA.kext

case $gSysName in

"El Capitan"|"Yosemite" )
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
# echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
# exit 1
# fi

echo ""
echo "Install finished, restart required."
echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit