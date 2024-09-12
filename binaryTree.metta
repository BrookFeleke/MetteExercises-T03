(: Tree Type)
(: Nil Tree)
(: Node (-> Number Tree Tree Tree))

 ; Build tree function
(= (bt Nil $value)
    (Node $value Nil Nil)
)
(= (bt (Node $root $l $r) $value)
    (if (< $value $root)
        (Node $root (bt $l $value) $r)
        (if (> $value $root)
            (Node $root $l (bt $r $value))
            (Node $root $l $r)
        )
)
)
! (bt (bt (bt (bt (bt Nil 1) 4)2)30)6)

 ; Check if value exists in tree
(= (exists Nil $value) False) ;; Base case: Empty tree, value not found
(= (exists (Node $root $l $r) $value)
    (if (== $value $root)
        True ;; Found the value
        (if (< $value $root)
            (exists $l $value) ;; Search in the left subtree
            (exists $r $value))))
! (exists (bt (bt (bt (bt (bt Nil 1) 4)2)30)6) 320) [False]

 ; To combine two lists
(= (zip () $list) $list)
(= (zip (| $head $tail) $list)
    (| $head (zip $tail $list)))

 ;;;;;;;;;;;;;;;;;; TRAVERSALS
(= (in-order Nil) ()) ;; Base case: Empty tree
(= (in-order (Node $value $l $r))
    (zip (in-order $l) (| $value (in-order $r)))) ;; Recursively traverse left, root, right
! (in-order (bt (bt (bt (bt (bt Nil 1) 4)2)30)6))

 ;; Pre-order traversal: root -> left -> right
(= (pre-order Nil) ()) ;; Base case: Empty tree
(= (pre-order (Node $value $l $r))
    (zip (| $value (pre-order $l)) (pre-order $r))) ;; Root, then recursively left and right
! (pre-order (bt (bt (bt (bt (bt Nil 1) 4)2)30)6))
 ;; Post-order traversal: left -> right -> root
(= (post-order Nil) ()) ;; Base case: Empty tree
(= (post-order (Node $value $l $r))
    (zip (post-order $l) (zip (post-order $r) (| $value ())))) ;; Recursively left, right, then root
! (post-order (bt (bt (bt (bt (bt Nil 1) 4)2)30)6))

(= (min (Node $root $l $r))
    (if (== $l Nil)
        $root
        (min $l)
    )
)
 ; Delete Node Function
! (min (bt (bt (bt (bt (bt Nil 1) 4)2)30)6))
(= (delete Nil $value) Nil) ;; Base case: Empty tree, nothing to delete
(= (delete (Node $root $l $r) $value)
    (if (< $value $root)
        (Node $root (delete $l $value) $r) ;; Recursively delete from the l subtree
        (if (> $value $root)
            (Node $root $l (delete $r $value)) ;; Recursively delete from the r subtree
             ;; Value found, now we handle the three cases
            (if (== $l Nil) $r ;; Case 1: No l child, return r subtree
                (if (== $r Nil)
                    $l
                    (let $min-r (min $r)
                        (Node $min-r $l (delete $r $min-r))
                    )
            )
    )
)
)
)
 ; Delete Function test
! (pre-order (delete (bt (bt (bt (bt (bt Nil 1) 4)2)30)6) 6))