; Exercise 1.5
; Describe the difference in behavior when the test procedure is run with an applicative-order interpreter vs a normal-order inerpreter.

(define (p) (p))

(define (test x y)
	(if (= x 0)
		0
		y))

; (test 0 (p))		

; The key here is that a call to the procedure p will result in indefinite recursion. Applicative-order evaluation makes
; that call, so it will never return an answer. Normal-order evaluation doesn't, so it will return 0.

; In the applicative-order evaluation, the procedure call for test will recurse indefinitely and never return an answer.
; Applicative-order evaluation evaluates the arguments to the procedure test before they are "substituted" for the formal
; parameters in the function definition. In this way, the argument of (p) is evaluated and the applicative-order evaluation
; gets stuck in infinite recursion.

; With normal-order evaluation, the procedure call will result in the answer of 0
; Normal-order evaluation doesn't evaluate the operands until absolutely necessary. First it would expand the call to test
; by substituting formal parameters in the procedure definition with the arguments without evaluating those arguments. Then it
; would evaluate the argument associated with x (0 in this case) in order to evaluate the if statement. Since this expression (= x 0)
; evaluates to true, 0 is returned. There is no need to evaluate the argument associated with the parameter y, so the procedure p is
; never called and we avoid infinite recursion.