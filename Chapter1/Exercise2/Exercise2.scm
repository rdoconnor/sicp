; Exercise 1.2
; Translate a mathematical expression into Scheme to practice prefix notation

; (5 + 4 + (2 - (3 - (6 + 4/5)))) / (3 (6 - 2)(2 - 7))

(define answer (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
				  (* 3 (- 6 2) (- 2 7))))
				  
; -37 / 150