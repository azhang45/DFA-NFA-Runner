#lang racket

(define DFA-garbage-machine
    (list
        '("a")         ; Sigma
        '(NA)          ; States
        'NA            ; Start state
        '((NA "a" NA)) ; Transitions
        '()))          ; Final states

(define DFA-touchy-garbage-machine
    (list
        '("a")           ; Sigma
        '(S0 NA)         ; States
        'S0              ; Start state
        '(
            (S0 "a" NA)
            (S0 "a" NA)) ; Transitions
        '(S0)))          ; Final states

(define DFA-do-whatever-the-heck-you-want-machine
    (list
        '("a")         ; Sigma
        '(S0)          ; States
        'S0            ; Start state
        '((S0 "a" S0)) ; Transitions
        '(S0)))        ; Final states

(define DFA-a-bad-b-good-machine
    (list
        '("a" "b")                 ; Sigma
        '(S0 A B NA)               ; States
        'S0                        ; Start state
        '(
            (S0 "a" A) (S0 "b" B)
            (A "a" NA) (A "b" NA)
            (B "a" NA) (B "b" NA)) ; Transitions
        '(B)))                     ; Final states

(define DFA-a-social-distancing-machine
    (list
        '("a" "b")                   ; Sigma
        '(S0 S1 NA)                  ; States
        'S0                          ; Start state
        '(
            (S0 "a" S1) (S0 "b" NA)
            (S1 "a" NA) (S1 "b" S0)
            (NA "a" NA) (NA "b" NA)) ; Transitions
        '(S0 S1)))                   ; Final states

(define DFA-the-social-distancing-machine
    (list
        '("a" "b")                   ; Sigma
        '(S0 A B NA)                 ; States
        'S0                          ; Start state
        '(
            (S0 "a"  A) (S0 "b"  B)
            ( A "a" NA) ( A "b"  B)
            ( B "a"  A) ( B "b" NA)
            (NA "a" NA) (NA "b" NA))   ; Transitions
        '(S0 A B)))                  ; Final states


(define test-input "aaaaaaaaaaaaaaaaaabaaab")
(define test-Sigma '("a" "b"))
(define test-S '(HAPPY SAD))
(define test-s0 'SAD)
(define test-Delta '(
    (SAD "a" HAPPY) (HAPPY "a" HAPPY)
    (SAD "b" SAD) (HAPPY "b" SAD)
))
(define test-F '(HAPPY))

(provide (all-defined-out))
