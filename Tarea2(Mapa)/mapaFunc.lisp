
(defun AStar (nodoInicio nodoFinal)
	(setq abierto nil)
	(setq cerrado nil)
	(push nodoInicio abierto)
	(loop
		(cond ((null abierto)(return-from AStar 'No_se_encontro_solucion)))
		))

;;Se crean las tablas hash con un tamaño inicial de 50
(defun creaTablas()
	(setq BdCoord (make-hash-table :size 50) BdHijos (make-hash-table :size 50) ))

;;Obtiene coordenadas de la tabla hash y las guarda en una variable global.
(defun getCoordIniFin(nomIni nomFin)
	(setq coordIni (gethash nomIni BdCoord) coordFin (gethash nomFin BdCoord)))

;;Calcula h(n) distancia en línea recta usando la fórmula de Haversine
(defun calculaHn(nodo)
	(setq coordNode (gethash (car nodo) BdCoord))
	(setq lat1 (car coordFin) lat2 (car coordNode) long1 (cadr coordFin) long2 (cadr coordNode))
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


;;Si el nodo está en cerrado (ya lo checó), regresa nil, si no está, lo agrega a abierto
(defun agregaAbierto (nodo)
	(if (equal (length cerrado) (length (adjoin nodo cerrado :test #'equals))) (return-from agregaAbierto nil)(push nodo abierto)))
;;Para agregar en una pos: (append (reverse (nthcdr (- (length lst) (- n 1)) (reverse lst) )) (list h) (nthcdr (- n 1) lst))

;;Checa si el nodo es igual al objetivo, si lo es regresa T, si no, nil
(defun checaObjetivo (nomnodo)
	(if (equal nodo objetivo)(return-from checaObjetivo T)(return-from checaObjetivo nil)))

;;Obtiene el atributo de nombre del nodoInfo
(defun getNombre(nodo) 
	(return-from getNombre (car nodo)))

;;Obtiene el nodoInfo del padre de nodo
(defun getPadre(nodo lst)
	(setq nomPadre (second nodo))
	(cond ((null lst) 0)
		  ((equal nomPadre (second (car lst)))(return-from getPadre (car lst)))
	(t (getPadre nodo (cdr lst)))))

;;Obtiene la ruta encontrada desde el final al inicio siguiendo la referencia de los padres
(defun defRoute(nodo)
	(setq rutaFinal nil)
	(defRoute2 nodo))

(defun defRoute2 (nodo)
	(cond ((equal (car (first nodo)) nomInicio)0)
	(t(setq vater (getPadre nodo))
	  (push (car (second vater)) rutaFinal)
	  (defRoute2 vater))))

