open Containers

type 'a t = 'a list [@@deriving show]

let empty = []
let push item stack = item :: stack
let peak = List.head_opt

let pop stack =
  match stack with [] -> (None, stack) | head :: rest -> (Some head, rest)

let%expect_test "test stack" =
  let inspect s =
    Format.printf "stack: %a\n" (pp Int.pp) s;
    s
  in
  let stack = empty |> push 1 |> push 2 |> inspect in
  [%expect {| stack: [2; 1] |}];
  let head = peak stack in
  Format.printf "head: %a\n" (Option.pp Int.pp) head;
  [%expect {| head: Some 2 |}];

  let popped, stack = pop stack in
  Format.printf "popped: %a\n" (Option.pp Int.pp) popped;
  [%expect {| popped: Some 2 |}];
  let _ = inspect stack in
  [%expect {|
    stack: [1]
  |}];

  let popped, stack = pop stack in
  Format.printf "popped: %a\n" (Option.pp Int.pp) popped;
  [%expect {| popped: Some 1 |}];
  let _ = inspect stack in
  [%expect {| stack: [] |}];

  let popped, stack = pop stack in
  Format.printf "popped: %a\n" (Option.pp Int.pp) popped;
  [%expect {| popped: None |}];
  let _ = inspect stack in
  [%expect {| stack: [] |}]
