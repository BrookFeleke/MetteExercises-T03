(= (foldl $f $acc ()) $acc)
(= (foldl $f $acc (| $x $xs))
    (foldl $f ($f $acc $x) $xs))

 ; Test Cases
 ; (= (sum $a $b) (+ $a $b))
 ; !(foldl sum 0 (| 1 (| 2 (| 3 ()))))  ; => 6
 ; !(foldl sum 10 (| 1 (| 2 (| 3 ()))))  ; => 16
(= (sort ()) ())
(= (sort (| $x $xs))
    (place $x (sort $xs)))
(= (place $val ()) (| $val ())) ; placing the value in the right place[index]
(= (place $val (| $x $xs))
    (if (> $val $x)
        (| $x (place $val $xs))
        (| $val (| $x $xs))))

 ; Test Cases
! (sort (| 4 (| 2 (| 1 (| 5 (| 3 (| 6 (| 7 (| 8 (| 9 ())))))))))) ; => (| 1 (| 2 (| 3 (| 4 (| 5 (| 6 (| 7 (| 8 (| 9 ())))))))))
! (sort (| 9 (| 8 (| 7 (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 ())))))))))) ; => (| 1 (| 2 (| 3 (| 4 (| 5 (| 6 (| 7 (| 8 (| 9 ())))))))))