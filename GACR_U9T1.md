# Unidad 9 
## Tarea 1

TM. Gabriela Cáceres Rojas

Estudiante de Magíster en Genética, Universidad de Chile


### Introduccion

En el último tiempo se han generado variados métodos para el análisis del genoma de diferentes especies, entre los de secuenciación masiva uno de ellos es la secuenciación asociada a sitios de restricción del ADN (RAD-seq), el cual es usado sobre todo para identificar polimorfismos en estudios de genética de poblaciones o filogenias. Para analizar estos datos uno de las herramientas mayormente usadas es STACKS, que permite realizar óptimamente el ensamblado de lecturas de longitud corta. Los parámetros más importantes dentro de su pipeline son la cobertura mínima para crear un stack (–m), la distancia minima entre stacks (–M) y la distancia mínima entre los catalogos de loci (–n).

### Discusión

Dentro de estos parámetros los más sensibles o que generan mayor variación en los resultados finales son –m y –M, lo que se explica ya que estos parametros se contienen dentro de ustacks y se implican en la primera parte del pipeline donde se tienen datos crudos, con estos parametros se realiza el ensamble y se contruye *de novo* los loci de la muestra.

la cobertura minima para crear un stack se refiere al número minimo de reads identicos que pueden conformar y considerar un stack, su valor por defecto es de 3, este valor puede ser ajustado de acuerdo a la calidad de la secuenciación previa, pero valores muy pequeños ueden incluir errores de secuenciacion como un alelo y valores muy altos para este parámetro puede obviar un alelo y eliminarlo posteriormente.

la distancia minima entre stacks se refiere a la cantidad máxima de nucleotidos diferentes pueden tener dos stacks para unirlos, su valor por defecto en ustacks es de 2 nucleótidos. 

STACKS recomienda el uso de la metodología r80 loci para ajustar todos sus parámetros, incluidos estos dos. Esto consiste en probar el flujo de trabajo completo con datos de RAD-seq usando un rango de valores para los diferentes parámetros y compararlos con los resultados dados con el flujo de trabajo con los valores por defecto. Aquí se pretende maximizar el número de loci polimórficos representados en el 80% o más de la población (r80) y quedarnos con esos valores.

Para optimizar este flujo de trabajo, considerando el tipo de genoma y organismo que quiero estudiar después, se puede realizar en el trabajo de laboratorio secuenciación de muestras conocidas mediante RAD-seq o tomar sus datos crudos si ya se hio mediante esta metodología, con polimorfismos ya detectados por otras estrategias de secuenciación y flujos de trabajo. Con estos datos se puede realizar el flujo de trabajo de STACKS tomando valores ara –M y –m desde, por ejemplo, 1 hasta 5 y observar al final de este los resultados y cuantos datos se pierden o ganan comparándolo con los resultados obtenidos con el pipeline por defecto y también respecto a los datos ya disponibles de esas muestras.

Para realizar el cambio de valores a los parámetros –m y –M de 1 hasta 5 se debe modificar en ustacks siguiendo la combinatoria de valores representada en codigo más adelante, luego seguir con la metodología recomendada para realizar el analisis *de novo* donde se usan las siguientes herramientas en orden: ustacks (modificado en este caso), cstacks, sstacks, tsv2bam, gstacks y finalmente populations.

`
ustacks –f [RUTA_ARCHIVO1] -o [RUTA_OUTPUT] [-M 1] [-m 1]
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

### Referencias
Paris, J. R., Stevens, J. R., & Catchen, J. M. (2017). Lost in parameter space: a road map for stacks . Methods in Ecology and Evolution, 8(10), 1360–1373. doi:10.1111/2041-210x.12775 
Mastretta-Yanes, A., Arrigo, N., Alvarez, N., Jorgensen, T. H., Piñero, D., & Emerson, B. C. (2014). Restriction site-associated DNA sequencing, genotyping error estimation andde novoassembly optimization for population genetic inference. Molecular Ecology Resources, 15(1), 28–41. doi:10.1111/1755-0998.12291 
J. Catchen, P. Hohenlohe, S. Bassham, A. Amores, and W. Cresko. Stacks: an analysis tool set for population genomics. Molecular Ecology. 2013. [reprint]
J. Catchen, A. Amores, P. Hohenlohe, W. Cresko, and J. Postlethwait. Stacks: building and genotyping loci de novo from short-read sequences. G3: Genes, Genomes, Genetics, 1:171-182, 2011. [reprint]
