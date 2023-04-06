#lang racket

(require "NFA.rkt")
(require "DFA.rkt")
(require "DFA-machines.rkt")
(require "NFA-machines.rkt")
; (require colorize)

(define (print-result result expected)
    (cond
        [(eq? result expected)
            (display result)
            (displayln " SUCCEEDED")]
        [else
            (display result)
            (displayln " FAILED")]))

(define (DFA-test-case test-case-name machine machine-name input expected)
    (display "Test case [")
    (display test-case-name)
    (display "] with machine `")
    (display machine-name)
    (display "` input: \"")
    (display input)
    (display "\" (expects ")
    (display expected)
    (display ") ==> Got: ")
    (print-result (execute-DFA machine input) expected))


;
; DFA Tests:
;
(displayln "DFA Tests:")


(DFA-test-case "Empty" DFA-non-accept "DFA-non-accept" "" #f)
(DFA-test-case "Non-empty" DFA-non-accept "DFA-non-accept" "aaa" #f)


(DFA-test-case "Empty" DFA-always-accept "DFA-always-accept" "" #t)
(DFA-test-case "Non-empty" DFA-always-accept "DFA-always-accept" "aaa" #t)


(DFA-test-case "Empty" DFA-accept-empty "DFA-accept-empty" "" #t)
(DFA-test-case "Non-empty" DFA-accept-empty "DFA-accept-empty" "aaa" #f)

(DFA-test-case "Empty" DFA-accept-1-char "DFA-accept-1-char" "" #f)
(DFA-test-case "1 char" DFA-accept-1-char "DFA-accept-1-char" "a" #t)
(DFA-test-case "3 chars" DFA-accept-1-char "DFA-accept-1-char" "aaa" #f)


(DFA-test-case "Empty" DFA-accept-1-or-more-Bs-no-As "DFA-accept-1-or-more-Bs-no-As" "" #f)
(DFA-test-case "1 b" DFA-accept-1-or-more-Bs-no-As "DFA-accept-1-or-more-Bs-no-As" "b" #t)
(DFA-test-case "4 bs" DFA-accept-1-or-more-Bs-no-As "DFA-accept-1-or-more-Bs-no-As" "bbbb" #t)
(DFA-test-case "1 a" DFA-accept-1-or-more-Bs-no-As "DFA-accept-1-or-more-Bs-no-As" "a" #f)
(DFA-test-case "bs with a" DFA-accept-1-or-more-Bs-no-As "DFA-accept-1-or-more-Bs-no-As" "bbbabb" #f)


(DFA-test-case "Empty" DFA-accept-alternating "DFA-accept-alternating" "" #t)
(DFA-test-case "1 a" DFA-accept-alternating "DFA-accept-alternating" "a" #t)
(DFA-test-case "1 b" DFA-accept-alternating "DFA-accept-alternating" "b" #t)
(DFA-test-case "alternating start with a" DFA-accept-alternating "DFA-accept-alternating" "abababa" #t)
(DFA-test-case "alternating start with b" DFA-accept-alternating "DFA-accept-alternating" "bababab" #t)

(DFA-test-case "consecutive as" DFA-accept-alternating "DFA-accept-alternating" "babaab" #f)
(DFA-test-case "consecutive bs" DFA-accept-alternating "DFA-accept-alternating" "babbab" #f)

(displayln "\n")


;
; DFA->NFA Tests:
;

(define (print-DFA->NFA-result result expected)
    (cond
        [(equal? result expected)
            (displayln result)
            (displayln "SUCCEEDED")]
        [else
            (displayln result)
            (displayln "FAILED")]))

(define (DFA->NFA-test-case test-case-name dfa expected-nfa)
    (display "Test case [")
    (display test-case-name)
    (displayln "]")
    
    (displayln "DFA Machine:")
    (displayln dfa)

    (displayln "Expected output (NFA):")
    (displayln expected-nfa)

    (displayln "Actual output (NFA):")
    (print-DFA->NFA-result (DFA->NFA dfa) expected-nfa)
    (displayln ""))

(displayln "DFA->NFA Tests:")

(DFA->NFA-test-case
    "always accept machine"
    DFA-always-accept
    (list '("a") '(S0) 'S0 '((S0 "a" (S0))) '(S0)))

(DFA->NFA-test-case
    "never accept machine"
    DFA-non-accept
    (list '("a") '(NA) 'NA '((NA "a" (NA))) '()))

;
; NFA Tests:
;
(displayln "NFA Tests:")


(define (NFA-test-case test-case-name machine machine-name input expected)
    (display "Test case [")
    (display test-case-name)
    (display "] with machine `")
    (display machine-name)
    (display "` input: \"")
    (display input)
    (display "\" (expects ")
    (display expected)
    (display ") ==> Got: ")
    (print-result (execute-NFA machine input) expected))

(NFA-test-case "Empty" NFA-epsilon-a-or-b "NFA-epsilon-a-or-b" "" #f)
(NFA-test-case "A" NFA-epsilon-a-or-b "NFA-epsilon-a-or-b" "a" #t)
(NFA-test-case "B" NFA-epsilon-a-or-b "NFA-epsilon-a-or-b" "b" #t)

(NFA-test-case "Empty" NFA-epsilon-chain-1-a-opt "NFA-epsilon-chain-1-a-opt" "" #t)
(NFA-test-case "one a" NFA-epsilon-chain-1-a-opt "NFA-epsilon-chain-1-a-opt" "a" #t)
(NFA-test-case "two as" NFA-epsilon-chain-1-a-opt "NFA-epsilon-chain-1-a-opt" "aa" #f)

(NFA-test-case "Empty" NFA-multi-transition-ba-or-bb "NFA-multi-transition-ba-or-bb" "" #f)
(NFA-test-case "A" NFA-multi-transition-ba-or-bb "NFA-multi-transition-ba-or-bb" "a" #f)
(NFA-test-case "B" NFA-multi-transition-ba-or-bb "NFA-multi-transition-ba-or-bb" "b" #f)
(NFA-test-case "AB" NFA-multi-transition-ba-or-bb "NFA-multi-transition-ba-or-bb" "ab" #f)
(NFA-test-case "BB" NFA-multi-transition-ba-or-bb "NFA-multi-transition-ba-or-bb" "bb" #t)
(NFA-test-case "BA" NFA-multi-transition-ba-or-bb "NFA-multi-transition-ba-or-bb" "ba" #t)
(NFA-test-case "BAB" NFA-multi-transition-ba-or-bb "NFA-multi-transition-ba-or-bb" "bab" #f)


(NFA-test-case "Empty" NFA-all-but-one-abcd "NFA-all-but-one-abcd" "" #t)
(NFA-test-case "A" NFA-all-but-one-abcd "NFA-all-but-one-abcd" "a" #t)
(NFA-test-case "AB" NFA-all-but-one-abcd "NFA-all-but-one-abcd" "ab" #t)
(NFA-test-case "ABC" NFA-all-but-one-abcd "NFA-all-but-one-abcd" "abc" #t)
(NFA-test-case "ABCD" NFA-all-but-one-abcd "NFA-all-but-one-abcd" "abcd" #f)
(NFA-test-case "Ds & Bs & As" NFA-all-but-one-abcd "NFA-all-but-one-abcd" "dbadbadbddbdbadbd" #t)
(NFA-test-case "Bs & Cs" NFA-all-but-one-abcd "NFA-all-but-one-abcd" "bcccbcbcbbbcbc" #t)
