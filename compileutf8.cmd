@echo off
cd .\utility\
schange bytecomposition.src
schange runtimefieldmanager.src
cd ..\file\
schange filereadwrite.src
schange fileopecode.src
schange fileruntimefield.src
schange filestackmaptable.src
schange filelocalvariable.src
cd ..\word\
schange cwordcheck.src
schange cstring.src
schange print.src
schange calc.src
schange inspect_character.src
schange loopcounter.src
schange cinteger.src
schange check.src
schange if.src
schange loop.src
schange others.src
schange input.src
schange stringoperate.src
schange stackoperate.src
schange comment.src
schange wordcheck.src
cd ..\runtimefield\
schange runtimefieldClass.src
schange runtimefieldNameAndType.src
schange runtimefieldMethod.src
schange runtimefieldField.src
cd ..
schange debug.src
schange compiler.src
schange functiontype.src
schange opecode.src
schange stackmaptable.src
schange utf8rap.src

umind jmindc.src