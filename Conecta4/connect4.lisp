#|
Código que recibe el estado actual de un tablero de conecta 4
y regresa los movimientos posibles en forma de lista.

Diego Amaya Wilhelm
|#
(setq edoInicial '((nil nil nil nil nil nil)
				   (nil nil nil nil nil nil)
				   (nil nil nil nil nil nil)
				   (nil nil nil nil nil nil)
				   (nil nil nil nil nil nil)
				   (nil nil nil nil nil nil)
				   (nil nil nil nil nil nil)))
;;Regresa las columnas que no están llenas (que pueden recibir otra ficha) en forma de lista
(defun colPosibles (edo)
	(setq colPos '())
	(colPosibles2 edo)
	(reverse colPos))

(defun colPosibles2 (edo)
	(cond ((null edo)0)
		  ((null (member nil (car edo)))(push nil colPos)(colPosibles2 (cdr edo)))
	(t(push T colPos)
	  (colPosibles2 (cdr edo)))))

;;Reemplaza un elemento de la lista en la posición indicada
(defun reemplazaEnPos(posit elem lst)
	(setq aux '())
	(setq aux (append (reverse (nthcdr (- (length lst) (- posit 1)) (reverse lst))) (cons elem (nthcdr posit lst)) ))
	(return-from reemplazaEnPos aux)
	)
(defun getElemento (pos lst)
	(setq aux '())
	(setq aux (car (nthcdr (- pos 1) lst)))
	(return-from getElemento aux)
	)
;;Encuentra la posición en la que se debe colocar una ficha
(defun encuentraPos (lst)
	(setq cont 0)
	(encuentraPos2 lst cont)
	)
(defun encuentraPos2 (lst cont)
	(if (or (null lst) (equal cont 6)) (return-from encuentraPos2 cont))
	(if (not (null (car lst))) (return-from encuentraPos2 cont) (encuentraPos2 (cdr lst) (+ cont 1)))
	)
;;De una lista (columna de fichas) tira una ficha.
(defun ponerFicha (lst ficha)
	(reemplazaEnPos (encuentraPos lst) ficha lst))
;;Crea un movimiento posible, recibe el contador, la lista donde está y la ficha a colocar
(defun creaMovPos (c edo ficha)
	(reemplazaEnPos c (ponerFicha (getElemento c edo) ficha) edo)
	)
;Crea la lista de todos los movimientos posibles
(defun movPos (edo ficha)
	(setq movPosibles '())
	(setq contador 1)
	(movPos2 edo contador (colPosibles edo) ficha)
	(setq movPosibles (reverse movPosibles))
	)
(defun movPos2 (edo c columPos ficha)
	(if(null columPos)(return-from movPos2 movPosibles))
    (cond ((null (car columPos)))
    	  (t(push (creaMovPos c edo ficha) movPosibles)))
    (movPos2 edo (+ c 1) (cdr columPos) ficha)
	)



;Para cada posibilidad de columna toma el estado y 
;reemplaza el último nil con una ficha.
;set de todas las posibilidades.


#|
Código de Alfa-Beta

Leandro Pantoja
|#
(defun alfa-beta (estado nivel)
   (setq sol -1)
   (max-value nivel 'O estado -1000 1000)
 )

(defun max-value (nivel player estado alfa beta)
	;aqui hay que darle valor a alfa de acuerdo a la heurística
	(setq v -1000)
	(setq movPosibles (movPos estado))
	(loop for x in movPosibles do 
		(setq vPrim (min-value (- nivel 1) 'X x alfa beta))
		(if (> vPrim v) (setq v vPrim))
		(if (> vPrim alfa) (setq alfa vPrim))
		(if (>= vPrim beta) (return-from max-value v)))
	v
)

(defun min-value (nivel player estado alfa beta)
	;aqui hay que darle valor a beta de acuerdo a la heurística
	(setq v 1000)
	(setq movPosibles (movPos estado))
	(loop for x in movPosibles do 
		(setq vPrim (max-value (- nivel 1) 'O x alfa beta))
		(if (< vPrim v) (setq v vPrim))
		(if (< vPrim beta) (setq beta vPrim))
		(if (<= vPrim alfa) (return-from min-value v)))
	v
)


;Guillermo Flores Cuevas
;Add to hash table the current states 
(defvar index 0)
(defun addToStates (st)
	(setf (gethash index states) st)
	(incf index)
)


(defun getDadCost (node)
	(cond 
		((equal 0 (car node))
			(return-from getDadCost 0)
		)
	(t return-from getDadCost -1)
	)
)
;Calculates my cost 
(defun calculateMyCost (state)
	(setq cost 0)
	(return-from calculateMyCost cost)
)
;Calculates my oponents cost
(defun calculateOpCost (state)
	(setq cost 0)
	(return-from calculateOpCost cost)
)
;Calculates the cost that takes my oponent and me to win
(defun calculateCost (state)
	(return-from calculateCost (- calculateMyCost calculateOpCost))
)

;calculates the total cost, i.e. considers the dad cost
(defun calculateTotalCost (state)
	(return-from calculateTotalCost (+ calculateCost (getDadCost dad))) 
)
;Creates node in order to add it to the current generated tree
(defun createNode (me myDad depth cost Tcost alpha beta v)
	(setq node (list me myDad depth cost Tcost alpha beta v))
	(return-from createNode node)
)

(defun addToTree (node)
	(cond
		((equal 0 (car node))
			(push currentTree node);Adding the first node to tree
		)
	(t (setq currentTree (append currentTree (list node))))
		
	)
)

(defun generateTree ()
	(setq dad edoInicial) ;is the current states that we receive from the interface 
	(setq depth 0)
	(setq difficulty 1) ;receives integer values from 1 to 3, 3 means the expert difficulty
	(setq currentTree nil)
	(setq states (make-hash-table :size 50))
	(setq nodesList nil)
	(setq alpha 0 beta 0 v 0)
	(setq currentPlayer 1)
	;Node structure --> (me myDad depth cost totalCost alpha beta v)
	(addToStates dad)
	;create first node
	(setq actualNode (createNode index nil depth #|(calculateCost (gethash index states)) (calculateTotalCost (gethash index states))|# 
		0 0 alpha beta v))
	(addToTree actualNode)
	(loop 
		(cond 
			((equal difficulty depth) retrun-from generateTree (alfa-beta currentTree difficulty))
		)
		(t 
		(cond 
			((equal currentPlayer 1) (setq currentPlayer 2) (setq currentPlayer 1)
			)
		)
		(movPos dad currentPlayer)
		(mapcar #'addToStates movPosibles)
		(mapcar #'createNode index nil depth 0 0 alpha beta v);posible moves for me, computer
		(addToTree (car nodesList)) (addToTree (cdr nodesList))
		);end of conditional
	)
	


)

  
;(load "C:\\Users\\Guille\\Documents\\8vo Semestre\\Inteligencia Artificial\\Proyectos\\connect4.lisp")
