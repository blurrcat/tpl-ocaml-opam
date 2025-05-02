type 'a t [@@deriving show]

val empty : 'a t
val push : 'a -> 'a t -> 'a t
val peak : 'a t -> 'a option
val pop : 'a t -> 'a option * 'a list
