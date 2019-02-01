#!/bin/bash
#Script para bajar 5 secuencias del segmento M de distintas cepas de Hantavirus desde NCBI (Nucleotide)
#Crear directorio para guardar los archivos de hantavirus y luego cambiar a ese directorio
mkdir -p Hantavirus
cd ./Hantavirus
#Bajar secuencias de Hantavirus desde NCBI
curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&rettype=fasta&id=23464593,38371712,38371718,38371723,255983860" > Hantavirus_Cepas.txt
#Revisar las secuencias bajadas de Hantavirus desde NCBI
grep ">" ./Hantavirus_Cepas.txt
#Obtener números de líneas de los nombres
grep -n ">" ./Hantavirus_Cepas.txt
#separar cepas en distintos archivos
sed '1,55!d' ./Hantavirus_Cepas.txt > Andes.txt
sed '56,109!d' ./Hantavirus_Cepas.txt > Hantaan.txt
sed '110,164!d' ./Hantavirus_Cepas.txt > Puumala.txt
sed '165,219!d' ./Hantavirus_Cepas.txt > SinNombre.txt
sed '220,274!d' ./Hantavirus_Cepas.txt > RioMamore.txt
#retornar cantidad de veces encontradas de la secuencia "TGCA" en las distintas cepas
for c in Andes Hantaan Puumala SinNombre RioMamore; do grep -c "TGCA" $c.txt; done
