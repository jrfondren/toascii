open Toascii

let () =
  assert (
    Unidecode.to_ascii {|“Standard ML” variants "|}
    = {|"Standard ML" variants "|})

let () =
  assert (
    Unidecode.to_ascii "Семь раз отмерь, один раз отрежь"
    = "Siem' raz otmier', odin raz otriezh'")

let () = assert (Unidecode.to_ascii "天下無敌" = "Tian Xia Wu Di ")
