
(load "~/Documents/ITAM/IA/Tarea2(Mapa)/datos.lisp")

(defun AStar (nodoInicio nodoFinal)
	(setq abierto nil)
	(setq cerrado nil)
	(push nodoInicio abierto)
	(loop
		(cond ((null abierto)(return-from AStar 'No_se_encontro_solucion)))
		))

;;Fija los nombres de origen y destino en variables nomIni y nomDest
(defun setNames (n1 n2)
	(setq nomIni n1 nomDest n2))
;;Obtiene coordenadas de la tabla hash y las guarda en una variable global.
(defun getCoordIniFin(nomIni nomFin)
	(setq coordIni (gethash nomIni BdCoord) coordFin (gethash nomFin BdCoord)))
(defun toRadianes (cantidad)
	(return-from toRadianes (/ (* cantidad 3.141592) 180)))

;;Calcula h(n) distancia en línea recta en km usando la fórmula de Haversine
(defun calculaHn(nodo)
	(setq coordNode (gethash (car nodo) BdCoord))
	(setq lat1 (toRadianes (car coordFin)) lat2 (toRadianes (car coordNode)) long1 (toRadianes (cadr coordFin)) long2 (toRadianes (cadr coordNode)))
	(setq RadT 6371 difLat (- lat2 lat1) difLong (- long2 long1))
	(setq a (+ (expt (sin (/ difLat 2)) 2) (* (cos lat1) (cos lat2) (expt (sin (/ difLong 2)) 2))))
	(setq dist (* 2 RadT (asin (expt a 0.5))))
	(return-from calculaHn dist))

;; Función de costo f(n) se le entrega un nodo con su nombre y costo g(n) como: (nombre costo)
(defun calculaCosto (nodo)
	(setq costo (+ (car (last nodo)) (calculaHn nodo))))

;;Se crea el nodo que tiene la información necesaria
(defun creaInfoNodo(nombre padre cont costo)
	(setq infoNodo (list nombre padre cont costo))
	(return-from creaInfoNodo infoNodo))

;;Checa si el nodo es igual al objetivo, si lo es regresa T, si no, nil
(defun checaObjetivo (nomnodo)
	(if (equal nodo objetivo)(return-from checaObjetivo T)(return-from checaObjetivo nil)))

;;Obtiene el atributo de nombre del nodoInfo
(defun getNombre(nodo) 
	(return-from getNombre (car nodo)))

;;Obtiene el nodoInfo del padre de nodo
(defun buscaPadre(nodo lst)
	(setq nomPadre (second nodo))
	(cond ((null lst))
		  ((equal nomPadre (first (car lst)))(return-from buscaPadre (car lst)))
	(t (getPadre nodo (cdr lst)))))

;;Obtiene la ruta encontrada desde el final al inicio siguiendo la referencia de los padres
(defun defRoute(nodo cerrado)
	(setq rutaFinal '())
	(push nomDest rutaFinal)
	(push (second nodo) rutaFinal)
	(defRoute2 nodo cerrado))

(defun defRoute2 (nodo cerrado)
	(cond ((equal (first (car cerrado)) nomIni)rutaFinal)
	(t(setq vater (buscaPadre nodo cerrado))
	  (push (second vater) rutaFinal)
	  (defRoute2 vater (cdr cerrado)))))

;;Add in position n the object node
(defun addInPosition(lista posit node)
(if (<= posit (+ (length lista) 1))
(setq lst (append (reverse (nthcdr (- (length lista) (- posit 1)) (reverse lista))) (list node) (nthcdr (- posit 1) lista)) abierto lst)
(return-from addInPosition nil))
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
	(cond
		((and
			;;(or 
				(<= (car (last nodo)) (getCosto abierto)) 
			;;	(<= (caddr nodo) (getProfundidad abierto)) 
			;;)
			(not (estaEnCerrado nodo))
			(not (estaEnAbierto nodo))
		)
		(addInPosition abierto pos nodo))
		;;nodo a agregar, cdr de abierto y posición en que hay que agregar
		(t (addToOpen2 nodo (cdr abierto) (incf pos))) 
	)
)
;;overload de función addToOpen para agregar en posición pos
(defun addToOpen2(nodo lsta pos)
	(cond
		((null lst) (return-from addToOpen2 'NodoRepetido))
		((and
			;;(or 
				(<= (car (last nodo)) (getCosto lsta)) 
				;;(<= (caddr nodo) (getProfundidad lst))
			;;)
			(not (estaEnCerrado nodo))
			(not (estaEnAbierto nodo))
		) (addInPosition abierto pos nodo))
	(t (addToOpen2 nodo (cdr lsta) (incf pos))))
)
;__________________________________________________________PRUEBAS______________________________________________________________________

(setNames 'A 'D)
(getCoordIniFin nomIni nomDest)
(setq abierto '())
(setq cerrado '())
(push (creaInfoNodo 'A NIL 0 4) abierto)
(push (creaInfoNodo 'B 'A 0 2) abierto)
(push (creaInfoNodo 'K 'B 0 1) abierto)
(addToOpen (creaInfoNodo 'D 'K 0 3))


