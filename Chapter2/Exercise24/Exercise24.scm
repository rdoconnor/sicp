; Exercise 2.24
; Exploring basic hierarchical data structure

; (list 1 (list 2 (list 3 4)))
; returns
; (1 (2 (3 4)))
;
; Tree interpretation:
;
;      /\
;     /  \
;    1    \
;         /\
;        /  \
;       2    \
;            /\
;           /  \
;          3    4
;
; Box-and-pointer structure:
;
; [.][.] ---> [.][\]
;  |           |
;  ---> 1      ---> [.][.] ---> [.][\]
;                    |           |
;                    ---> 2      ---> [.][.] ---> [.][\]
;                                      |           |
;                                      ---> 3      ---> 4