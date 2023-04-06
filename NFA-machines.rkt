#lang racket

(define NFA-epsilon-a-or-b
    (list
        '("a" "b" "c")                                  ; Sigma
        '(S0 A1 A2 F0)                                  ; States
        'S0                                             ; Start state
        '(
            (S0 "a" (NA)) (S0 "b" (NA)) (S0 "c" (NA))
            (S0 "" (A1 A2))
            
            (A1 "a" (F0)) (A1 "b" (NA)) (A1 "c" (NA))
            (A2 "a" (NA)) (A2 "b" (F0)) (A2 "c" (NA))

            (F0 "a" (NA)) (F0 "b" (NA)) (F0 "c" (NA))
            
            (NA "a" (NA)) (NA "b" (NA)) (NA "c" (NA)))  ; Transitions
        '(F0)))                                         ; Final states

(define NFA-epsilon-chain-1-a-opt
    (list
        '("a")              ; Sigma
        '(S0 M0 NA)         ; States
        'S0                 ; Start state
        '(
            (S0 "a" (M0))
            (S0 "" (M0))

            (M0 "a" (NA))
            (M0 "" (NA))

            (NA "a" (NA)))  ; Transitions
        '(M0)))             ; Final states

(define NFA-multi-transition-ba-or-bb
    (list
        '("a" "b")                          ; Sigma
        '(S0 A0 B0 F0 NA)                   ; States
        'S0                                 ; Start state
        '(
            (S0 "a" (NA)) (S0 "b" (A0 B0))
            
            (A0 "a" (F0)) (A0 "b" (NA))
            (B0 "a" (NA)) (B0 "b" (F0))

            (F0 "a" (NA)) (F0 "b" (NA))

            (NA "a" (NA)) (NA "b" (NA)))    ; Transitions
        '(F0)))                             ; Final states

(define NFA-all-but-one-abcd
    (list
        '("a" "b" "c" "d")                                  ; Sigma
        '(S0 A0 B0 C0 D0 NA)                                ; States
        'S0                                                 ; Start state
        '(
            (S0 "a" (NA)) (S0 "b" (NA))
            (S0 "c" (NA)) (S0 "d" (NA))
            (S0 "" (A0 B0 C0 D0))

            (A0 "b" (A0)) (A0 "c" (A0)) (A0 "d" (A0))
            (A0 "a" (NA))

            (B0 "a" (B0)) (B0 "c" (B0)) (B0 "d" (B0))
            (B0 "b" (NA))

            (C0 "a" (C0)) (C0 "b" (C0)) (C0 "d" (C0))
            (C0 "c" (NA))

            (D0 "a" (D0)) (D0 "b" (D0)) (D0 "c" (D0))
            (D0 "d" (NA))

            (A0 "a" (NA))
            (A0 "b" (A0)) (A0 "c" (A0)) (A0 "d" (A0))

            (NA "a" (NA)) (NA "b" (NA))
            (NA "c" (NA)) (NA "d" (NA)))                    ; Transitions
        '(A0 B0 C0 D0)))                                    ; Final states

(provide (all-defined-out))
