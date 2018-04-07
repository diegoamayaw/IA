#|
Código que recibe el estado actual de un tablero de conecta 4
y regresa los movimientos posibles en forma de lista.

Diego Amaya Wilhelm
|#
(setq edoInicial '((X O X O X O)
				   (nil nil nil nil nil nil)
				   (nil nil nil nil nil nil)
				   (O X O X O X)
				   (nil nil nil nil nil nil)
				   (nil nil nil nil nil nil)
				   (nil nil nil nil nil nil)))

(defun colPosibles (edo)
	(setq colPos '())
	(colPosibles2 edo)
	(reverse colPos))

(defun colPosibles2 (edo)
	(cond ((null edo)0)
		  ((null (member nil (car edo)))(push nil colPos)(colPosibles2 (cdr edo)))
	(t(push T colPos)
	  (colPosibles2 (cdr edo)))))

(defun reemplazaEnPos(posit elem lst)
	(setq aux '())
	(setq aux (append (reverse (nthcdr (- (length lst) (- posit 1)) (reverse lst))) (cons elem (nthcdr posit lst)) ))
	(return-from reemplazaEnPos aux)
	)

(defun encuentraPos (lst)
	(setq cont 0)
	(encuentraPos2 lst cont)
	)
(defun encuentraPos2 (lst cont)
	(if (or (null lst) (equal cont 6)) (return-from encuentraPos2 cont))
	(if (not (null (car lst))) (return-from encuentraPos2 cont) (encuentraPos2 (cdr lst) (+ cont 1)))
	)
(defun ponerFicha (lst)
	(reemplazaEnPos (encuentraPos lst) 'O lst))

(defun movPos (edo) 
	)

;Para cada posibilidad de columna toma el estado y 
;reemplaza el último nil con una ficha.
;set de todas las posibilidades.
