set msBuildDir=%WINDIR%\Microsoft.NET\Framework\v4.0.30319
call %msBuildDir%\msbuild.exe  isActivated.sln /p:Configuration=Release /l:FileLogger,Microsoft.Build.Engine;logfile=Manual_MSBuild_ReleaseVersion_LOG.log
set msBuildDir=

pushd isActivated\bin\Release\
7za.exe a -tzip isactivated.zip isActivated.exe
cd ../../../