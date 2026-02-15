import std.stdio : File, stderr, stdin, stdout;
import std.format : format;
import std.process : thisProcessID;
import std.file : rename, remove;
import stringex.unidecode : unidecode;

bool copyLines(File fin, File fout, string function(string) convert) {
    bool changed = false;
    foreach (pre; fin.byLineCopy) {
        string post = convert(pre);
        if (!changed && pre != post)
            changed = true;
        fout.writeln(post);
    }
    return changed;
}

int main(string[] args) {
    switch (args.length) {
    case 1:
        copyLines(stdin, stdout, &unidecode);
        break;
    case 2:
        bool res;
        string tmpName = format("%s.out.%d", args[1], thisProcessID);
        {
            File fin = File(args[1], "r");
            File fout = File(tmpName, "w");
            res = copyLines(fin, fout, &unidecode);
        }
        if (res) {
            tmpName.rename(args[1]);
        } else {
            tmpName.remove();
            stderr.writeln("No change to input file.");
        }
        break;
    default:
        stderr.writeln("usage: ", args[0], " [<filename>]");
        return 1;
    }
    return 0;
}
