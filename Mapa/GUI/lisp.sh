#!/usr/local/bin/sbcl --script
(defvar lst)
(defvar origen)
(defvar destino)
(load  "/Users/Leandro/Dropbox/Octavo\ Semestre/Inteligencia\ Artificial/Mapa/GUI/mapaFunc.lisp")
(setq lst sb-ext:*posix-argv*)
(setq lst (read-from-string (car(nthcdr 1 sb-ext:*posix-argv*))) origen (car lst) destino (cadr lst))

(print (AStar origen destino))