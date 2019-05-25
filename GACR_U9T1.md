#Unidad 9 
##Tarea 1
TM. Gabriela Cáceres Rojas
Estudiante de Magíster en Genética, Universidad de Chile

### Introduccion
En el último tiempo se han generado variados métodos para el análisis del genoma de diferentes especies, entre los de secuenciación masiva uno de ellos es la secuenciación asociada a sitios de restricción del ADN (RAD-seq), el cual es usado sobre todo para identificar polimorfismos en estudios de genética de poblaciones o filogenias. Para analizar estos datos uno de las herramientas mayormente usadas es STACKS.
Los parámetros más importantes dentro de su pipeline son la cobertura mínima para crear un stack (–m), la distancia minima entre stacks (–M) y la distancia mínima entre los catalogos de loci (–n)

### Discusión
Dentro de estos parámetros los más sensibles o que generan mayor variación en los resultados finales son –m y –M, lo que se explica ya que estos se implican en la primera parte del pipeline donde se tienen datos crudos.
STACKS recomienda el uso de la metodología r80 loci para ajustar todos sus parámetros, incluidos estos dos. Esto consiste en probar el flujo de trabajo completo con datos de RAD-seq usando un rango de valores para los diferentes parámetros y compararlos con los resultados dados con el flujo de trabajo con los valores por defecto. Aquí se pretende maximizar el número de locis polimórficos representados en el 80% o más de la población (r80) y quedarnos con esos valores.
Para optimizar este flujo de trabajo, considerando el tipo de genoma y organismo que quiero estudiar después, se puede realizar en el trabajo de laboratorio secuenciación de muestras conocidas mediante RAD-seq o tomar sus datos crudos si ya se hio mediante esta metodología, con polimorfismos ya detectados por otras estrategias de secuenciación y flujos de trabajo. Con estos datos se puede realizar el flujo de trabajo de STACKS tomando valores ara –M y –m desde, por ejemplo, 1 hasta 5 y observar al final de este los resultados y cuantos datos se pierden o ganan comparándolo con los resultados obtenidos con el pipeline por defecto y también respecto a los datos ya disponibles de esas muestras.
Para realizar el cambio de valores a los parámetros –m y –M de 1 hasta 5 se debe modificar en ustacks siguiendo la combinatoria de valores representada en codigo más adelante, luego seguir con la metodología recomendada para realizar el analisis *de novo* ()
` ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 1] [-m 1]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 1] [-m 2]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 1] [-m 3]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 1] [-m 4]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 1] [-m 5]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 2] [-m 1]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 2] [-m 2]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 2] [-m 3]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 2] [-m 4]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 2] [-m 5]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 3] [-m 1]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 3] [-m 2]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 3] [-m 3]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 3] [-m 4]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 3] [-m 5]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 4] [-m 1]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 4] [-m 2]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 4] [-m 3]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 4] [-m 4]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 4] [-m 5]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 5] [-m 1]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 5] [-m 2]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 5] [-m 3]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 5] [-m 4]
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 5] [-m 5]
`
