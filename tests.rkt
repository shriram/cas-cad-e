#lang racket

(require "cascade.rkt")

(define (cad0 v)
  (cas-cad-e v))
(define (cas0 v)
  (case v))

(unless (equal? (cad0 'dummy) (cas0 'dummy)) (error 'cas-cad-e "base cases are not the same"))

(define (cas1 v)
   (cas-cad-e v
            ((0 1) (display "0 and/or 1"))
            ((2  ) (display "2") (break "2"))
            ((3  ) (display "3"))
            ((4  ) (display "4") (break "4"))
            ((5 6) (display "5"))))

#|
> (cas1 0)
0 and/or 12"2"
> (cas1 1)
0 and/or 12"2"
> (cas1 2)
2"2"
> (cas1 3)
34"4"
> (cas1 4)
4"4"
> (cas1 5)
5
> (cas1 6)
5
> (cas1 7)
|#