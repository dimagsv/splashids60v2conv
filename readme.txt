Converter for Splash ID Safe for Symbian S60v2 decrypted database file to KeePass 1.x CSV
(C) 2013 Dmitry Gusev (dimagsv@gmail.com)
License: GPL v3


FAQ

Q: How to compile?
A: You can use Free Pascal Compiler or download precompiled win32 version.

Q: How I can to obtain a decrypted database file of SplashID Safe 3.32 for Symbian S60v2?
A: The .aRc file (decrypted database) may be obtained by sending database via bluetooth or IR from phone using the SplashID program (menu - send - bluetooth) to other phone or PC.


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
