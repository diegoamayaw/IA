#!/usr/local/bin/sbcl --script
(defvar lst)
(defvar dificultad)
(defvar edoActual)
(load  "/Users/Leandro/Desktop/IA/Conecta4/connect4.lisp")
(setq lst (nthcdr 1 sb-ext:*posix-argv*))
(setq lst (read-from-string (format nil "~{ ~A~}" lst)) dificultad (car lst) edoActual (cadr lst))

(print (jugar edoActual dificultad))
(exit)
exit