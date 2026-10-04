@echo off
chcp 65001 >nul
echo ========================================================
echo        تطبيق نور (Noor) - تحديث النسخة على الهاتف
echo ========================================================
echo.

set ADB="E:\AI_Tools\platform-tools\adb.exe"
set APK="build\app\outputs\flutter-apk\app-release.apk"

if not exist %APK% (
    set APK="Noor_Latest_Release.apk"
)

if not exist %ADB% (
    set ADB="adb"
)

echo [1/3] جاري فحص اتصال الهاتف عبر USB...
%ADB% devices > temp_devices.txt
findstr /R /C:"[0-9a-zA-Z].*device$" temp_devices.txt >nul
if %errorlevel% neq 0 (
    echo.
    echo [!] لم يتم العثور على هاتف متصل ومفعل به وضع تصحيح الأخطاء (USB Debugging).
    echo يرجى توصيل الهاتف والتأكد من تفعيل USB Debugging.
    del temp_devices.txt 2>nul
    pause
    exit /b 1
)
del temp_devices.txt 2>nul

echo [√] تم اكتشاف هاتفك بنجاح!
echo.
echo [2/3] جاري محاولة التثبيت المباشر عبر ADB...
%ADB% install -r %APK%

if %errorlevel% equ 0 (
    echo.
    echo ========================================================
    echo   [√] تم تحديث تطبيق نور على هاتفك بنجاح تام!
    echo ========================================================
    echo.
    echo [3/3] جاري فتح التطبيق على هاتفك...
    %ADB% shell am start -n com.noor.noor_app/com.noor.noor_app.MainActivity
    pause
    exit /b 0
)

echo.
echo [!] حماية الهاتف (خاصة هواتف شاومي / ريدمي) منعت التثبيت الصامت عبر USB.
echo [!] جاري إرسال ملف التحديث مباشرة إلى مجلد التنزيلات (Downloads) في هاتفك...
%ADB% push %APK% /sdcard/Download/Noor_App.apk

if %errorlevel% equ 0 (
    echo.
    echo [√] تم إرسال ملف التحديث بنجاح إلى هاتفك:
    echo     المسار داخل الهاتف: مجلد Downloads / Noor_App.apk
    echo.
    echo جاري فتح شاشة التثبيت على شاشة هاتفك الآن...
    %ADB% shell am start -a android.intent.action.VIEW -d "file:///sdcard/Download/Noor_App.apk" -t "application/vnd.android.package-archive" 2>nul
    echo.
    echo --------------------------------------------------------
    echo كل ما عليك فعله الآن:
    echo 1. افتح شاشة هاتفك، واضغط "تثبيت / تحديث" (Install / Update).
    echo 2. أو افتح "مدير الملفات" (File Manager) في هاتفك ^<- مجلد التنزيلات (Downloads)
    echo    واضغط على ملف Noor_App.apk لتحديث التطبيق فوراً.
    echo --------------------------------------------------------
)

echo.
pause
