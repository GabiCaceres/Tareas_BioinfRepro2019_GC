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

el control de calidad previo al analisis de datos se evidencia en los graficos presentes en la figura 1, 2 y 3.

![Figrua 1.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/boxplot_raw_probe_qc.png?raw=true)
Figura 1.

![Figrua 2.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/boxplot_raw_treatment.png?raw=true)

![Figrua 3.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/Pairs_scatter_log2.png?raw=true)

![Figrua 4.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/P-values%20Hist.png?raw=true)

![Figrua 5.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/vennDiagram_DiffExprs.png?raw=true)

![Figrua 6.](https://github.com/GabiCaceres/Tareas_BioinfRepro2019_GC/blob/master/vennDiagram_Int.png?raw=true)

## Conclusiones

