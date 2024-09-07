 ; Type definitions for List
 ; Test list  ---- (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil))))))
(: Nil (List $t))
(: list (-> $t (List $t) (List $t)))
(: head (->  (List $t) $t))
(= (head (list $head $tail)) $head)
! (head (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))
 ; TAIL FUNCION
(: tail (->  (List $t) (List $t))) ; Type Definition
(= (tail (list $head $tail)) $tail)
! (tail (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))
 ; Length
(: length (-> (List $t) Number)) ; Type definition
(= (length (list $head $tail))
    (if (== $tail Nil)
        1
        (+ 1 (length $tail))
    )
)
! (length (list 6 (list 5 (list 4 (list 3 (list 2 (list 1 Nil)))))))
(: pop (->  (List $t) $t))
(: is-member (-> $t (List $t) Bool))
(: remove-element (->  (List $t) (List $t)))
(: remove-duplicate (->  (List $t) (List $t)))
(: (: map (-> (-> $t $t) Expression Expression)))
(: min (->  (List $t) $t))
(: max (->  (List $t) $t))
(: push (->  (List $t) (List $t)))
 ;TODO:sort, reverse and maybe foldr foldl and stuff