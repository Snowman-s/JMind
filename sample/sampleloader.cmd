@ECHO OFF
for %%a in (*.src) do ..\jmindc.exe %%a
for %%a in (*.java) do javac -encoding UTF8 %%a