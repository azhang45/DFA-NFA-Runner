#lang racket
(require "NFA.rkt")

(define (map-delta delta)
    (map
        (lambda (tuple) `(,(first tuple) ,(second tuple) (,(third tuple))))
        delta))

(define (DFA->NFA machine)
    (list (first machine) (second machine) (third machine) (map-delta (fourth machine)) (fifth machine)))

(define (DFA input Sigma S s0 delta F)
    (NFA input Sigma S s0 (map-delta delta) F))

(define (execute-DFA machine input)
    (execute-NFA (DFA->NFA machine) input))

(provide (all-defined-out))


; (define test-input "aaaaaaaaaaaaaaaaaabaaab")
; (define test-Sigma '("a" "b"))
; (define test-S '(HAPPY SAD))
; (define test-s0 'SAD)
; (define test-Delta '(
;     (SAD "a" HAPPY) (HAPPY "a" HAPPY)
;     (SAD "b" SAD) (HAPPY "b" SAD)
; ))
; (define test-F '(HAPPY))

; (DFA2 test-input test-Sigma test-S test-s0 test-Delta test-F)

; (DFA2 "0100" '("1" "0") '(q0 q1) 'q0 '((q0 "0" q0) (q0 "1" q1) (q1 "0" q1) (q1 "1" q1)) '(q1))