#!/bin/bash
tempDir=tmp
SourceDir=source
remove(){
rm -r $tempDir
rm -r $SourceDir
}
mkdir $tempDir
mkdir $SourceDir
echo "Test Text" > $SourceDir/testFile.txt

bash $1 "$SourceDir" "$tempDir"

if [[ ! -f "$tempDir/$SourceDir/testFile.txt" ]]
then
    echo "файл не был скопирован"
    remove
    exit 1
fi

hash1=$(sha256sum $SourceDir/testFile.txt | awk '{ print $1 }')
hash2=$(sha256sum $tempDir/$SourceDir/testFile.txt | awk '{ print $1 }')

if [ "$hash1" == "$hash2" ]
then
    echo "тест пройден успешно"
    remove
    exit 0
else
    echo "файл скопирован неправильно"
    remove
    exit 2
fi
