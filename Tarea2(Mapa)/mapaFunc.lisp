;;Cosas por hacer:
;;Una función que actualice el nombre del padre que se está expandiendo
;;Leer opciones de expansión
;;Cambiar padre a cerrado
;;Agregar nodo a abierto
;;Función que diga si ya se alcanzó el estado meta
;;defRoute
;;getDad

(defun AStar (nodoInicio nodoFinal)
	(setq abierto nil)
	(setq cerrado nil)
	(push nodoInicio abierto)
	(loop
		(cond ((null abierto)(return 'No_se_encontro_solucion)))
		))

;;Se crean las tablas hash con un tamaño inicial de 50
(defun creaTablas()
	(setq BdCoord (make-hash-table :size 50) BdHijos (make-hash-table :size 50) ))

;;Obtiene coordenadas de la tabla hash y las guarda en una variable global.
(defun getCoordIniFin(nomIni nomFin)
	(setq coordIni (gethash nomIni BdCoord) coordFin (gethash nomFin BdCoord)))

;;Calcula h(n) distancia en línea recta usando la fórmula de Haversine.
(defun calculaHn(nodo)
	(setq coordNode (gethash nomNode))
	(setq lat1 (cdr coordFin) lat2 (car coordNode) long1 (cdr coordFin) long2 (cdr coordNode))
	(setq RadT 6371 difLat (- lat2 lat1) difLong (- long2 long1))
	(setq a (+ (expt (sin (/ difLat 2)) 2) (* (cos lat1) (cos lat2) (expt (sin (/ difLong 2)) 2))))
	(setq dist (* 2 RadT (asin (expt a 0.5))))
	(return dist))

;; Función de costo f(n) se le entrega un nodo con su nombre y costo g(n) como: (nombre costo)
(defun calculaCosto (nodo)
	(setq costo (+ (cdr nodo) (calculaHn (car nodo)))))

;;Se crea el nodo que tiene la información necesaria
(defun creaInfoNodo(nombre padre cont costo)
	(setq infoNodo (list nombre padre cont costo))
	(return infoNodo))


;;Si el nodo está en cerrado (ya lo checó), regresa nil, si no está, lo agrega a abierto
(defun agregaAbierto (nodo)
	(if (equal (length cerrado) (length (adjoin nodo cerrado))) (return nil)(push nodo abierto)))

;;Checa si el nodo es igual al objetivo, si lo es regresa T, si no, nil
(defun checaObjetivo (nodo)
	(if (equal nodo objetivo)(return T)(return nil)))


