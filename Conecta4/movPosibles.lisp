#|
Código que recibe el estado actual de un tablero de conecta 4
y regresa los movimientos posibles en forma de lista.

Diego Amaya Wilhelm
|#
(setq edoInicial '((0 0 0 0 0 1)
				   (0 0 0 0 2 1)
				   (0 0 0 0 0 1)
				   (0 0 0 1 2 2)
				   (0 0 0 2 1 1)
				   (0 0 0 0 2 1)
				   (0 0 0 1 1 2)))
;;Regresa las columnas que no están llenas (que pueden recibir otra ficha) en forma de lista
(defun colPosibles (edo)
	(setq colPos '())
	(colPosibles2 edo)
	(reverse colPos))

(defun colPosibles2 (edo)
	(cond ((null edo)0)
		  ((null (member 0 (car edo)))(push nil colPos)(colPosibles2 (cdr edo)))
	(t(push T colPos)
	  (colPosibles2 (cdr edo)))))

;;Reemplaza un elemento de la lista en la posición indicada
(defun reemplazaEnPos(posit elem lst)
	(setq aux '())
	(setq aux (append (reverse (nthcdr (- (length lst) (- posit 1)) (reverse lst))) (cons elem (nthcdr posit lst)) ))
	(return-from reemplazaEnPos aux)
	)
;;Regresa el elemento de lst en pos
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
	(if (not (equal (car lst) 0)) (return-from encuentraPos2 cont) (encuentraPos2 (cdr lst) (+ cont 1)))
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

;;Función que arregla el tablero por renglones
(defun ordenaRenglones (estado)
	(setq renglones (list (mapcar #'first estado) (mapcar #'second estado) (mapcar #'third estado) (mapcar #'fourth estado)
						  (mapcar #'fifth estado)(mapcar #'sixth estado))))

;;Función que ordena el tablero por la diagonal de derecha a izquierda empezando por el elemento de arriba a la izquierda
(defun ordenaDiagDer (estado)
	(setq diagDer (list (list (first (first estado)))
						(list (first (second estado)) (second (first estado)))
						(list (first (third estado)) (second (second estado)) (third (first estado)))
						(list (first (fourth estado)) (second (third estado)) (third (second estado)) (fourth (first estado)))
						(list (first (fifth estado)) (second (fourth estado)) (third (third estado)) (fourth (second estado)) (fifth (first estado)))
						(list (first (sixth estado)) (second (fifth estado)) (third (fourth estado)) (fourth (third estado)) (fifth (second estado)) (sixth (first estado)))
						(list (first (seventh estado)) (second (sixth estado)) (third (fifth estado)) (fourth (fourth estado)) (fifth (third estado)) (sixth (second estado)))
						(list (second (seventh estado)) (third (sixth estado)) (fourth (fifth estado)) (fifth (fourth estado)) (sixth (third estado)))
						(list (third (seventh estado)) (fourth (sixth estado)) (fifth (fifth estado)) (sixth (fourth estado)))
						(list (fourth (seventh estado)) (fifth (sixth estado)) (sixth (fifth estado)))
						(list (fifth (seventh estado)) (sixth (sixth estado)))
						(list (sixth (seventh estado)))
				)))
;;;;Función que ordena el tablero por la diagonal de izquierda a derecha empezando por el elemento de arriba a la derecha
(defun ordenaDiagIzq (estado)
	(setq diagIzq (ordenaDiagDer (reverse estado))))

;;Función que regresa T si en cuaquier caso el jugador (1 o 2) ganaron
(defun winwin (estado jugador)
	(setq c1 0 c2 0 c3 0 c4 0)
	(cond ((member T (mapcar (lambda (lista) (winwin2 lista jugador c1)) (ordenaRenglones estado)))(return-from winwin T))
		  ((member T (mapcar (lambda (lista) (winwin2 lista jugador c1)) (ordenaDiagDer estado)))(return-from winwin T))
		  ((member T (mapcar (lambda (lista) (winwin2 lista jugador c1)) (ordenaDiagIzq estado)))(return-from winwin T))
		  ((member T (mapcar (lambda (lista) (winwin2 lista jugador c1)) estado))(return-from winwin T))

	(t(return-from winwin nil)))
)

(defun winwin2 (lista jugador contador)
	(cond ((equal contador 4)(return-from winwin2 T))
		  ((null lista)(return-from winwin2 nil))
		  ((equal (car lista) jugador)(winwin2 (cdr lista) jugador (+ contador 1)))
	(t (winwin2 (cdr lista) jugador 0)))
)

;;Función que le asigna un costo an tablero dada la probabilidad de ganar

(defun heuristica (estado)
	(if (winwin estado 1) (return-from heuristica -5000))
	(if (winwin estado 2) (return-from	heuristica 5000))
	(-(+ (* 5 (apply '+ (mapcar (lambda (lista) (heuristica2 lista 2 0)) (ordenaRenglones estado))))
		 (* 4 (apply '+ (mapcar (lambda (lista) (heuristica2 lista 2 0)) (ordenaDiagDer estado))))
		 (* 4 (apply '+ (mapcar (lambda (lista) (heuristica2 lista 2 0)) (ordenaDiagIzq estado))))
		 (* 6 (apply '+ (mapcar (lambda (lista) (heuristica2 lista 2 0)) estado)))
		 )
	  (+ (* 5 (apply '+ (mapcar (lambda (lista) (heuristica2 lista 1 0)) (ordenaRenglones estado))))
		 (* 4 (apply '+ (mapcar (lambda (lista) (heuristica2 lista 1 0)) (ordenaDiagDer estado))))
		 (* 4 (apply '+ (mapcar (lambda (lista) (heuristica2 lista 1 0)) (ordenaDiagIzq estado))))
		 (* 6 (apply '+ (mapcar (lambda (lista) (heuristica2 lista 1 0)) estado)))
		 )
	)
)

(defun heuristica2 (lista jugador contador)
	(cond ;((equal contador 4)(return-from heuristica2 1000))
		  ((and (null lista)(equal contador 3))(return-from heuristica2 10))
		  ((and (null lista)(equal contador 2))(return-from heuristica2 6))
		  ((null lista)(return-from heuristica2 1))
		  ((equal (car lista) jugador)(max (heuristica2 (cdr lista) jugador (+ contador 1)) (heuristica2 (cdr lista) jugador 0)))
	(t (heuristica2 (cdr lista) jugador contador)))
)
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
	v)

(defun min-value (nivel player estado alfa beta)
	;aqui hay que darle valor a beta de acuerdo a la heurística
	(setq v 1000)
	(setq movPosibles (movPos estado))
	(loop for x in movPosibles do 
		(setq vPrim (max-value (- nivel 1) 'O x alfa beta))
		(if (< vPrim v) (setq v vPrim))
		(if (< vPrim beta) (setq beta vPrim))
		(if (<= vPrim alfa) (return-from min-value v)))
	v)