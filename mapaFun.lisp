(defun AStar (nodoInicio nodoFinal)
	(setq abierto nil)
	(setq cerrado nil)
	(push nodoInicio abierto)
	(loop
		(cond ((null abierto)(return 'No_se_encontro_solucion)))
		))
#|
Se mete el nodo inicial en abierto
|<---------------------------------<---
Abierto null?--T-->FAIL           |   |
|F                                |   |
|                                 |   |
Pasar primero abierto a cerrado   |   |
Expander nodo                     |   |
Tiene sucesores?--F----------------   |
|T                                    |
|                                     |
Poner sucesores en abierto            |
Sucesor=Objetivo?----------------------
|T
FIN

Checa abierto, no recibe, regresa Null
ordenar por costo, no recibe, regresa abierto ordenado por costo
mete a cerrado, recibe nodo
	checa si nodo está en cerrado, si sí, lo quita de abierto, si no, lo agrega
expandir nodo, recibe un nodo, regresa lista con hijos, los mete a abierto
checa objetivo, recibe nodo, regresa nil o T
|#