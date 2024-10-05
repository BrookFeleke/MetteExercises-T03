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
                ($type (get-metatype $head))
                ($newtail (orCut $tail))
            ) (if (== $type Expression)
            (cons-atom (orCut $head) $newtail)
            ( if (== OR $head) (let* (
                        ($subhead (car-atom $newtail))
                        ($subtail (cdr-atom $newtail))
                    ) (if (== $subtail ())
                    $subhead
                    (cons-atom $head $newtail)
                )
        )
    (cons-atom $head $newtail))
)
)
)
)

! (orCut ( (AND (NOT A) B (OR C (NOT D) (AND E F (NOT G))))))
 ; ! (orCut (AND (OR C D (NOT B)) (NOT A)))
! (orCut (OR (AND (OR X Z) (OR A B))))
