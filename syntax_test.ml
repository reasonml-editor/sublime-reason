// SYNTAX TEST "Reason.sublime-syntax"

// hi
// ^ source.ml comment.line

    /* hello
//  ^ source.ml comment.block
  world */
//       ^ source.ml comment.block

   "aa";
// ^^^ source.ml string.quoted.double
//     ^ source.ml punctuation.terminator

   'a'
// ^^^ source.ml string.quoted.single

   'ab'
// ^^^ source.ml

exception Hello
//        ^ source.ml

let a = -.0.1
//      ^^ source.ml keyword.operator
//        ^^^ source.ml constant.numeric
let a = 0b1
//    ^ source.ml keyword.operator
//      ^^^ source.ml constant.numeric
let a = 0o73
//      ^^^^ source.ml constant.numeric
let a = 0xff
//      ^^^^ source.ml constant.numeric
let a = 0Xff
//      ^^^^ source.ml constant.numeric
let a = +1_000_000.12
//      ^ source.ml keyword.operator
//       ^^^^^^^^^^^^ source.ml constant.numeric
let a = 1E3
//      ^^^source.ml constant.numeric
// bad
let a = 0bf
//      ^^^source.ml
let a = 0o58
//      ^^^^source.ml
let a = 0xfz
//      ^^^^source.ml
let a = -.1
//      ^^ source.ml keyword.operator
//        ^source.ml
let a = 1.
//      ^source.ml constant.numeric
//       ^source.ml punctuation.accessor
let a = .2
//      ^source.ml punctuation.accessor
//       ^source.ml constant.numeric

   let bar = true
// ^ source.ml keyword
//           ^source.ml constant.language
let recordAccess = fooRecord.myName
//                          ^source.ml punctuation.accessor
let recordAccessWithScope = fooRecord.ReasonReact.myName
//                                    ^source.ml entity.name.namespace

let [1, 2.2] = foo()
//   ^ source.ml constant.numeric
//      ^^^ source.ml constant.numeric
let [c, [a, [1], list[a, ...rest],  c], 2.2] = [c, 1, "d", 'a', 1+2]
//               ^ source.ml keyword
//                       ^ source.ml keyword.operator

   type bla('a) = {
// ^ source.ml storage.type
//                ^ source.ml punctuation.section.braces.begin
  a: int,
     // ^ source.ml punctuation.separator
  ok: 'a,
   }
// ^ source.ml punctuation.section.braces.end

let getItem = (theList) =>
  if callSomeFunctionThatThrows() {
    /* return the found item here */
//  ^ source.ml comment.block
  } else {
    raise(Not_found)
  }

let result =
  try (getItem([1, 2, 3])) {
  | Not_found => 0 /* Default value if getItem throws */
//^ source.ml punctuation.separator
              //   ^ source.ml comment.block
  }

let getCenterCoordinates = (aBla, doHello, ~b=1, ~c, ()) => {
                                        // ^ source.ml punctuation.definition.keyword
  let x = doSomeOperationsHere("a")
  let yy = doSomeMoreOperationsHere()
  (x, y)
}

type profession = Teacher | Director
               // ^ source.ml
/* test */

let person1 = Teacher
//            ^ source.ml
let getProfession = (person) =>
  switch person {
  | [Teacher] => "A teacher"
  | Director => "A director"
  }

   open Soup
// ^ source.ml keyword
//      ^ source.ml entity.name.namespace
include {let a = 1}
//       ^ source.ml keyword
open Belt.Map
//   ^ source.ml entity.name.namespace
//        ^ source.ml entity.name.namespace
include Belt.Map.Make()
//               ^ source.ml entity.name.namespace

   Foo.Some(Bar)
// ^ source.ml entity.name.namespace
//     ^ source.ml
//          ^ source.ml
Foo.Some(Bar())
//       ^ source.ml
Foo.make(Bar())
module Bla = Belt.Map.Make(Bar({type t let a:b = "cc"}))
//     ^ source.ml entity.name.namespace
//           ^ source.ml entity.name.namespace
//                    ^ source.ml entity.name.namespace
//                        ^ source.ml punctuation.section.braces.begin
//                         ^ source.ml entity.name.namespace
//                            ^ source.ml punctuation.section.braces.begin
//                              ^ source.ml storage.type
//                                                    ^ source.ml punctuation.section.braces.end
//                                                     ^ source.ml punctuation.section.braces.end
module SetOfIntPairs: Foo = MakeSet(IntPair)
//                    ^ source.ml entity.name.namespace
//                          ^ source.ml entity.name.namespace
//                                  ^ source.ml entity.name.namespace
module SetOfIntPairs = MakeSet((IntPair), Bar);
//                              ^ source.ml entity.name.namespace
//                                        ^ source.ml entity.name.namespace
module SetOfIntPairs = MakeSet(IntPair({type t = Bar}))
//                             ^ source.ml entity.name.namespace
//                                               ^ source.ml
module Foo = (Bar: Baz) => (Bar: Baz) => {let a = Bar};
//            ^ source.ml entity.name.namespace
//                 ^ source.ml entity.name.namespace
//                          ^ source.ml entity.name.namespace
//                               ^ source.ml entity.name.namespace
//                                                ^ source.ml
module Foo = (Bar: Baz) => (Bar: Baz) => List;
//                                       ^ source.ml entity.name.namespace

module Nested = (Foo: {}) => {
  module NestMore = Bla
//       ^ source.ml entity.name.namespace
//                  ^ source.ml entity.name.namespace
}
module type Bla = {
//          ^ source.ml entity.name.namespace
  include (module type of BaseComponent)
//                        ^ source.ml entity.name.namespace
}
/* test */
module School = {
  type profession = Teacher | Director
  /* test */

  let person1 = Teacher
  let getProfession = (person) =>
    switch (person) {
    | Teacher => "A teacher"
    | Director => "A director"
    }
  module Nested = (
    Foo: Bar,
//  ^ source.ml entity.name.namespace
//       ^ source.ml entity.name.namespace
    {
      type a = Bar
//             ^ source.ml
      let a = ["1"]
    }
  ) => {
    module NestMore =
      Bla
//    ^ source.ml entity.name.namespace
    module NestMore = (Foo: {}) => Bla
//                     ^ source.ml entity.name.namespace
//                                 ^ source.ml entity.name.namespace
  }
  module Nested2 = (
    Foo: Bar,
//  ^ source.ml entity.name.namespace
//       ^ source.ml entity.name.namespace
    Bar: Baz,
//  ^ source.ml entity.name.namespace
//       ^ source.ml entity.name.namespace
  ) => List
//     ^ source.ml entity.name.namespace
  module Nested = (Foo: Bar, {type a = Bar let a = 1 } ) => {
//                 ^ source.ml entity.name.namespace
//                      ^ source.ml entity.name.namespace
//                                     ^ source.ml
    module NestMore = Bla
    module NestMore: Foo = Bla
    module NestMore: {type t = Bar} = Bla
//                   ^ source.ml punctuation.section.braces.begin
//                             ^ source.ml
//                                ^ source.ml punctuation.section.braces.end
//                                    ^ source.ml entity.name.namespace
    module NestMore: {type t = Bar} = {
//                             ^ source.ml
      type t = Variant
//             ^ source.ml
      let a = ["hello"]
    }
    module NestMore = (Foo: {type t = Variant}) => Bla
    module NestMore: Bla = (Foo: {}) => Bla
    module NestMore: {type t = Bar let a: b = "cc" module Foo = {}} = (Foo: {}) => Bla
//                             ^ source.ml
//                                                        ^ source.ml entity.name.namespace
    module type NestMore = {}
    module NestMore = () => Bla.Qux
//                              ^ source.ml entity.name.namespace
  }
}

let p: School.School2.profession = School.getProfession(School.Foo)
//     ^ source.ml entity.name.namespace
//            ^ source.ml entity.name.namespace
//                                                      ^ source.ml entity.name.namespace
//                                                             ^ source.ml

let getAudience = (~excited) => excited ? "world!" : "world"

let jsx = <div className="foo">
  <>
    hi
  </>
  <Comp.Uter bar />
// ^ source.ml entity.name.namespace
//      ^ source.ml entity.name.namespace
  <Foo>
// ^ source.ml entity.name.namespace
    "hi"
  </Foo>
//  ^ source.ml entity.name.namespace
  <Foo.Bar> {"hi"} </Foo.Bar>
//     ^ source.ml entity.name.namespace
//                       ^ source.ml entity.name.namespace
  <Comp bar />
// ^ source.ml entity.name.namespace
</div>


// Invalid tests
let \"a b" = c
let nope = `hi`
//         ^^^^ source.ml string.quoted.other
let nope2 = j`hi`
//          ^ source.ml string.quoted.other variable.annotation
//           ^^^^ source.ml string.quoted.other
let variant = #foo
//            ^ source.ml punctuation.definition.keyword
type a = option<bar>

   @foo(bar) let a = 1
// ^ source.ml meta.annotation punctuation.definition.annotation
//  ^^^ source.ml meta.annotation variable.annotation
@foo (bar) let a = 1
@foo(@bar(baz)) let a = 1
//   ^ source.ml meta.annotation punctuation.definition.annotation
//    ^^^ source.ml meta.annotation variable.annotation
@foo let a = 1
   @@foo let a = 1
// ^^ source.ml meta.annotation punctuation.definition.annotation
@@foo(bar) let a = 1
   %foo(bar)-2
// ^ source.ml meta.annotation punctuation.definition.annotation
//  ^^^ source.ml meta.annotation variable.annotation
%foo (bar)-2
%foo-1
   %%foo let a = 1
// ^^ source.ml meta.annotation punctuation.definition.annotation
//   ^^^ source.ml meta.annotation variable.annotation
%%foo(bar) let a = 1
%%foo (bar) let a = 1

@bs.module external foo: {..} => {...} = "bla"
//                        ^^ source.ml keyword.operator
//                                ^^^ source.ml keyword.operator

let asd = ["bar"]
let asd = list["bar"]
//        ^ source.ml keyword
let asd = foo["bar"]
//        ^ source.ml
   foo["bar"] = baz
// ^ source.ml
