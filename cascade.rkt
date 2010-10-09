#lang racket

(provide cas-cad-e)

(define-syntax (cas-cad-e s)

 (define (gen-letrec-block-terms thunk-names exprs)
   (syntax-case exprs ()
     [() #'()]
     [((e ...)) (syntax-case thunk-names ()
                  [(t) #'((t (lambda () e ...)))])]
     [((e0 ...) er ...)  ;; must be two or more, so t0 t1 pattern below is justified
      (syntax-case thunk-names ()
        [(t0 t1 tr ...)
         (with-syntax ([(rest-of-block ...)
                        (gen-letrec-block-terms #'(t1 tr ...) #'(er ...))])
           #'((t0 (lambda () (begin e0 ... (t1))))
              rest-of-block ...))])]))

 (syntax-case s ()
   [(kwd expr (v e ...) ...)
    (with-syntax ([break (datum->syntax #'kwd 'break)]
                  [(thunk-names ...) (generate-temporaries #'(v ...))])
      (with-syntax ([(letrec-terms ...)
                     (gen-letrec-block-terms #'(thunk-names ...)
                                             #'((e ...) ...))])
        #'(call/cc
           (lambda (break)
             (letrec (letrec-terms ...)
               (case expr
                 [v (thunk-names)]
                 ...))))))]))

