(setq lst '(1 2 3 4 5 6 7 8 9) n 4 h 25)
(setq abierto '(('CELAYA 'CDMX 2 4) ('Pachuca 'Tizayuca 5 9)))
(setq cerrado '(('CELAYA 'CDMX 2 4)))
(setq testNodo '('Pachuca 'guadalajara 3 2) testNodo2 '('CELAYA 'CDMX 2 4))
(setq testNodo3 '('Pachuca 'Hidalgo 4 3.5))
;;Add in position n the object h
(defun addInPosition(lst pos node)
(setq lst (append (reverse (nthcdr (- (length lst) (- pos 1)) (reverse lst))) (list node) (nthcdr (- pos 1) lst)))
)

(defun estaEnCerrado (nodo)
	(if (equal (length cerrado) (length (adjoin nodo cerrado :test #'equal))) 
			(return-from estaEnCerrado t) 
			(return-from estaEnCerrado nil))
)

(defun estaEnAbierto (nodo)
	(if (equal (length abierto) (length (adjoin nodo abierto :test #'equal))) 
			(return-from estaEnAbierto t) 
			(return-from estaEnAbierto nil))
)

;;obten el costo del primer nodo de abierto
(defun getCosto (lst)
	(return-from getCosto (car (last (car lst))))
)
;;obten la profunidad del primer nodo de abierto
(defun getProfundidad(lst)
	(return-from getProfundidad (caddr (car lst)))
)
;;agrega a abierto ya ordenadamente por COSTO
(defun addToOpen(nodo)
	(setq pos 1)
	(if
		(and
			;;(or 
				(<= (car (last nodo)) (getCosto abierto)) 
			;;	(<= (caddr nodo) (getProfundidad abierto)) 
			;;)
			(not (estaEnCerrado nodo))
			(not (estaEnAbierto nodo))
		)
		(push nodo abierto)
		;;nodo a agregar, cdr de abierto y posición en que hay que agregar
		(addToOpen2 nodo (cdr abierto) (incf pos)) 
	)
)
;;overload de función addToOpen para agregar en posición pos
(defun addToOpen2(nodo lst pos)
	(cond
		((null lst))
		((and
			;;(or 
				(<= (car (last nodo)) (getCosto lst)) 
				;;(<= (caddr nodo) (getProfundidad lst))
			;;)
			(not (estaEnCerrado nodo))
			(not (estaEnAbierto nodo))
		) (addInPosition abierto pos nodo))
	(t 
		(addToOpen2 nodo (cdr lst) (incf pos)))
	)
)