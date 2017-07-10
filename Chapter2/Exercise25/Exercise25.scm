; Exercise 2.25
; Using cars and cdrs to extract specific elements

; Given a list, extract the number 7

; Part I
; (1 3 (5 7) 9)
(define part1 (list 1 3 (list 5 7) 9))
(car (cdr (car (cdr (cdr part1))))) ; returns 7

; Part II
; ((7))
(define part2 (list (list 7)))
(car (car part2)) ; returns 7

; Part III
; (1 (2 (3 (4 (5 (6 7))))))
(define part3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr part3)))))))))))) ; returns 7