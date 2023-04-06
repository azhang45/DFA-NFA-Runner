#lang racket

(define DFA-non-accept
    (list
        '("a")         ; Sigma
        '(NA)          ; States
        'NA            ; Start state
        '((NA "a" NA)) ; Transitions
        '()))          ; Final states

(define DFA-accept-empty
    (list
        '("a")           ; Sigma
        '(S0 NA)         ; States
        'S0              ; Start state
        '(
            (S0 "a" NA)
            (NA "a" NA)) ; Transitions
        '(S0)))          ; Final states

(define DFA-always-accept
    (list
        '("a")         ; Sigma
        '(S0)          ; States
        'S0            ; Start state
        '((S0 "a" S0)) ; Transitions
        '(S0)))        ; Final states

(define DFA-accept-1-char
    (list
        '("a")         ; Sigma
        '(S0 S1 NA)    ; States
        'S0            ; Start state
        '(
            (S0 "a" S1)
            (S1 "a" NA)
            (NA "a" NA)) ; Transitions
        '(S1)))        ; Final states

(define DFA-accept-1-or-more-Bs-no-As
    (list
        '("a" "b")                 ; Sigma
        '(S0 B NA)               ; States
        'S0                        ; Start state
        '(
            (S0 "a" NA) (S0 "b"  B)
            (B  "a" NA) (B  "b"  B)
            (NA "a" NA) (NA "b" NA)) ; Transitions
        '(B)))                     ; Final states

(define DFA-accept-alternating
    (list
        '("a" "b")                   ; Sigma
        '(S0 A B NA)                 ; States
        'S0                          ; Start state
        '(
            (S0 "a"  A) (S0 "b"  B)
            ( A "a" NA) ( A "b"  B)
            ( B "a"  A) ( B "b" NA)
            (NA "a" NA) (NA "b" NA)) ; Transitions
        '(S0 A B)))                  ; Final states

(provide (all-defined-out))
