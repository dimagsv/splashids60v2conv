Converter for SplashID Safe 3.32 for Symbian S60v2 (may be S60v1 and S60v3 
too) decrypted database file to KeePass 1.x CSV
(C) 2013 Dmitry Gusev (dimagsv@gmail.com)
License: GPL v3

Usage:
splashids60v2conv <.aRc file> <new csv file>

Example: 
splashids60v2conv .aRc file.csv


Q&A:

Q: How to compile?
A: You can use Free Pascal Compiler or download precompiled win32 version.

Q: How I can to obtain a decrypted database file of SplashID Safe 3.32 for 
Symbian S60v2?
A: The .aRc file (decrypted database) may be obtained by sending database via 
bluetooth or IR from phone using the SplashID program (Options - Send List - 
Bluetooth) to other phone or PC.

Q: Is export to .vid can be used to import to KeePass istead of this converter?
A: Export to .vid is not supported in SplashID Safe 3.32 for Symbian S60v2. 
But supported in SplashID 3.33 for S60v3. So, you can try to send passwords 
via bluetooth from S60v2 to S60v3 and then export to .vid.


Format of SplashID Safe 3.32 for Symbian S60v2 decrypted database (.aRc file)

File structure:
Size		Description
0x0C		file header
variable	record 1
variable	record 2
...
variable	record n

Record structure:
Size		Description
0x18		record header
variable	string 1, ending 0x00
...
variable	string 7, ending 0x00
0x07		record footer

Record header structure:
Offset	Size	Description
0x0E	0x02	new data type ID, when data type ID = 00 00
0x16	0x02	data type ID (00 00 - definition of new data type)

// Comment in Russian
Если заголовок записи в последних двух байтах (0x16-0x17) содержит не 00 00,
то это запись с данными и в этих байтах содержится код типа данных.

Если заголовок записи в (0x16-0x17) содержит 00 00, то эта запись определяет 
тип данных и названия колонок. Код типа записи содержится в байтах 0x0E-0x0F.
