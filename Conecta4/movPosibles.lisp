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
(defun ponerFicha (lst)
	(reemplazaEnPos (encuentraPos lst) 'O lst))

(defun creaMovPos (c edo)
	(reemplazaEnPos c (ponerFicha (getElemento c edo)) edo)
	)
(defun movPos (edo)
	(setq movPosibles '())
	(setq contador 1)
	(movPos2 edo contador (colPosibles edo))
	(setq movPosibles (reverse movPosibles))
	)
(defun movPos2 (edo c columPos)
	(if(null columPos)(return-from movPos2 movPosibles))
    (cond ((null (car columPos)))
    	  (t(push (creaMovPos c edo) movPosibles)))
    (movPos2 edo (+ c 1) (cdr columPos))
	)



;Para cada posibilidad de columna toma el estado y 
;reemplaza el último nil con una ficha.
;set de todas las posibilidades.
