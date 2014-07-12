#use "topfind";;
#thread;;
#camlp4o;;
#require "core.top";;
#require "core.syntax";;

let () =
  try Topdirs.dir_directory (Sys.getenv "OCAML_TOPLEVEL_PATH")
  with Not_found -> ()
;;

open Core.Std
