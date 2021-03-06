#|
Código que recibe el estado actual de un tablero de conecta 4
y regresa los movimientos posibles en forma de lista.
|#
;(setq dificultad 10)
(setq edoInicial '((0 0 0 0 1 1)
   				   (0 0 0 0 1 2)
   				   (0 0 0 0 0 0)
   				   (0 0 0 1 1 1)
   				   (0 0 0 0 0 0)
   				   (0 0 0 0 0 0)
   				   (0 0 0 0 0 0)))

(setq edo '((0 0 2 2 2 1)
   				   (0 0 0 2 1 2)
   				   (0 0 0 0 0 0)
   				   (0 0 0 2 1 1)
   				   (0 0 0 0 0 0)
   				   (0 0 0 0 0 0)
   				   (0 0 0 0 0 0)))

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

(defun contieneLista (a b)
	(if (or (null a) (null b)) (return-from contieneLista 'nosol))
	(if (equal a (car b)) (return-from contieneLista T))
	(contieneLista a (cdr b))
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
(defun winwinJug (estado jugador)
	(setq c1 0 c2 0 c3 0 c4 0)
	(cond ((member T (mapcar (lambda (lista) (winwin2 lista jugador c1)) (ordenaRenglones estado)))(return-from winwinJug estado))
		  ((member T (mapcar (lambda (lista) (winwin2 lista jugador c1)) (ordenaDiagDer estado)))(return-from winwinJug estado))
		  ((member T (mapcar (lambda (lista) (winwin2 lista jugador c1)) (ordenaDiagIzq estado)))(return-from winwinJug estado))
		  ((member T (mapcar (lambda (lista) (winwin2 lista jugador c1)) estado))(return-from winwinJug estado))

	(t(return-from winwinJug nil)))
)

(defun winwin2 (lista jugador contador)
	(cond ((equal contador 4)(return-from winwin2 T))
		  ((null lista)(return-from winwin2 nil))
		  ((equal (car lista) jugador)(winwin2 (cdr lista) jugador (+ contador 1)))
	(t (winwin2 (cdr lista) jugador 0)))
)

;;Función que le asigna un costo an tablero dada la probabilidad de ganar

(defun heuristica (estado nivel)
	(if (winwin estado 1) (return-from heuristica (- -5000 nivel)))
	(if (winwin estado 2) (return-from	heuristica (+ 5000 nivel)))
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

(defun actualizaV (estado v)
	(push (list estado v) jugada)
	)

(defun maximum (list)
  (reduce #'max list))

(defun alfa-beta (estado nivel)
   (setq jugada '())
   (setq vals '())
   (setq movimientosIniciales (movPos estado 2))
   (setq sol (max-value nivel 2 estado -10000 10000))
   (setq sol2 (maximum vals))
   (return-from alfa-beta (list sol2 jugada))
)

(defun max-value (nivel player estado alfa beta)
	(if (or (winwin estado 1) (winwin estado 2) (equal nivel 0))(return-from max-value (heuristica estado nivel)))
	(setq v -10000 movPosibles (movPos estado player))
	(loop for x in movPosibles do 
		(setq vPrim (min-value (- nivel 1) 1 x alfa beta))
		(if (> vPrim v) (setq v vPrim))
		(if (and (eq nivel dif) (contieneLista x movimientosIniciales)) (and (push v vals) (actualizaV x v)))
		(if (>= v beta) (return-from max-value v))
		(setq alfa (max v alfa)))
	(return-from max-value v)
	) 

(defun min-value (nivel player estado alfa beta)
	(if (or (winwin estado 1) (winwin estado 2) (equal nivel 0))(return-from min-value (heuristica estado nivel)))
	(setq v 10000 movPosibles (movPos estado player))
	(loop for x in movPosibles do
		(setq vPrim (max-value (- nivel 1) 2 x alfa beta))
		(if (< vPrim v) (setq v vPrim))
		(if (<= v alfa) (return-from min-value v))
		(if (< vPrim beta) (setq beta vPrim)))
	(return-from min-value v)
	)

(defun contieneLista (a b)
	(if (or (null a) (null b)) (return-from contieneLista 'nosol))
	(if (equal a (car b)) (return-from contieneLista T))
	(contieneLista a (cdr b))
	)

;lisst es la creada al actualizar, control es la de movpos
(defun encontrarJugada (movSig valor movPosi)
	(if (null movPosi)(return-from encontrarJugada 'No_se_pudo))
	(cond ((recorreJugada movSig valor (car movPosi)) (return-from encontrarJugada (car movPosi)))
	(t(encontrarJugada movSig valor (cdr movPosi))))
	)

(defun recorreJugada(movSig valor jugadaPosi)
	(if (null movSig)(return-from recorreJugada nil))
	(cond ((and (equal (caar movSig) jugadaPosi) (equal (cadar movSig) valor))(return-from recorreJugada T))
	(t(recorreJugada (cdr movSig) valor jugadaPosi))
	))

(defun restaCol (col1 col2)
	(return-from restaCol (mapcar #'- col2 col1))
	)
(defun encuentraCol (estadoIn jugada)
	(setq resta '())
	(encuentraCol2 estadoIn jugada)
	(setq resta (reverse resta))
	(return-from encuentraCol resta)
	)

(defun encuentraCol2 (estadoIn jugada)
	(if (or (null estadoIn) (null jugada))(return-from encuentraCol2 0))
	(push (restaCol (car estadoIn) (car jugada)) resta)
	(encuentraCol2 (cdr estadoIn) (cdr jugada))
	)

(defun dameColumna (lista)
	(setq contdr 1)
	(dameColumna2 lista contdr)
	)
(defun dameColumna2 (lista contador)
	(if (null lista)(return-from dameColumna2 nil))
	(if (member 1 (car lista))(return-from dameColumna2 contador))
	(if (member 2 (car lista))(return-from dameColumna2 contador))
	(dameColumna2 (cdr lista) (+ contador 1))
	)

(defun fun (estdo)
	(setq edo (movPos estdo 1))
	(setq edos (movPos estdo 2))
	(fun2 edo edos)
	)

(defun fun2 (edo edos)
	(if (winwin (car edo) 1)(return-from fun2 (winwinJug (car edo) 1)))
	(if (winwin (car edos) 2)(return-from fun2 (winwinJug (car edos) 2) ))
	(if (and(null edo)(null edos))(return-from fun2 nil))
	(fun2 (cdr edo)(cdr edos))
	)
(defun colFun (edoInicial state )
	(setq column (encuentraCol edoInicial state))
	(setq res (- (dameColumna column) 1))
	(return-from colFun res)
	)

(defun jugar (edoActual dificultad)
	(setq dif dificultad)
	(if (and (> dif 9) (not(null (fun edoActual))))(return-from jugar (colFun edoActual (fun edoActual))))
	(setq listaAl (alfa-beta edoActual dificultad))
	(setq jugadaEscogida (encontrarJugada (cadr listaAl) (car listaAl) (movPos edoActual 2)))
	(setq column (encuentraCol edoActual jugadaEscogida))
	(setq res (- (dameColumna column) 1))
	(return-from jugar res)
	)
