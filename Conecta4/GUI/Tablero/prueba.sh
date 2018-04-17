#!/usr/local/bin/sbcl --script
(defvar lst)
(defvar dificultad)
(defvar edoActual)
(setq lst (nthcdr 1 sb-ext:*posix-argv*))
(setq lst (read-from-string (format nil "~{ ~A~}" lst)) dificultad (car lst) edoActual (cadr lst))

(print dificultad)
(exit)
exit