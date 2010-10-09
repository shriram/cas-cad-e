One of my students recently sent me this needless email message:

> Well, how would you do switch fall-through in Scheme? Could you
> write a version of the case statement that does that?

Since the honor of Racket was at stake (yes, we can have all the same
stupid features the scripting languages have!), I wrote down the code
for this, and realized it would make a cute little macro exercise.

Spec: define a case construct syntactically just like that of Racket.
In terms of semantics:

- each branch automatically falls through to the next,

- the last one returns its answer since it has no next clause, and

- any branch can contain (break <expr>), which evaluates <expr> and
returns its value as that of the entire case.

In honor of its behavor, we'll call this cas-cad-e.  Thus,

(define (cas1 v)
  (cas-cad-e v
           ((1) (display "1"))
           ((2) (display "2") (break 2)
           ((3) 3))))

(cas1 1) ==> 2       (and prints "12")
(cas1 2) ==> 2       (and prints "2")
(cas1 3) ==> 3       (and prints nothing)
(cas1 4) ==> <void>  (and prints nothing)

You should make sure your output is linear in the size of the input,
in particular avoiding a quadratic blow-up.
