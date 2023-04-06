#lang racket 

(define (dbg v label)
    (displayln label)
    (displayln v)
    (displayln "")
    v)

(define (find-delta-tuple-char delta curr-state input)
    (findf
        (lambda (d) (and (equal? (car d) curr-state) (equal? (cadr d) input)))
        delta))

(define (get-char-targets delta curr-state input)
    (caddr (find-delta-tuple-char delta curr-state input)))

(define (get-epsilon-default lookup)
    (cond
        ((eq? lookup #f) '())
        (else (caddr lookup))))

(define (get-epsilon-targets delta curr-state)
    (get-epsilon-default
        (find-delta-tuple-char delta curr-state "")))

(define (finalstate? state F)
    (cond
        ((eq? (index-of F state) #f) #f)
        (else #t)))


(define (map-nfas input Sigma Q transition-states delta F)
    [findf
        {lambda (state) [NFA input Sigma Q state delta F]}
        transition-states])

(define (check-nfa-list input Sigma Q transition-states delta F)
    (not (eq? (map-nfas input Sigma Q transition-states delta F) #f)))

(define (check-base-case Sigma Q q0 delta F)
    (cond
        [(finalstate? q0 F) #t]
        [else (check-nfa-list "" Sigma Q (get-epsilon-targets delta q0) delta F)]))

(define (check-recursive-case input Sigma Q q0 delta F)
    (cond
        [{check-nfa-list (substring input 1) Sigma Q (get-char-targets delta q0 (substring input 0 1)) delta F} #t]
        [{check-nfa-list input Sigma Q (get-epsilon-targets delta q0) delta F} #t]
        [else #f]))


(define (NFA input Sigma Q q0 delta F)
    (cond
        [(= (string-length input) 0) (check-base-case Sigma Q q0 delta F)]
        (else (check-recursive-case input Sigma Q q0 delta F))))


(define (execute-NFA machine input)
    (NFA input (first machine) (second machine) (third machine) (fourth machine) (fifth machine)))

; (define test-input "ab")
; (define test-Sigma '("a" "b"))
; (define test-Q '(S0 S1 S2 S3 S4 S5 S6))
; (define test-q0 'S0)
; (define test-Delta '(
;     (S0 "a" (NA))    (S0 "b" (NA)) (S0 "" (S1 S2))
;     (S1 "a" (NA))    (S1 "b" (NA))
;     (S2 "a" (S3))    (S2 "b" (NA))
;     (S3 "a" (S3 S4)) (S3 "b" (NA))
;     (S4 "a" (NA))    (S4 "b" (S5))
;     (S5 "a" (NA))    (S5 "b" (NA)) (S5 "" (S6))
;     (S6 "a" (NA))    (S6 "b" (NA))
;     (NA "a" (NA))    (NA "b" (NA))
; ))
; (define test-F '(S1 S3 S6))


(provide (all-defined-out))

; (define (expect val bool)
;     (display val)
;     (display " ")
;     (displayln bool))

; (define (run-tests)
;     (expect (NFA "" test-Sigma test-Q test-q0 test-Delta test-F) #t)
;     (expect (NFA "a" test-Sigma test-Q test-q0 test-Delta test-F) #t)
;     (expect (NFA "aa" test-Sigma test-Q test-q0 test-Delta test-F) #t)
;     (expect (NFA "aaa" test-Sigma test-Q test-q0 test-Delta test-F) #t)
;     (expect (NFA "aaaa" test-Sigma test-Q test-q0 test-Delta test-F) #t)
;     (expect (NFA "aaaaa" test-Sigma test-Q test-q0 test-Delta test-F) #t)
;     (expect (NFA "b" test-Sigma test-Q test-q0 test-Delta test-F) #f)
;     (expect (NFA "ab" test-Sigma test-Q test-q0 test-Delta test-F) #f)
;     (expect (NFA "aab" test-Sigma test-Q test-q0 test-Delta test-F) #t)
;     (expect (NFA "aaab" test-Sigma test-Q test-q0 test-Delta test-F) #t)
;     (expect (NFA "ba" test-Sigma test-Q test-q0 test-Delta test-F) #f)
;     (expect (NFA "aba" test-Sigma test-Q test-q0 test-Delta test-F) #f)
;     (expect (NFA "aaba" test-Sigma test-Q test-q0 test-Delta test-F) #f)
;     (expect (NFA "aaaba" test-Sigma test-Q test-q0 test-Delta test-F) #f)
;     (expect (NFA "aabb" test-Sigma test-Q test-q0 test-Delta test-F) #f)
;     (expect (NFA "aaabb" test-Sigma test-Q test-q0 test-Delta test-F) #f)
;     (expect (NFA "aaaabb" test-Sigma test-Q test-q0 test-Delta test-F) #f))


; (module+ main (run-tests))


; (NFA "0100" '("1" "0") '(q0 q1) 'q0 '((q0 "0" q0) (q0 "1" q1) (q1 "0" q1) (q1 "1" q1)) '(q1))
