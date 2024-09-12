 ; Define Nil as an empty list and | as a list constructor
(: Nil (List $t))
(: | (-> $t (List $t) (List $t)))

 ; Retrieve the head of a list
(: head (-> (List $t) $t))
(= (head (| $head $tail)) $head)

 ; Retrieve the tail of a list
(: tail (-> (List $t) (List $t))) ; Type Definition
(= (tail (| $head $tail)) $tail)

 ; Calculate the length of a list
(: length (-> (List $t) Number)) ; Type definition
(= (length (| $head $tail))
    (if (== $tail Nil)
        1
        (+ 1 (length $tail))
    )
)
! (length (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil))))))) ; [6]

 ; Pop the last element from a list
(: pop (-> (List $t) $t))
(= (pop (| $head $tail))
    (if (== $tail Nil)
        $head
        (pop $tail)
    )
)
! (pop (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil)))))))

 ; Check if an element is a member of the list
(: is-member (-> $t (List $t) Bool))
(= (is-member $n (| $head $tail))
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
! (is-member 2 (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil)))))))

 ; Remove all occurrences of an element from the list
(: remove-element (-> $t (List $t) (List $t)))
(= (remove-element $rm (| $head $tail))
    (if (== $rm $head)
        $tail
        (| $head (remove-element $rm $tail))
    )
)
! (remove-element 3 (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil)))))))

 ; Find the minimum element in a list based on a comparison function
(: min (-> $t (List $t) $t))
(= (min $t (| $head $tail))
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
! (min (head (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil))))))) (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil)))))))
 ;; OUTPUT :

 ; Find the maximum element in a list based on a comparison function
(: max (-> $t (List $t) $t))
(= (max $t (| $head $tail))
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
! (max (head (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil))))))) (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil)))))))

 ; Append an element to the end of a list
(: append (-> $t (List $t) (List $t)))
(= (append $t (| $head $tail))
    (if (== $tail Nil)
        (| $head (| $t Nil))
        (| $head (append $t $tail)))
)
! (append 3 (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil)))))))

 ; Apply a function to each element of the list (map)
(: times-two (-> $t $t))
(= (times-two $t) (* 2 $t))
(: (: map (-> (-> $t $t) Expression Expression)))
(= (map $f (| $head $tail))
    (if (== $tail Nil)
        (| ($f $head) Nil)
        (| ($f $head) (map $f $tail))
    )
)
 ; ! (map times-two (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil)))))))

 ; Reverse the order of elements in a list
(: reverse (-> (List $t) (List $t)))
(= (reverse (| $head $tail))
    (if (== $tail Nil)
        (| $head Nil)
        (append $head (reverse $tail))
    )
)
! (reverse (| 6 (| 5 (| 4 (| 3 (| 2 (| 1 Nil)))))))

 ; Remove duplicate elements from the list
(: remove-duplicate (-> (List $t) (List $t)))
(= (remove-duplicate (| $head $tail))
    (if (== $tail Nil)
        (| $head Nil)
        (if (is-member $head $tail)
            (remove-duplicate $tail)
            (| $head (remove-duplicate $tail))
        )
)
)
! (remove-duplicate (| 6 (| 5 (| 4 (| 3 ( | 5 (| 2 (| 5 (| 1 Nil)))))))))

 ; Sort list
(= (sort ()) ())
(= (sort (| $head $tail))
    (place $head (sort $tail)))
(= (place $val ()) (| $val ()))
(= (place $val (| $head $tail))
    (if (> $val $head)
        (| $head (place $val $tail))
        (| $val (| $head $tail))))

 ; ! (sort (| 4 (| 8 (| 3 (| 5 (| 1 (| 6 (| 5 (| 2 (| 9 ()))))))))))