// splashids60v2conv 1.0 - convert Splash ID Safe for Symbian S60v2 decrypted database file to KeePass 1.x CSV
// (C) 2013 Dmitry Gusev
// dimagsv@gmail.com
// License: GPL v3
program splashids60v2conv;
uses
        sysutils;
const
	FileHeaderSize   = $C;
	RecordHeaderSize = $18;
	RecordFooterSize = $7;
	ColumnsPerRecord = 7;
type
	TFileHeader   = array[0..FileHeaderSize - 1] of byte;
	TRecordHeader = array[0..RecordHeaderSize - 1] of byte;
	TRecordFooter = array[0..RecordFooterSize - 1] of byte;

var
	inpf: file of byte;
	outpf: text;
	FileHeader: TFileHeader;
	RecordHeader: TRecordHeader;
	RecordFooter: TRecordFooter;
	i, j: integer;
	data: array[0..ColumnsPerRecord - 1] of UTF8String;
	s: AnsiString;
	b: byte;
        comments: AnsiString;
begin
	if paramcount() <> 2 then
	begin
		writeln('Usage: splashids60v2 <input.db> <output.csv>');
		exit;
	end;

	assign(inpf, paramstr(1));
	assign(outpf, paramstr(2));

	reset(inpf);
	rewrite(outpf);
        writeln(outpf, '"Account","Login Name","Password","Web Site","Comments"');

	// Reading file header
	for i := 0 to FileHeaderSize - 1 do
	begin
		read(inpf, FileHeader[i]);
	end;

	// Reading recods from input file
	while not eof(inpf) do
	begin

		// Reading record header
		for i:=0 to RecordHeaderSize - 1 do
		begin
                        read(inpf, b);
                        RecordHeader[i] := b;
		end;

		// Reading record data
		for i := 0 to ColumnsPerRecord - 1 do
		begin
			j := 1;
			SetLength(s, 2000); // buffer
			repeat
				Read(inpf, b);
				s[j] := Chr(b);
                                inc(j);
			until b = 0;
			SetLength(s, j - 2);
                        s := StringReplace(s, '\', '\\', [rfReplaceAll]); // escaping \
                        s := StringReplace(s, '"', '\"', [rfReplaceAll]); // escaping "
                        data[i] := AnsiToUTF8(s);

                end;

                write(outpf, '"' + data[0] + '",'); // "Account"
                write(outpf, '"' + data[1] + '",'); // "Login Name"
                write(outpf, '"' + data[2] + '",'); // "Password"
                write(outpf, '"' + data[3] + '",'); // "Web Site"
                comments := data[4];
                if (comments <> '') and (data[5] <> '') then comments := comments + #13#10;
                comments := comments + data[5];
                if (comments <> '') and (data[6] <> '') then comments := comments + #13#10;
                comments := comments + data[6];
                write(outpf, '"' + comments + '"'); // "Comments"

                writeln(outpf);

		// Reading record footer
		for i := 0 to RecordFooterSize - 1 do
		begin
                        read(inpf, b);
                        RecordFooter[i] := b;
		end;

	end;

        close(outpf);
	close(inpf);

end.
