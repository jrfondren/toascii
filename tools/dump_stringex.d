#! /usr/bin/env dub
/++ dub.sdl:
    configuration "release" {
        targetType "executable"
        dependency "stringex" version="~>0.2.1"
    }
    configuration "unittest" {
        targetType "library"
        dependency "silly" version="~>1.1.1"
        dependency "stringex" version="~>0.2.1"
    }
+/
/*
   run with: ./dump_stringex.d
   test with: dub test --single dump_stringex.d
 */
import std.stdio : write, writeln;
import std.format : format, unformatValue;
import std.format.spec : singleSpec;
import stringex.replacements;
import std.regex : matchFirst;
import std.conv : to;

const octal = singleSpec("%o");
string fix_escape(string s) {
    if (s == `"\a"`)
        return `"\x07"`;
    if (s == `"\v"`)
        return `"\x0b"`;
    if (s == `"\f"`)
        return `"\x0c"`;
    if (const m = s.matchFirst(`\\(\d+)`)) {
        string n = m[1];
        return format!`"\x%02x"`(unformatValue!int(n, octal));
    } else {
        return s;
    }
}

@("fix_escape")
unittest {
    assert(`"\v"`.fix_escape == `"\x0b"`);
    assert(`"\023"`.matchFirst(`\\(\d+)`));
    assert(`"\023"`.matchFirst(`\\(\d+)`)[1] == "023");
    assert(`"\023"`.fix_escape == "\"\\x13\"");
}

void dump_ocaml(immutable(string[]) a) {
    write("[|");
    foreach (s; a) {
        string q = format!"%s"([s]); // wrap in array to quote string
        write(q[1 .. $ - 1].fix_escape, ";");
    }
    writeln("|];");
}

version (unittest) {
} else {
    void main() {
        writeln("(* GENERATED FILE - c.f. tools/dump_stringex.d *)");
        writeln("let replacements: string iarray iarray = [|");
        foreach (rep; replacements) {
            dump_ocaml(rep);
        }
        writeln("|]");
    }
}
