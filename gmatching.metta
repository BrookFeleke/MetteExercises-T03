(Parent Monica John)
(Parent Monica Pam)
(Parent Monica Adam)
(Parent Monica Jane)
(Parent Chandler John)
(Parent Chandler Pam)
(Parent Chandler Adam)
(Parent Chandler Jane)
(Sibling Adam Jane)
(Sibling Pam Adam )
(Sibling John Adam)
(Sibling John Jane)
(Sibling Pam John)
(Sibling Pam Jane)
(Sibling John Pam)
(Parent John Bob)
(Parent Pam Tim)
(Parent Pam Kim)
(Parent Adam Eve)
(Parent Jane Joey)
(Female Kim)
(Female Eve)
(Female Jane)
(Female Pam)
(Female Monica)
(Male John)
(Male Adam)
(Male Chandler)
(Male Joey)
(Male Tim)
(Male Bob)

(= (get_parents $x)
    (match &self (Parent $y $x) $y)
)
(= (get_sibling $x)
    (match &self (Sibling $x $z) $z)

)
 ;;;;;;;;;;; Get Parents of John
! (get_parents John)
 ;;; Mother of Pam
! (match &self (, (Parent $x Pam) (Female $x)) $x)
 ;;; Siblings of Pam
! (get_sibling Pam)
 ;; Uncles of TIM
! (match &self (,
        (Parent $x Tim)
        (Sibling $x $y)
        (Male $y)
    )
$y
)

 ; Nephews of John
! (match &self (,
        (Sibling John $x)
        (Parent $x $y)
        (Male $y)
    )
$y
)
 ;; Predecessors of BOB
(= (parent $x $y) (match &self (Parent $x $y) $x))
(= (predecessor $x $z) (parent $x $z))
(= (predecessor $x $z) (predecessor $x (parent $y $z)))
! (predecessor $x Bob)