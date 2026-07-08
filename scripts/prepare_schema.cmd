@echo off
setlocal EnableExtensions EnableDelayedExpansion

pushd "%~dp0\.."

if not exist "root" mkdir "root"
if not exist "opencc" mkdir "opencc"

call :prepare_schema rime/rime-cantonese main || goto :error
call :prepare_schema rime/rime-emoji master || goto :error
call :prepare_schema rime/rime-emoji-cantonese master || goto :error
call :prepare_schema rime/rime-ipa master || goto :error
call :prepare_schema rime/rime-luna-pinyin master || goto :error
call :prepare_schema rime/rime-prelude master || goto :error
call :prepare_schema CanCLID/rime-loengfan main || goto :error
call :prepare_schema nk2028/rime-kyonh main || goto :error
call :prepare_schema nk2028/rime-tupa main || goto :error
call :prepare_schema sgalal/rime-hanja master || goto :error
call :prepare_schema sgalal/rime-kunyomi master || goto :error
call :prepare_schema sgalal/rime-symbolic master || goto :error
call :prepare_schema szc126/rime-liangfen main || goto :error
call :prepare_schema ayaka14732/rime-ayaka-v8 main || goto :error

del /q "root\*.recipe.yaml" 2>nul

for %%N in (t2hk t2jp t2s t2tw) do (
    curl -f -L -s -o "opencc\%%N.json" "https://raw.githubusercontent.com/BYVoid/OpenCC/master/data/config/%%N.json"
    if errorlevel 1 goto :error
)

if not exist "root\essay.txt" (
    curl -f -L -s -o "root\essay.txt" "https://github.com/rime/rime-essay/raw/master/essay.txt"
    if errorlevel 1 goto :error
)

popd
exit /b 0

:prepare_schema
set "REPO=%~1"
set "BRANCH=%~2"
set "TMPDIR=tmp"
set "SRC="

if exist "%TMPDIR%" rmdir /s /q "%TMPDIR%"
mkdir "%TMPDIR%" || exit /b 1

curl -f -L -s -o "%TMPDIR%\data.zip" "https://github.com/%REPO%/archive/refs/heads/%BRANCH%.zip"
if errorlevel 1 (
    echo Failed to download %REPO% %BRANCH%. 1>&2
    exit /b 1
)

tar -xf "%TMPDIR%\data.zip" -C "%TMPDIR%"
if errorlevel 1 (
    echo Failed to extract %REPO% %BRANCH%. 1>&2
    exit /b 1
)

for /d %%D in ("%TMPDIR%\*") do set "SRC=%%~fD"
if not defined SRC (
    echo Extracted archive for %REPO% %BRANCH% did not contain a source directory. 1>&2
    exit /b 1
)

move /Y "!SRC!\*.yaml" "root\" >nul 2>nul

if exist "!SRC!\*.txt" (
    move /Y "!SRC!\*.txt" "root\" >nul
)

if exist "!SRC!\opencc\" (
    move /Y "!SRC!\opencc\*" "opencc\" >nul 2>nul
)

rmdir /s /q "%TMPDIR%"
exit /b 0

:error
if exist "tmp" rmdir /s /q "tmp"
popd
exit /b 1
