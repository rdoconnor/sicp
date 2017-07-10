; Exercise 2.22
; Exploring failed attempts at making square-list (from 2.21) an iterative process

(define (square-list1 items)
	(define (iter things answer)
		(if (null? things)
			answer
			(iter (cdr things)
				  (cons (square (car things))
						answer))))
	(iter items '()))
	
; (square-list1 (list 1 2 3 4))
; returns:
; (16 9 4 1)
; This occurs because the cons statement for adding the latest squared element to the answer list prepends instead
; of appends to the list. This means the squares of later elements in the original list will end up before those
; elements in the answer list, resulting in a reverse of the expected answer.

(define (square-list2 items)
	(define (iter things answer)
		(if (null? things)
			answer
			(iter (cdr things)
				  (cons answer
						(square (car things))))))
	(iter items '()))
	
; (square-list1 (list 1 2 3 4))
; returns:
; ((((() . 1) . 4) . 9) . 16)
; The attempt at remedying the reversal of the first iterative attempt (see above) results in a hierarchical list. Instead of appending
; the latest squared element to the answer list, this procedure will cons the entire list with this latest square. For every new
; element in the original list, this procedure creates a pair whose first element is the original list and whose second element is
; the latest square.
; A rough box and pointer representation would look like:
;
; [.][.]----> [16]
;  |
;  ----->[.][.]----> [9]
;         |
;         -->[.][.] ----> [4]
;             |
;             -->[\][.] ----> [1]
;
; This is not a list as we would have expected