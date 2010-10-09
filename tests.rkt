#lang racket

(require "cascade.rkt")
(require test-engine/racket-tests)

(define (cad0 v)
  (cas-cad-e v))
(define (cas0 v)
  (case v))

(check-expect (cad0 'anything) (cas0 'anything))

(define (cas1 v)
   (cas-cad-e v
            ((1) (display "1"))
            ((2) (display "2") (break 2))
            ((3) 3)))
(check-expect (cas1 1) 2) "12"
(check-expect (cas1 2) 2) "2"
(check-expect (cas1 3) 3)

(define (cas2 v)
   (cas-cad-e v
            ((0 1) (display "0/1"))
            ((2  ) (display "2") (break 2))
            ((3  ) (display "3"))
            ((4  ) (display "4") (break 4))
            ((5 6) (display "5/6") 6)))

(check-expect (cas2 0) 2) "0/12"
(check-expect (cas2 1) 2) "0/12"
(check-expect (cas2 2) 2) "2"
(check-expect (cas2 3) 4) "34"
(check-expect (cas2 4) 4) "4"
(check-expect (cas2 5) 6) "5/6"
(check-expect (cas2 6) 6) "5/6"
(check-expect (cas2 7) (void))

(test)