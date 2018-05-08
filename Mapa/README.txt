1) Se debe tener el compilador de Common Lisp "SBCL" y Matlab para poder ejecutar el programa.

2) Se debe tener en un mismo directorio todos los archivos descargados (los dos archivos .lisp, los tres archivos de Matlab y ciudades.txt que funciona como una pequeña base de datos para la interfaz).

3)Se debe poner el path como variable de entorno:
	Ubuntu: export PATH .:$PATH
	OSX: export PATH=$PATH:--directorio de trabajo--

4) En el archivo lisp.sh se debe editar en donde se carga el archivo mapaFunc.lisp poniendo la ruta exacta en donde se encuentra la carpeta descargada.

5)Abrir matlab y correr el archivo map.m

6)Elegir las ciudades de origen y destino y hacer click en "Calcular".