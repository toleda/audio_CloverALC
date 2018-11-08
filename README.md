![alt text](https://github.com/toleda/audio_RealtekALC/blob/master/sound.jpeg)
# audio\_cloverALC

**macOS/Clover Patched Desktop AppleHDA Realtek ALC Audio**

## 11/8/18 - Deprecated

Note: cloverALC script does not support Mojave and newer

Realtek onboard audio: try AppleALC.kext  
See https://github.com/acidanthera/AppleALC

AppleALC.kext/toleda

1.  Codecs: Layout (AppleALC.kext)
    1.  885: 1
    4.  887: 1, 2, 3
    5.  888: 1, 2, 3
    6.  889: 1
    7.  892: 1, 2, 3
    8.  898: 1, 2, 3
    9.  1150: 1, 2, 3
    10. 1220: 1, 2
    11. 1220A: 1, 2

2.  Layout (config.plist/Devices/Audio/Inject/1 or 2 or 3)
    
    1 - 1/2/3/5/6 motherboard audio ports

    2 - 3 motherboard audio ports, 2 in/1 out becomes 3 out/5.1 surround sound

    3 - HD3000/HD4000 HDMI audio with Realtek ALC audio/Orange port is diaabled