; Exercise 2.55
; Unexpected output from double quotes


; (car ''abracadabra)
; returns
; '

; This is due to the quote (i.e. ') being syntactic sugar for a procedure quote
; For example, 'x is the same as (quote x)
;
; So (car ''abracadabra) will be rewritten as (car (quote (quote abracadabra)))