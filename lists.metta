 ; Test list  ---- (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil))))))
(: Nil (List $t))
(: list (-> $t (List $t) (List $t)))
(: head (->  (List $t) $t))
(= (head (list $head $tail)) $head)
(: tail (->  (List $t) (List $t))) ; Type Definition
(= (tail (list $head $tail)) $tail)

 ;;;;;;;;;;; Length
(: length (-> (List $t) Number)) ; Type definition
(= (length (list $head $tail))
    (if (== $tail Nil)
        1
        (+ 1 (length $tail))
    )
)
! (length (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil))))))) ; [6]

 ;;;;;;;;;;; Pop List

(: pop (->  (List $t) $t))
(= (pop (list $head $tail))
    (if (== $tail Nil)
        $head
        (pop $tail)
    )
)
! (pop (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))

 ;;;;;;;;;;; Is Member List

(: is-member (-> $t (List $t) Bool))
(= (is-member $n (list $head $tail))
    (case ($head $tail)
        ( ( ($_ Nil) (== $head $n))
            ( ($head $tail)
                (if (== $n $head)
                    True
                    (is-member $n $tail)
                )
        ))
)
)
! (is-member 45 (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))

 ;;;;;;;;;;; Remove Element

(: remove-element (->  $t (List $t) (List $t)))
(= (remove-element $rm (list $head $tail))
    (if (== $rm $head)
        $tail
        (list $head (remove-element $rm $tail))
    )
)
 ; ! (remove-element 3 (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))

 ;;;;;;;;;;; Min FUNCTION

(: min (-> $t (List $t) $t))
(= (min $t (list $head $tail))
    (case ($t $tail)
        (
            ( ($t Nil) $t)
            ( ($t $tail)
                (if (< $head $t)
                    (min $head $tail)
                    (min $t $tail)
                ))
    )
)
)
! (min (head (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil))))))) (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))
 ;; OUTPUT :

 ;;;;;;;;;;; Max FUNCTION

(: max (-> $t (List $t) $t))
(= (max $t (list $head $tail))
    (case ($t $tail)
        (
            ( ($t Nil) $t)
            ( ($t $tail)
                (if (> $head $t)
                    (max $head $tail)
                    (max $t $tail)
                ))
    )
)
)
! (max (head (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil))))))) (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))

 ;;;;;;;;;;; Append List

(: append (->  $t (List $t) (List $t)))
(= (append $t (list $head $tail))
    ( if (== $tail Nil)
        (list $head (list $t Nil))
        (list $head (append $t $tail)))
)
! (append 3 (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))

 ;;;;;;;;;;; Map

(: times-two (-> $t $t))
(= (times-two $t) (* 2 $t))
(: (: map (-> (-> $t $t) Expression Expression)))
(= (map $f (list $head $tail))
    (if (== $tail Nil)
        (list ($f $head) Nil)
        (list ($f $head) (map $f $tail))
    )
)
 ; ! (map times-two (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))

 ;;;;;;;;;;; Reverse List

(: reverse (-> (List $t) (List $t)))
(= (reverse (list $head $tail))
    (if (== $tail Nil)
        (list $head Nil)
        (append $head (reverse $tail))
    )
)
! (reverse (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))

 ;;;;;;;;;;; Remove duplicate

(: remove-duplicate (->  (List $t) (List $t)))
(= (remove-duplicate (list $head $tail))
    (if (== $tail Nil)
        (list $head Nil)
        (if (is-member $head $tail)
            (remove-duplicate $tail)
            (list $head (remove-duplicate $tail))
        )
)
)
! (remove-duplicate (list 6 (list 5 (list 4 (list 3 ( list 5 (list 2 (list 5 (list 1 Nil)))))))))

 ;TODO:sort and maybe foldr foldl and stuff
