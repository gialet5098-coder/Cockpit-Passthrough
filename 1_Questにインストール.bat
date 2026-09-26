@echo off
setlocal
cd /d "%~dp0"
title Sim Cockpit Passthrough - Quest にインストール

set "ADB=%~dp0tools\platform-tools\adb.exe"
set "PKG=app.simcockpit.passthrough"
set "APK="
for %%f in ("%~dp0apk\*.apk") do set "APK=%%~ff"

echo ================================================================
echo   Sim Cockpit Passthrough を Quest 3 にインストールします
echo ================================================================
echo.
if not defined APK (
    echo apk フォルダにアプリが見つかりません。zip を展開し直してください。
    goto :fail
)

if exist "%ADB%" goto :adb_ready
echo [準備] Quest との通信に使う adb を Google の公式サイトから取得しています...
echo   （Android SDK Platform-Tools r37.0.1。初回だけで、Google の利用規約が適用されます）
powershell -NoProfile -Command "$ProgressPreference='SilentlyContinue'; $zip = Join-Path $env:TEMP 'platform-tools_r37.0.1-win.zip'; Invoke-WebRequest -Uri 'https://dl.google.com/android/repository/platform-tools_r37.0.1-win.zip' -OutFile $zip; if ((Get-FileHash $zip -Algorithm SHA256).Hash -ne '45F4D63113E895EBDE0C90F194099A4676B6AC653BD28D54314A9E022BBC1A99') { Remove-Item $zip; exit 1 }; Expand-Archive -Force $zip -DestinationPath '%~dp0tools'; Remove-Item $zip"
if not exist "%ADB%" (
    echo   取得できませんでした。インターネットにつながっているか確認して、もう一度実行してください。
    goto :fail
)
echo   取得しました。
echo.

:adb_ready

echo [1/3] Quest を探しています...
echo.
echo   USB ケーブルで Quest と PC をつないでください。
echo   ヘッドセットをかぶり、「USB デバッグを許可しますか？」が出たら
echo   「このコンピューターから常に許可」にチェックして「許可」を押してください。
echo.
"%ADB%" start-server > nul 2>&1

:wait
"%ADB%" get-state > nul 2>&1
if not errorlevel 1 goto :found
"%ADB%" devices | findstr /c:"unauthorized" > nul
if not errorlevel 1 (
    echo   Quest は見えていますが、まだ許可されていません。ヘッドセット内で「許可」を押してください...
) else (
    echo   待っています... ^(見つからない場合は、ケーブルの挿し直しと開発者モードを確認^)
)
timeout /t 3 /nobreak > nul
goto :wait

:found
echo   見つかりました。
echo.
echo [2/3] インストールしています（1分ほどかかります）...
"%ADB%" install -r "%APK%" > "%TEMP%\alvr_install.log" 2>&1
findstr /c:"Success" "%TEMP%\alvr_install.log" > nul
if errorlevel 1 (
    type "%TEMP%\alvr_install.log"
    echo.
    echo   インストールに失敗しました。上のメッセージを開発者に送ってください。
    goto :fail
)
echo   インストールできました。
"%ADB%" shell pm grant %PKG% com.oculus.permission.USE_SCENE > nul 2>&1
echo.
echo [3/3] アプリを起動します。
"%ADB%" shell am start -n %PKG%/android.app.NativeActivity > nul 2>&1
echo.
echo ================================================================
echo   完了です。USB ケーブルは抜いて大丈夫です。
echo   次からは Quest のライブラリ（提供元不明）の
echo   「Sim Cockpit Passthrough」から起動できます。
echo ================================================================
echo.
pause
exit /b 0

:fail
echo.
pause
exit /b 1
