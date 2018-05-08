#|
Tarea 1 de LISP
Diego Amaya Wilhelm
Inteligencia artificial - ITAM

Importación a Lisp:
(load "/home/diegoamayaw/Documents/ITAM/IA/tarea1.lisp")
|#
;;1.- Función que indica la profundidad de una lista
(defun depth(lst)
	(cond ((null lst)1)
		((atom lst)0)
		(t (max (+ (depth (first lst)) 1) (depth (rest lst))))))

;;2.- Función que indica el máximo número de nodos hijos de un árbol

(defun degtree (lst)
	(degtree2 lst 0))

(defun degtree2 (lst cont)
	(cond ((null lst) cont)
		  ((atom (car lst))(degtree2 (cdr lst) (+ cont 1)))
	(t (max (degtree2 (car lst) 0) (degtree2 (cdr lst) cont)))))

;;3.- Función que imprime el árbol correspondiente a una lista
(defun print-tree(lst)
	(setq lista '())
	(print-tree2 lst '())
	(reverse lista))

(defun print-tree2 (lst new)
	(cond ((null lst)
			(cond ((null new))
				  (t (push '+ lista)(print-tree2 new '()))))
		  ((atom (car lst)) (push (car lst) lista)(print-tree2 (cdr lst) new))
		  (t(print-tree2 (cdr lst) (append new (car lst))))))

;;4.- Función que devuelve el inverso de una lista a profundidad
(defun deep-reverse(lst)
	(cond ((null lst) nil)
		  ((atom lst) lst)
	(t(reverse (mapcar #'deep-reverse lst)))))
