(*
* Copyright (c) 2013 - Facebook. All rights reserved.
*)

(** Android lifecycle types and their lifecycle methods that are called by the framework *)

open Utils

(** return the complete list of (package, lifecycle_classname, lifecycle_methods) trios *)
val get_lifecycles : (string * string * string list) list

(** return true if [typ] is a subclass of [lifecycle_typ] *)
val typ_is_lifecycle_typ : Sil.typ -> Sil.typ -> Sil.tenv -> bool

(** return true if [typ] is a known callback class, false otherwise *)
val is_callback_class : Sil.typ -> Sil.tenv -> bool

(** return true if [procname] is a special lifecycle cleanup method *)
val is_destroy_method : Procname.t -> bool

(** returns an option containing the var name and type of a callback registered by [procname], None
if no callback is registered *)
val get_callback_registered_by : Procname.t -> (Sil.exp * Sil.typ) list -> Sil.tenv -> (Sil.exp * Sil.typ) option

(** return a list of typ's corresponding to callback classes registered by [procdesc] *)
val get_callbacks_registered_by_proc : Cfg.Procdesc.t -> Sil.tenv -> Sil.typ list

(** given an Android framework type mangled string [lifecycle_typ] (e.g., android.app.Activity) and
a list of method names [lifecycle_procs_strs], get the appropriate typ and procnames *)
val get_lifecycle_for_framework_typ_opt : Mangled.t -> string list -> Sil.tenv -> (Sil.typ * Procname.t list) option

(** return true if [class_name] is the name of a class that belong to the Android framework *)
val is_android_lib_class : Mangled.t -> bool

(** Path to the android.jar file containing real code, not just the method stubs as in the SDK *)
val non_stub_android_jar : unit -> string

(** [is_runtime_exception tenv exn] checks if exn is an unchecked exception *)
val is_runtime_exception : Sil.tenv -> Mangled.t -> bool
