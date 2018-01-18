adb remount

adb shell "cd /system/priv-app && rm -rf xcm && mkdir xcm"

adb push xcm.apk  /system/priv-app/xcm

echo adb更新完成！
echo. & pause 