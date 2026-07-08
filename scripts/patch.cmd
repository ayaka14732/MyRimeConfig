@echo off
setlocal EnableExtensions

pushd "%~dp0\.."

powershell -NoProfile -ExecutionPolicy Bypass -Command "$path='root\jyut6ping3.dict.yaml'; $text=Get-Content -Raw -LiteralPath $path; $nl=[Environment]::NewLine; $replacement='  - jyut6ping3.custom'+$nl+'  - chengyusuyu'+$nl+'  - mydict'+$nl+'  - symbolic'+$nl+'...'; $text=$text -replace '(?m)^\.\.\.\r?$',$replacement; $full=(Resolve-Path -LiteralPath $path).Path; [IO.File]::WriteAllText($full,$text,[System.Text.UTF8Encoding]::new($false))"
set "STATUS=%ERRORLEVEL%"

popd
exit /b %STATUS%
