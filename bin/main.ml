open Toascii

let () =
  match Sys.argv with
  | [|_; filename|] ->
    let tmpname = Printf.sprintf "%s.out.%d" filename (Unix.getpid ()) in
    let fin = Unix.openfile filename [O_RDONLY] 0 in
    let stat = Unix.fstat fin in
    let fout =
      Unix.openfile tmpname [O_WRONLY; O_CREAT; O_TRUNC] stat.st_perm
    in
    Unix.fchown fout stat.st_uid stat.st_gid;
    let oc = Unix.out_channel_of_descr fout in
    let ic = Unix.in_channel_of_descr fin in
    In_channel.fold_lines
      (fun () line -> Printf.fprintf oc "%s\n" (Unidecode.to_ascii line))
      () ic;
    Unix.rename tmpname filename
  | [|_|] ->
    In_channel.fold_lines
      (fun () line -> print_endline (Unidecode.to_ascii line))
      () stdin
  | _ ->
    Printf.eprintf "usage: %s [<filename>]\n" Sys.argv.(0);
    exit 1
