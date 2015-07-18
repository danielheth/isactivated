set msBuildDir=%WINDIR%\Microsoft.NET\Framework\v4.0.30319
call %msBuildDir%\msbuild.exe  isActivated.sln /p:Configuration=Release /l:FileLogger,Microsoft.Build.Engine;logfile=Manual_MSBuild_ReleaseVersion_LOG.log
set msBuildDir=


::ONLY SIGN IF THE CERT IS AVAILABLE
if exist "C:\SignCert\MoranIT.pfx" (
	"C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\signtool.exe" sign /f "C:\SignCert\MoranIT.pfx" /p "%SIGNING_CERT_PASSWORD%" /t "http://timestamp.verisign.com/scripts/timestamp.dll" "%WORKSPACE%\isActivated\bin\Release\isActivated.exe"
) else (
	echo Skipping signing since we're not on build server.
)


pushd %WORKSPACE%\isActivated\bin\Release\
7za.exe a -tzip isactivated.zip isActivated.exe
pushd %WORKSPACE%\


::ONLY SIGN IF THE CERT IS AVAILABLE
if exist "C:\SignCert\MoranIT.pfx" (
	"C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\signtool.exe" sign /f "C:\SignCert\MoranIT.pfx" /p "%SIGNING_CERT_PASSWORD%" /t "http://timestamp.verisign.com/scripts/timestamp.dll" "%WORKSPACE%\isActivated\bin\Release\isActivated.zip"
) else (
	echo Skipping signing since we're not on build server.
)
