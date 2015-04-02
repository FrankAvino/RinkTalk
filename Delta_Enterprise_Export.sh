#!/bin/bash
# original source from http://www.thecave.com/2014/09/16/using-xcodebuild-to-export-a-ipa-from-an-archive/

xcodebuild clean -project RinkTalkTestingTwo -configuration Release -alltargets
xcodebuild archive -project RinkTalkTestingTwo.xcodeproj -scheme RinkTalkTestingTwo -archivePath RinkTalkTestingTwo.xcarchive
xcodebuild -exportArchive -archivePath RinkTalkTestingTwo.xcarchive -exportPath RinkTalkTestingTwo2 -exportFormat ipa -exportProvisioningProfile "Delta"
mv -i RinkTalkTestingTwo2.ipa  RinkTalkTestingTwo.ipa