; Exercise 2.53
; Symbolic data

; (list 'a 'b 'c)
; returns:
; (a b c)

; (list (list 'george))
; returns:
; ((george))

; (cdr '((x1 x2) (y1 y2)))
; returns:
; ((y1 y2))

; (cadr '((x1 x2) (y1 y2)))
; returns:
; (y1)

; (pair? (car '(a short list)))
; returns:
; #f

; (memq 'red '((red shoes) (blue socks)))
; #f

; (memq 'red '(red shoes blue socks))
; (red shoes blue socks)