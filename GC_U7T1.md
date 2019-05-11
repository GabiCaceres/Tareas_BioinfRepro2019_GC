# Unidad 7 
## Tarea 1

TM. Gabriela Cáceres Rojas

Estudiante de Magíster en Genética, Universidad de Chile

### Introduccion

La tecnología de Microarray es la herramienta de primera línea al realizar experimentos de expresión génica, este permite analizar simultáneamente muestras con distintos tratamientos o condiciones y la expresión de miles de genes usando el mRNA. Esta tecnología se basa en la hibridación del mRNA con fluoróforos, esto emite una señal lumínica que es captada y luego la imagen debe ser procesada a una matriz numérica para hacer posible el análisis de estos datos. Esto se realiza mediante diferentes softwares bioinformáticos donde el más usado es R y ciertos paquetes de BioConductor.

Para esta tarea el objetivo es realizar el análisis de expresión diferencial usando R, para ello se descargó los datos de microarray de la muestra GSE15354 desde GEO (NCBI), estos datos corresponden a un experimento en ratones donde se midió la expresión génica de su tejido cardiaco. Para ello se utilizaron 16 ratones en total de 2 cepas: 8 de C57BL/6J (de ahora en adelante “B”) y 8 de C57BL/6J-chrY<A/J/NaJ (de ahora en adelante “BY”), a las 3-4 semanas de edad de estos ratones, de cada grupo 4 fueron castrados (“C”) y 4, si bien pasaron por el procedimiento quirúrgico, no se les castró finalmente (“I”), finalmente a las 12 semanas de vida se extrajo el tejido cardiaco de estos para aislar mRNA, se realizó la técnica de microarray con la tecnología de BeadChips Illumina MouseRef-8 v2.0, este tiene ocho microarreglos con 25,697 sondas cada uno. En el estudio original se buscaba evaluar si el genotipo del raton (B o BY) influia sobre el tamaño de los miocardiocitos y si esto afectaba, a su vez, los niveles de testosterona.

### Metodología

Para realizar la presente tarea se utilizó R v 3.5.1 y RStudio v 1.1.456 y los paquetes limma, maanova, org.Mm.eg.db, preprocessCore y topGO de BioConductor, además se utilizó el archivo de datos “GSE15354_raw.txt” descargado desde este [enlace](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE15354), a este se le eliminó manualmente el encabezado con un procesador de texto plano para poder procesarlo posteriormente.

Se siguió el [“Tutorial de análisis de expresión diferencial en R”](https://github.com/AliciaMstt/BioinfinvRepro/blob/master/Unidad7/Tutorial_de_expresion_diferencial_en_R.md) con pequeñas modificaicones que se detallan a continuación:
1) Se establecio la tasa de falsos descubrimientos (FDR) en 0,19

``> fdr_th     <- 0.19``

2) Se cargo el archivo “GSE15354_raw.txt” modificado señalado anteriormente (guardado como *_2.txt) y se cabio el nombre de la columna ID_REF por ProbeID con el paquete dplyr

``Data.Raw  <- read.delim("GSE15354_raw_2.txt", sep = "\t")
Data.Raw <- dplyr::rename(Data.Raw, ProbeID = ID_REF)``

3) Se modifico el filtrado de sondas, donde se selecciono una sonda si el recuento era ≥ 1 (25% de las réplicas) en cualquier grupo experimental.

``> present  <- apply(detected_per_group >= 1, 1, any)``

4) En el caso del analisis por permutaciones, este se realizó con 500 permutaciones.

``> test.cmat <- matest(madata, fit.fix, term="Group", Contrast=cmat, n.perm=500, test.type = "ttest", shuffle.method="sample", verbose=TRUE)``

5) Y en el resumen por gen. Se selecciona un gen si se selecciona cualquier transcripto.

``genes.int <- tapply(probes.int, results$EntrezID, all)``

## Resultados

el control de calidad previo al analisis de datos se evidencia en los graficos presentes en las figuras 1, 2 y 3.

![Figura 1.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/boxplot_raw_probe_qc.png?raw=true)
Figura 1. Diagramas de cajas y bigotes de datos sin procesar segun calidad de la sonda. en rojo se muestras las sondas con calidad "buena" o superior y en verde las sondas con calidad "mala".

![Figura 2.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/boxplot_raw_treatment.png?raw=true)
Figura 2. Diagramas de cajas y bigotes de datos sin procesar según tratamiento. en Verde se muestra el tratamiento sin castrar (I) y en rojo el castrado (C)

![Figura 3.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/Pairs_scatter_log2.png?raw=true)
Figura 3. Diagramas de dispersión de datos sin procesar en escala log2.

el resultado de las permutaciones se puede observar en la figura 4.

![Figura 4.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/P-values%20Hist.png?raw=true)
Figura 4. Distribución de p-values en muestra y permutaciones. Ptab se refiere a los valores p de las muestras (tabular), Pvalperm son los valores p obtenidos de la prueba de permutación, F1 son los valores obtenido de una pueba de F convencional y Fs de una prueba de F con contracción de la varianza.

el análisis de genes diferencialmente expresados se puede apreciar en las figuras 5 y 6.

![Figura 5.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/vennDiagram_DiffExprs.png?raw=true)
Figura 5. Diagrama de Venn de genes diferencialmente expresados segun interacción, genotipo o tratamiento.

![Figura 6.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/vennDiagram_Int.png?raw=true)
Figura 6. Diagrama de Venn de genes diferencialmente expresados. A la izquierda se encuentra segun su tratamiento (C o I) y e la derecha se encuentra segun el genotipo (B o BY)

## Conclusiones

el preanalisis de control de calidad en microarray es un paso importante para determinar si estos son aptos o no para el analisis posterior, en este caso se puede apreciar que los datos de microarray obtenidos cumplen con la calidad minima y estan en optimas condiciones para ser procesados y filtrados luego.

la prueba de permutacion muestra que la distribucion de los valores p obtenidos de la muestra problema y de las permutaciones es muy similar, por lo que nos dice que nuestros valores obtenidos probablemente si sean producto del tratamiento.

los diagramas de venn demuestran que si existen genes diferencialmente expresados. en el primer grafico se observa que hay una mayor cantidad de genes diferencialmente expresados versus los que no se detectaron como diferencialmente expresados, ya demás que estos son mas segun genotipo o tratamiento por si solos que por interaccion. En la figura 6 se observa que, segun tratamiento, hay una mayor cantidad de genes diferencialmente expresados en los castrados versus los ratones sin castrar y, según el genotipo de estos, los ratones BY presentan mayor cantidad de genes diferencialmente expresados versus los B. 

## Referencias

Llamas B, Verdugo RA, Churchill GA, Deschepper CF. 2009. Chromosome Y variants from different inbred mouse strains are linked to differences in the morphologic and molecular responses of cardiac cells to postpubertal testosterone. BMC Genomics. 2009 Apr 7;10:150. doi: 10.1186/1471-2164-10-150 (Primera autoría compartida) ISI 4.4 ISSN 1471-2105


