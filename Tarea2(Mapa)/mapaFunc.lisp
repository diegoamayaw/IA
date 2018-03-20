
(load "~/Documents/ITAM/IA/Tarea2(Mapa)/datos.lisp")

;;Fija los nombres de origen y destino en variables nomIni y nomDest
(defun setNames (n1 n2)
	(setq nomIni n1 nomDest n2))
;;Obtiene coordenadas de la tabla hash y las guarda en una variable global.
(defun getCoordIniFin()
	(setq coordIni (gethash nomIni BdCoord) coordFin (gethash nomDest BdCoord)))

(defun toRadianes (cantidad)
	(return-from toRadianes (/ (* cantidad 3.141592) 180)))

;;Calcula h(n) distancia en línea recta en km usando la fórmula de Haversine
(defun calculaHn(nom)
	(setq coordNode (gethash nom BdCoord))
	(setq lat1 (toRadianes (car coordFin)) lat2 (toRadianes (car coordNode)) long1 (toRadianes (cadr coordFin)) long2 (toRadianes (cadr coordNode)))
	(setq RadT 6371 difLat (- lat2 lat1) difLong (- long2 long1))
	(setq a (+ (expt (sin (/ difLat 2)) 2) (* (cos lat1) (cos lat2) (expt (sin (/ difLong 2)) 2))))
	(setq dist (* 2 RadT (asin (expt a 0.5))))
	(return-from calculaHn dist))

;; Función de costo f(n) se le entrega un nodo con su nombre y costo g(n) como: (nombre costo)
(defun calculaCosto (nodo)
	(return-from calculaCosto (+ (third nodo) (costoPadre) (calculaHn (first nodo)))))

(defun costoPadre ()
	(return-from costoPadre (third padre)))
;;Se crea el nodo que tiene la información necesaria
(defun creaInfoNodo(nombre padre gn hn costoTot)
	(setq infoNodo (list nombre padre gn hn costoTot))
	(return-from creaInfoNodo infoNodo))

(defun actualizaPadre (nodo)
	(setq padre nodo))
;;Checa si el nodo es igual al objetivo, si lo es regresa T, si no, nil
(defun checaObjetivo (nodo)
	(if (equal (first nodo) nomDest)(return-from checaObjetivo T)(return-from checaObjetivo nil)))

;;Obtiene el atributo de nombre del nodoInfo
(defun getNombre(nodo) 
	(return-from getNombre (car nodo)))

;;Obtiene el nodoInfo del padre de nodo
(defun buscaPadre(nodo lst)
	(setq nomPadre (second nodo))
	(cond ((null lst))
		  ((equal nomPadre (first (car lst)))(return-from buscaPadre (car lst)))
	(t (buscaPadre nodo (cdr lst)))))

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

;;Add in position n the object node)))

(defun addInPosition(posit node)
	(setq lista '())
	(if (<= posit (+ (length abierto) 1))
	(setq lista (append (reverse (nthcdr (- (length abierto) (- posit 1)) (reverse abierto))) (list node) (nthcdr (- posit 1) abierto)) abierto lista)
	(return-from addInPosition nil)))

(defun estaEnCerrado (nodo)
	(if (equal (length cerrado) (length (adjoin nodo cerrado :test #'equal))) 
			(return-from estaEnCerrado t) 
			(return-from estaEnCerrado nil)))

(defun estaEnAbierto (nodo)
	(if (equal (length abierto) (length (adjoin nodo abierto :test #'equal))) 
			(return-from estaEnAbierto t) 
			(return-from estaEnAbierto nil)))

;;obten el costo del primer nodo de abierto
(defun getCosto (lst)
	(return-from getCosto (car (last (car lst)))))

(defun actualizaCosto (nodo)
	(setq aux (reverse (rplaca (reverse nodo) (calculaCosto nodo))) infoNodo aux))
;;obten la profunidad del primer nodo de abierto
(defun getProfundidad(lst)
	(return-from getProfundidad (caddr (car lst)))
)
(defun costoNodo(nodo)
	(return-from costoNodo (third nodo)))
(defun addToClosed (nodo)
	(if (not (estaEnCerrado nodo)) (push nodo cerrado)(return-from addToClosed nil)))
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
		(addInPosition pos nodo))
		;;nodo a agregar, cdr de abierto y posición en que hay que agregar
		(t (addToOpen2 nodo (cdr abierto) (incf pos))) 
	)
)
;;overload de función addToOpen para agregar en posición pos
(defun addToOpen2(nodo lsta pos)
	(cond
		((null lsta) (addInPosition pos nodo))
		((and
			;;(or 
				(<= (car (last nodo)) (getCosto lsta)) 
				;;(<= (caddr nodo) (getProfundidad lst))
			;;)
			(not (estaEnCerrado nodo))
			(not (estaEnAbierto nodo))
		) (addInPosition pos nodo))
	(t (addToOpen2 nodo (cdr lsta) (incf pos))))
)
;;Obtiene las opciones en pares como nombre-costo de un nodo padre
(defun getOpciones (nodo)
	(setq listaOpc (gethash (first nodo) BdHijos)))
	(setq listaNodos '())

;;Crea una lista con nodoInfos de cada opción posible
(defun creaNodosOpciones (listaOp)
	(setq listaNodos '())
	(creaNodosOpciones2 listaOp))


(defun creaNodosOpciones2 (listaOp)
(cond	((null listaOp)(return-from creaNodosOpciones2 listaNodos))

(t(push (creaInfoNodo (caar listaOp) (getNombre padre) (car(last(car listaOp))) (calculaHn (caar listaOp)) (+ (costoNodo padre) (car(last(car listaOp))) (calculaHn (caar listaOp)))
		) listaNodos)(creaNodosOpciones2 (cdr listaOp)))))


;;Función A*
(defun AStar (n1 n2)
	;;Crea listas globales
	(setq abierto '())
	(setq cerrado '())
	(setq prof 0)
	(setq padre (creaInfoNodo nil nil 0 0 0))
	;;Fija nombres recibidos como variables globales
	(setNames n1 n2)
	;;Fija coordenadas de inicio y final como globvar
	(getCoordIniFin)
	;;Crea el infoNodo de inicio
	(creaInfoNodo nomIni nil 0 (calculaHn n1) 0)
	;;Se actualiza el costo hn de inicio a fin
	(actualizaCosto infoNodo)
	;;Se mete a abierto el nodo inicio
	(push infoNodo abierto)

	(loop
		(cond ((null abierto)(return-from AStar 'No_se_encontro_solucion))
		(t 
			;;inicia ciclo general
			;;Se obtienen las opciones del infoNodo
			(getOpciones infoNodo)
			;;Se actualiza el padre del cuál fueron obtenidas las opciones
			(actualizaPadre infoNodo)
			;;El padre al ser expandido se pasa a cerrado
			(addToClosed padre)
			;;Se crean los infoNodos de las opciones
			(creaNodosOpciones listaOpc)
			;;Checa cada una y agrega a abierto
			(mapcar #'addToOpen listaNodos)
			(if (checaObjetivo infoNodo) (return-from AStar (defRoute infoNodo cerrado)))
	

		)
		)
	)
	
)


;__________________________________________________________PRUEBAS______________________________________________________________________
#|
(setq abierto '())
	(setq cerrado '())
	(setq prof 0)
	(setq padre (creaInfoNodo nil nil 0 0 0))
	;;Fija nombres recibidos como variables globales
	(setNames n1 n2)
	;;Fija coordenadas de inicio y final como globvar
	(getCoordIniFin)
	;;Crea el infoNodo de inicio
	(creaInfoNodo nomIni nil 0 (calculaHn n1) 0)
	;;Se actualiza el costo hn de inicio a fin
	(actualizaCosto infoNodo)
	;;Se mete a abierto el nodo inicio
	(push infoNodo abierto)
	(pop abierto)
	(getOpciones infoNodo)
	;;Se actualiza el padre del cuál fueron obtenidas las opciones
	(actualizaPadre infoNodo)
	;;El padre al ser expandido se pasa a cerrado
	(addToClosed padre)
	;;Se crean los infoNodos de las opciones
	(creaNodosOpciones listaOpc)
	;;Checa cada una y agrega a abierto
|#