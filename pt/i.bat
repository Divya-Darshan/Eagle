@echo off
set APK_PATH=..\app\eagle.apk
set PACKAGE_NAME=com.darshni.eaglet

echo Installing APK...
adb install -r "%APK_PATH%"

if %ERRORLEVEL% EQU 0 (
    echo Closing old app instance...
    adb shell am force-stop %PACKAGE_NAME%

    echo Launching app...
    adb shell monkey -p %PACKAGE_NAME% -c android.intent.category.LAUNCHER 1 >nul 2>&1
    
    if %ERRORLEVEL% EQU 0 (
        echo App launched successfully!
    ) else (
        echo Failed to launch automatically.
    )
) else (
    echo Installation failed.
    pause
)