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