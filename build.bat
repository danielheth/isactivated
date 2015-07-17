set msBuildDir=%WINDIR%\Microsoft.NET\Framework\v4.0.30319
call %msBuildDir%\msbuild.exe  isActivated.sln /p:Configuration=Release /l:FileLogger,Microsoft.Build.Engine;logfile=Manual_MSBuild_ReleaseVersion_LOG.log
set msBuildDir=


::ONLY SIGN IF THE CERT IS AVAILABLE
if exist "C:\SignCert\MoranIT.pfx" (
	signtool.exe sign /f "C:\SignCert\MoranIT.pfx" /p "M0r@n!T" /t "http://timestamp.verisign.com/scripts/timestamp.dll" "%WORKSPACE%\bin\Release\isActivated.exe"
) else (
	echo Skipping signing since we're not on build server.
)


pushd %WORKSPACE%\bin\Release\
7za.exe a -tzip isactivated.zip isActivated.exe
pushd %WORKSPACE%\


::ONLY SIGN IF THE CERT IS AVAILABLE
if exist "C:\SignCert\MoranIT.pfx" (
	signtool.exe sign /f "C:\SignCert\MoranIT.pfx" /p "M0r@n!T" /t "http://timestamp.verisign.com/scripts/timestamp.dll" "%WORKSPACE%\bin\Release\isActivated.zip"
) else (
	echo Skipping signing since we're not on build server.
)
