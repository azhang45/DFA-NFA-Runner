#lang racket 


(define (find-delta-tuple delta curr-state input)
    (findf 
        (lambda (d) (and (equal? (car d) curr-state) (equal? (cadr d) input)))
        delta))

; (define (find-delta-tuple delta curr-state input)
;     (findf 
;         (lambda (d) #t)
;         delta))

(define (finalstate? s0 F)
    (cond
        ((eq? (index-of F s0) #f) #f)
        (else #t)))   

(define (DFA input Sigma S s0 delta F)
    (cond
        ((= (string-length input) 0)
            (finalstate? s0 F))
        (else
            (define transition    (find-delta-tuple delta s0 (substring input 0 1)))

            (DFA (substring input 1) Sigma S (caddr transition) delta F))))


(define test-input "aaaaaaaaaaaaaaaaaabaaab")
(define test-Sigma '("a" "b"))
(define test-S '(HAPPY SAD))
(define test-s0 'SAD)
(define test-Delta '(
    (SAD "a" HAPPY) (HAPPY "a" HAPPY)
    (SAD "b" SAD) (HAPPY "b" SAD)
))
(define test-F '(HAPPY))

(DFA test-input test-Sigma test-S test-s0 test-Delta test-F)
(displayln "pls work.jpg :tm:")
(DFA "0100" '("1" "0") '(q0 q1) 'q0 '((q0 "0" q0) (q0 "1" q1) (q1 "0" q1) (q1 "1" q1)) '(q1))
