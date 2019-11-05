import std.stdio: File, stderr;
import std.format: format;
import std.process: thisProcessID;
import std.file: rename, remove;
import stringex.unidecode: unidecode;

bool copyLines(string inName, string outName, string function(string) convert) {
    auto fin = File(inName, "r");
    auto fout = File(outName, "w");
    auto changed = false;
    foreach (line; fin.byLineCopy) {
        auto newLine = convert(line);
        if (!changed && line != newLine) changed = true;
        fout.writeln(newLine);
    }
    return changed;
}

int main(string[] args) {
    if (args.length != 2) {
        stderr.writeln("usage: ", args[0], " <filename>");
        return 1;
    }
    auto tmpName = format("%s.out.%d", args[1], thisProcessID);
    if (copyLines(args[1], tmpName, &unidecode)) {
        tmpName.rename(args[1]);
    } else {
        tmpName.remove();
        stderr.writeln("No change to input file.");
    }
    return 0;
}
