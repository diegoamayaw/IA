En esta carpeta se encontrarán los códigos para obtener datos, y generar una Deep Neural Network con la capacidad de predecir el precio de un boleto de avión.

El archivo expedia_scrape.py hace un request HTML a la página del cotizador de vuelos Expedia y guarda los resultados en el archivo master.json.

En el archivo de texto Lista_aptos_mexico.txt y dest_int.txt se encuentran los principales aeropuertos de México y los destinos internacionales principales, respectivamente. El archivo data_creating.py, ejecutado como:
```
python data_creating.py
```
Crea los parámetros con los cuales alimentar el archivo de scraping, que contiene: la combinación de cada origen con cada uno de los destinos y una fecha aleatoria generada entre el 01/06/2018 y el 31/12/2018, que se guardará en crossed_data.txt.

El archivo get_dat.sh, ejecutado en la terminal, posicionado en el directorio donde están estos archivos como:

```
sudo chmod 777 get_dat.sh
./get_dat.sh
```
generará todos los requests de los parámetros creados previamente.

Una vez teniendo los datos, se agrupan y reemplazan errores.

Por último se corre el archivo flightPricesDNN.py:
```
python flightPrices.DNN.py
```
que es el que entrena un modelo de regresión múltiple de cuatro capas y genera las predicciones de un test set, entrega el error promedio encontrado.