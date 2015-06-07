; Subistitution Rule
; ==================
; To evaluate an application
; Evaluate the operator to get procedure
; Evaluate the operands to get arguments
; Apply the procedure to the arguments
;  Copy the body of the procedure.
;    substituting the arguments supplied for
;    the formal parameters of the procedure of the procedure
;  Evaluate the resulting new body

(define (SQ x)
	(* x x))

(define (Sos x y)
	(+ (Sq x) (Sq y)))
	
(Sos 3 4)
(+ (Sq 3) (Sq 4))
(+ (Sq 3) (* 4 4))
(+ (Sq 3) 16)
(+ (* 3 3) 16)
(+ 9 16)
25

;;;;

(define Square (lambda (x) (* x x)))
(define Average (lambda (x y) (/ (+ x y) 2))) 
(Average 3 (Square 5))
(Average 3 (* 5 5))
(Average 3 25)
(/ (+ 3 25) 2)
(/ 28 2)
14

;(IF <Predicate> <Consequent> <Alternative>)
; Used to control the order of evaluation.
; To evaluate an if expression
; 	Evaluate the predicate expression
;			If it yields TRUE
;				evaluate the consequent expression
;			Otherwise
;				evaluate the alternative expression 

; http://stackoverflow.com/questions/7695003/sicp-video-lecture-2
;; In Lecture 2 Mr.Sussman shows this example

(define (+ x y)
  (if (= x 0)
      y
      (+ (-1+ x) (1+ y))))
      
;; But when i try to evaluate it i get this result
; - DrScheme: -1+: this function is not defined
; - racket : reference to undefined identifier: -1+
; So here -1+ and 1+ are none-standard names, he just use them to explain this example
; we can write it like this instead

(define (add x y)
  (if (= x 0)
      y
      (+ (- x 1) (+ y 1))))
      
; Or like this as Chris suggested to
; - Use add1 instead of 1+
; - Use sub1 instead of -1+ or 1-

(define (add x y)
  (if (= x 0)
      y
      (+ (sub1 x) (add1 1))))
      
;; The substitution model fo it
(add 3 4)
(add 2 5)
(add 1 6)
(add 0 7)
7
(if (= 3 0) 4 (+ (- 3 1) (+ 4 1)))
(+ (- 3 1) (+ 4 1))
(+ (- 3 1) 5)
(+ 2 5)
(if (= 2 0) 5 (+ (- 2 1) (+ 5 1)))
(+ (- 2 1) (+ 5 1))
(+ (- 2 1) 6)
(+ 1 6)
(if (= 1 0) 6 (+ (- 1 1) (+ 6 1)))
(+ (- 1 1) (+ 6 1))
(+ (- 1 1) 7)
(+ 0 7)
(if (= 0 0) 7 (+ (- 0 1) (+ 7 1)))
7

;; factorial 
(define fact
  (lambda (n)
    (if (= n 1)
        1
        (* n (fact (- n 1))))))
(fact 3)
(if (= 3 1) 1 (* 3 (fact (- 3 1))))
(if #f 1 (* 3 (fact (- 3 1))))
(* 3 (fact 2))
(* 3 (if (= 2 1) 1 (* 2 (fact (- 2 1)))))
(* 3 (if #f 1 (* 2 (fact 1))))
(* 3 (* 2 (fact 1)))
(* 3 (* 2 (if (= 1 1) 1 (* 1 (fact (- 1 1))))))
(* 3 (* 2 1))
(* 3 2)
6
 
(define (factorial n)
  (fact-iter 1 1 n))
(define (fact-iter result counter max-value)
  (if (> counter max-value)
      result
      (fact-iter (* counter result)
                 (+ counter 1)
                 max-value)))
(factorial 6)

(if (> 1 6) 1 (fact-iter (* 1 1) (+ 1 1) 6))
(fact-iter 1 2 6)
(if (> 2 6) 1 (fact (* 2 1) (+ 2 1) 6))
(fact-iter 2 3 6)
(if (> 3 6) 2 (fact (* 3 2) (+ 3 1) 6))
(fact-iter 6 4 6)
(if (> 4 6) 6 (fact-iter (* 4 6) (+ 4 1) 6))
(fact-iter 24 5 6)
(if (> 5 6) 24 (fact-iter (* 5 24) (+ 5 1) 6))
(fact-iter 120 6 6)
(if (> 6 6) 120 (fact-iter (* 120 6) (+ 6 1) 6))
(fact-iter 720 7 6)
(if (> 7 6) 720 (fact-iter (* 7 720) (+ 7 1) 6))
720
                          

; Ex 1.9
; This is a recursive process
(define (add a b)
  (if (= a 0)
      b
      (+ 1 (add (- a 1) b))))
(add 4 5)
(if (= 4 0) 5 (+ 1 (add (- 4 1) 5)))
(+ 1 (add 3 5))
(+ 1 (if (= 3 0) 5 (+ 1 (add (- 3 1) 5))))
(+ 1 (+ 1 (add 2 5)))
(+ 1 (+ 1 (if (= 2 0) 5 (+ 1 (add (- 2 1) 5)))))
(+ 1 (+ 1 (+ 1 (add 1 5))))
(+ 1 (+ 1 (+ 1 (if (= 1 0) 5 (+ 1 (add (- 1 1) 5))))))
(+ 1 (+ 1 (+ 1 (+ 1 (add 0 5)))))
(+ 1 (+ 1 (+ 1 (+ 1 (if (= 0 0) 5 (+ 1 (add (- 0 1) 5)))))))
(+ 1 (+ 1 (+ 1 (+ 1 5))))
(+ 1 (+ 1 (+ 1 6)))
(+ 1 (+ 1 7))
(+ 1 8)
9

; This is an iterative process
(define (add a b)
  (if (= a 0)
      b
      (+ (- a 1) (+ b 1))))
(add 4 5)
(if (= 4 0) 5 (add (- 4 1) (+ 5 1)))
(add 3 6)
(if (= 3 0) 6 (add (- 3 1) (+ 6 1)))
(add 2 7)
(if (= 2 0) 7 (add (- 2 1) (+ 7 1)))
(add 1 8)
(if (= 1 0) 8 (add (- 1 1) (+ 8 1)))
(add 0 9)
(if (= 0 0) 9 (add (- 0 1) (+ 9 1)))
9

; Ex 1.9
(define (A x y)
	(cond ((= y 0) 0)
				((= x 0) (* 2 y))
				((= y 1) 2)
				(else (A (- x 1)
								 (A x (- y 1))))))

(A 1 10)
(A 0 (A 1 9))
(A 0 (A 0 (A 1 8)))
(A 0 (A 0 (A 0 (A 1 7))))
(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 32)))))))
(A 0 (A 0 (A 0 (A 0 64))))))
(A 0 (A 0 (A 0 128)))))
(A 0 (A 0 265))))
(A 0 512)
1024

; > (A 2 4)
; => 65536
; > (A 3 3)
; => 65536

Tree Recursion
==============
(define (fib n)
	(cond ((= n 0) 0)
				((= n 1) 1)
				(else (+ (fib (- n 1))
								 (fib (- n 2))))))