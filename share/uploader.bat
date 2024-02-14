@echo off

"D:\share\App\WinSCP.exe" ^
  /log="D:\share\log\log_upload.log" /ini=nul ^
  /command ^
    "open ftp://autoupload:password@host:8921/" ^
    "mput D:\share\Folder\*.xls* D:\share\Folder\*.csv /" ^
	"exit"
set WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
  echo Success
  cmd.exe /c del /s /f /q D:\share\Folder\*.xls* D:\share\Folder\*.csv
) else (
  echo Error
)

exit /b %WINSCP_RESULT%
