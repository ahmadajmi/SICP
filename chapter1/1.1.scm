; 1.1 The Elements of Programming

; QUOTES ::
;
; Thus, programs must be written for people to read, and only incidentally for machines to execute.

; Primitive expression
; => Represent the simplest entities the language is concerned with.

; Means of Combination
; => By which compound elements are built from simpler ones.

; Means of Abstractions
; => by which compound elements can be named and manipulated as units, as they were primitives.


; Primitive expression
; --------------------

20
; => 20

+
; => #<procedure:+>

; Prefix Notation
; ---------------

; The convention of placing the operator to the left of the operands.
; It can accommodate procedures that may take an arbitrary number of arguments.
; It extends in a straight forward way to allow combinations to be nested

(+ 21 35 12 7)

; Compound expressions
; --------------------

(+ 20 6)
(+ (* 3 5) (- 10 6))

; Pretty Printing
; Is a formatting convention that aims to align the code in a way that makes it more readable.

; read-eval-print loop (REPL)
; - The interpreter first read the expression from the terminal
; - Then it evaluate the expression
; - The interpreter then print the evaluation to the screen

; Evaluating compound expressions
; -------------------------------
; 1- Recursively evaluate each of the subexpressions (operands)
; 2- Apply the operator to the values given by the evaluation of the operands.

(+ (* 2 5) (/ 6 3) )
; => 12


; Naming and the Environment
; --------------------------

; We name things with (define)
; Define is the simplest mean of abstraction
; The interpreter associate the value 2 with with the name size

(define size 2)

size
; => 2

(* 5 size)
; => 10

(define pi 3.14159)
(define radius 10)
(* pi (* radius radius))
; => 314.159

(define circumference (* 2 pi radius))
circumference
; => 62.8318

; Procedure definition && Compound Procedures
; -------------------------------------------

; To square something, multiply it by itself
(define (square x) (* x x))

;; The above square could be written as
(define (square x)
  (* x x))

;; or
(define square
  (λ (x)
    (* x x)))

(define (sum-of-squares a b)
  (+ (Square a) (Square b)))

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

(define (average x y) (/ (+ x y) 2))

; The Substitution Model for Procedure Application
; ------------------------------------------------
; To apply a compound procedure
; 1- Evaluate the body of the procedure with each formal parameter replaced
; by the corresponding argument

(f 5)
(sum-of-squares (+ a 1) (* a 2))
; replace the formal parameter a by the argument 5
(sum-of-squares (+ 5 1) (* 5 2))
; we have one operator and two operands
; (+ 5 1) => 6 , (+ 2 5) => 10
; Aplly sum-of-squares to 6 and 10
; Subistitute the formal parameters x, y in the body of sum-of-squares
(+ (square 6) (square 10))
(+ (* 6 6) (* 10 10))
(+ 36 100)
136

; Applicative order versus normal order
; -------------------------------------
; Applicative order => The interpreter first evaluates the arguments before applying the procedure.
; Normal order      => The interpreter would not evaluate the arguments until their values were needed,
; so the arguments are evaluated after applying the procedure.

; Conditional expressions and predicates
; --------------------------------------
(define (abs-cond x)
  (cond ((< x 0) (- x))
        ((= x 0) 0)
        ((> x 0) x)))

(define (abs-cond-else x)
  (cond ((< x 0) (- x))
        (else x)))

(define (abs-if x)
  (if (< x 0)
      (- x)
      x))

; Example: Square Roots by Newton's Method
; ----------------------------------------
(define (average x y)
  (/ (+ x  y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt1 x)
  (sqrt-iter 1.0 x))

; Internal definitions and block structure
; ----------------------------------------

(define (sqrt2 x)
  (define (square x)
    (* x x))
  (define (average x y)
    (/ (+ x y) 2))
  (define (good? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))

; Lexical Scoping => The variable that defined in the top procedure is defined in all the internal procedures
; ---------------
(define (sqrt3 x)
  (define (square x)
    (* x x))
  (define (average x y)
    (/ (+ x y) 2))
  (define (good? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))

(define (sqrt4 x)

;;; http://pages.cs.brandeis.edu/~mairson/Courses/cs21b/Lectures/Cursing.pdf
;;; http://pages.cs.brandeis.edu/~cs21b/

(define (sqrt4 x)
  (define (sqrt-iter guess)

    (define (good-enough?)
      (< (abs (- (square guess) x))
         0.001))

    (define (improve)
    (average guess (/ x guess)))

    (if (good-enough?)
        guess
        (sqrt-iter (improve))) )
  (sqrt-iter 1.0))
(sqrt4 4)

(define (spam x)
  (define (square)
    (* x x))
  (+ (square) (square)))
(spam 5)
; => 50  => Booom

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Ex 1.2
; ------

(/
 (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
 (* 3 (- 6 2) (- 2 7)))

; Ex 1.3
; ------
; https://github.com/ajmi/sicp-1/blob/master/hw/ch1/1.3.scm

(define square
  (lambda (x)
    (* x x)))

(define sum-of-squares
  (lambda (x y) (+ (square x) (square y))))

(define sos-big-two
  (lambda (a b c)
    (cond ((and (< a b) (< a c)) (sum-of-squares b c))
          ((and (< b a) (< b c)) (sum-of-squares a c))
          ((and (< c a) (< c b)) (sum-of-squares a b))) ) )

; Another brilliant solution from IAN: SICPBBC Group
; https://github.com/reborg/sicpbbc/blob/master/sicp-scheme/1.3-procedure-three-args-test.scm#L23

(define (sq a)
   (* a a))

(define (min2 a b)
   (if (< a b) a b))

(define (min3 a b c)
   (if (< a (min2 b c))))

(define (sq2largest a b c)
   (- (+ (sq a) (sq b) (sq c)) (min3 a b c)))

; Ex 1.4
; ------

(define (a-plus-abs-b a b)
((if (> b 0) + -) a b))
;; The trick here is that the if statement will be evaluated and return + or - procedures and the result will be
;; a compound expression like
(+ a b) ; IF if return $t and in this case +
; or
(- a b) ; If returns #f and in this case -


; Ex 1.5
; ------
; With applicative-order evaluation the procedure evaluates every argument first before applying the procedure
; so in this example when calling test procedure
(test 0 (p))
; 0 is evaluated and when it comes to evaluate (p) it will call itself and never stops
(test 0 (p))
(test 0 (p))
(test 0 (p))
;; and so on

; But in normal order evaluation the procedure arguments evaluated after applying the procedure and just if needed
; so in the example
(test 0 (p))
(if (= 0 0) 0 (p))
(if #t 0 (p))
0
; if evaluated to 0 and then return 0 because x = 0, but y => () will never be called.

;	Guess Quotient Average
; 1 (2/1) = 2 ((2 + 1)/2) = 1.5
;	1.5 (2/1.5) = 1.3333 ((1.3333 + 1.5)/2) = 1.4167
;	1.4167 (2/1.4167) = 1.4118 ((1.4167 + 1.4118)/2) = 1.4142
;	1.4142 ...
;	...


;; Ex 1.6
;; The new if uses applicative order evaluation which evaluates all th operands and then applies the operators,
;; so here the sqrt-iter will call itself forever even the guess is good enough.


;; Ex 1.7
;; For small numbers, imagine we want to get the square root for a number less than 0.001 it will be not efficient.

;; For the large numbers, it will be hard for machines to represent small differences between large numbers

(define (square x) (* x x))
    (define (average x y)
      (/ (+ x y) 2))

(define (sqrtt x)
  (define (sqrt-iter guess)
    (define (good-enough?)
      (< (abs (- (improve) guess)) 0.001))
    (define (improve)
      (average guess (/ x guess)))
    (if (good-enough?)
      guess
      (sqrt-iter (improve))) )
  (sqrt-iter 1.0))
(sqrtt 64)

;; Ex 1.8
;========
(define (square x) (* x x))
    (define (average x y)
      (/ (+ x y) 2))

(define (cubrt x)
  (define (cubrt-iter guess)
    (define (good-enough?)
      (< (abs (- (improve) guess)) 0.001))
    (define (improve)
      (/ (+ (/ x (square guess)) (* 2 guess)) 3))
    (if (good-enough?)
      guess
      (cubrt-iter (improve))) )
  (cubrt-iter 1.0))
(cubrt 64)
; => 4.000017449510739
