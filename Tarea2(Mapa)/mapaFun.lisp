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

|#