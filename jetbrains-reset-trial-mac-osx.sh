#!/bin/bash
#https://github.com/bormaxi8080/SystemScripts/jetbrains-reset-trial-mac-osx.sh

for product in IntelliJIdea WebStorm DataGrip PhpStorm CLion PyCharm GoLand RubyMine Rider DataSpell AppCode; do
  echo "closing $product"
  ps aux | grep -i MacOs/$product | cut -d " " -f 5 | xargs kill -9

  echo "resetting trial period for $product"

  echo "removing evaluation key..."
  rm -rf ~/Library/Preferences/$product*/eval

  # Above path not working on latest version. Fixed below
  rm -rf ~/Library/Application\ Support/JetBrains/$product*/eval

  echo "removing all evlsprt properties in options.xml..."
  sed -i '' '/evlsprt/d' ~/Library/Preferences/$product*/options/other.xml

  # Above path not working on latest version. Fixed below
  sed -i '' '/evlsprt/d' ~/Library/Application\ Support/JetBrains/$product*/options/other.xml

  echo
done

echo "removing additional plist files..."
rm -f ~/Library/Preferences/com.apple.java.util.prefs.plist
rm -f ~/Library/Preferences/com.jetbrains.*.plist
rm -f ~/Library/Preferences/jetbrains.*.*.plist

echo "restarting cfprefsd"
killall cfprefsd

echo
echo "JetBrains products eveluations resetting, DONE"