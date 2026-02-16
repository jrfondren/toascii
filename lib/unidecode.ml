let bprint_codepoint buf cp =
  let open Replacements in
  let group = cp lsr 8 in
  let point = cp land 0xFF in
  if
    group < Iarray.length replacements
    && point < Iarray.length (Iarray.get replacements group)
  then
    Buffer.add_string buf (Iarray.get (Iarray.get replacements group) point)

let bprint buf s =
  let rec loop s i len =
    if i < len then (
      let uc = String.get_utf_8_uchar s i in
      if not (Uchar.utf_decode_is_valid uc) then
        loop s (i + Uchar.utf_decode_length uc) len
      else
        let cp = Uchar.to_int (Uchar.utf_decode_uchar uc) in
        bprint_codepoint buf cp;
        loop s (i + Uchar.utf_decode_length uc) len)
  in
  loop s 0 (String.length s)

let is_ascii = String.for_all (fun c -> Char.code c < 0x80)

let to_ascii s =
  if is_ascii s then
    s
  else
    let buf = Buffer.create (String.length s) in
    bprint buf s;
    Buffer.contents buf
