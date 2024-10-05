(: List type)
(: Nil (List $t))
(: Cons (-> $t (List $t) (List $t)))

(: Tree Type)
(: NodeType Type)
(: NodeValue Type)

(: ROOT NodeType)
(: AND NodeType)
(: OR NodeType)
(: NOT NodeType)
(: LITERAL NodeType)
(: NONENODE NodeType)

 ;; Value(value, truthValue, nodeType)
(: Value (-> $v Bool NodeType NodeValue))

 ;; TreeNode(nodeValue, guardSet, listOfChildren)
(: NilNode Tree)
(: TreeNode (-> NodeValue (List Tree) (List Tree) Tree))

(: Location Type)
(: L Location)
(: R Location)

(: Signal Type)
(: ReductionSignal Signal)
(: IterationSignal Signal)
(: DELETE ReductionSignal)
(: DISCONNECT ReductionSignal)
(: KEEP ReductionSignal)
(: NONE ReductionSignal)
(: ADVANCE IterationSignal)

 ;; Test 20
(= (concatTuple $xs $ys)
    (if (== $xs ())
        $ys
        (let* ( ($head (car-atom $xs))
                ($tail (cdr-atom $xs))
                ($tailNew (concatTuple $tail $ys)))
            (cons-atom $head $tailNew)
        )
)
)

(= (orCut $expresion)
    (if (== $expresion ()) ()
        (let* (
                ($head (car-atom $expresion))
                ($tail (cdr-atom $expresion))
            ) (if (== (get-metatype $head) Expression)
            (concatTuple  (orCut $head) (orCut $tail))
            (if (== $head OR)
                (let* (
                        ($subhead (car-atom $tail))
                        ($subtail (cdr-atom $tail))
                    ) (if (== $subtail ())
                    (if (== (get-metatype $tail) Expression)
                        (orCut $tail)
                        $tail
                    )
                ( (if (== (get-metatype $subhead) Expression)
                        (concatTuple (concatTuple ($head) (orCut $subhead)) (orCut $subtail))
                        (concatTuple (concatTuple ($head) ($subhead)) (orCut $subtail))
                    )) ; (concatTuple (concatTuple ($head) ($subhead)) (orCut $subtail))
        )
)
(concatTuple ($head) (orCut $tail))
)
)
)
)
)
! (orCut ( (AND (NOT A) B (OR C (NOT D) (AND E F (NOT G))))))
! (orCut (AND (OR C D (NOT B)) (NOT A)))
! (orCut (OR B C (OR X B)))
! (orCut (OR A (OR B))) ; (OR A B)
! (orCut (OR (AND A B))) ; (AND A B)

 ;(AND (NOT A) B (OR C (NOT D) (AND E F (NOT G))))
 ; ! (cdr-atom (A))

 ;; Test 1: OR with nested OR (multiple children, no orCut)
 ; ! (orCut (OR B (OR X B))) ; (OR B (OR X B))

 ;  ;; Test 2: Single child OR (orCut applies)
 ; ! (orCut (OR A)) ; A

 ;  ;; Test 3: Nested single-child OR (orCut applies twice)
 ; ! (orCut (OR (OR A))) ; A

 ;; Test 4: OR with nested AND (orCut applies to the OR node)

 ;  ;; Test 5: Complex OR with one single-child OR (orCut applies to inner OR)

 ;  ;; Test 6: OR with nested ORs (orCut applied once)
 ; ! (orCut (OR (OR A B))) ; (OR A B)

 ;  ;; Test 7: AND with OR node inside (orCut applied to OR)
 ; ! (orCut (AND A (OR B))) ; (AND A B)

 ;  ;; Test 8: Complex nested OR and AND, multiple children in OR (no orCut)
 ; ! (orCut (OR A (AND B C) (OR D E))) ; (OR A (AND B C) (OR D E))

 ;  ;; Test 9: OR with deeply nested single-child OR (orCut applies multiple times)
 ; ! (orCut (OR (OR (OR A)))) ; A

 ;  ;; Test 10: OR with multiple children (no orCut)
 ; ! (orCut (OR A B C)) ; (OR A B C)

 ;  ;; Test 11: AND with multiple nested OR nodes (orCut applied to all ORs with one child)
 ; ! (orCut (AND A (OR B (OR C)))) ; (AND A (OR B C))

 ;  ;; Test 12: Single literal (no OR, no transformation)
 ; ! (orCut A) ; A

 ;  ;; Test 13: Empty expression (no OR, returns empty)
 ; ! (orCut ()) ; ()

 ;  ;; Test 14: OR node with one nested literal (orCut applies)
 ; ! (orCut (OR (OR (AND X Y)))) ; (AND X Y)

 ;  ;; Test 15: Nested OR nodes with no single-child (no orCut)
 ; ! (orCut (OR A (OR B C))) ; (OR A B C)