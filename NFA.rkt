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


(provide (all-defined-out))