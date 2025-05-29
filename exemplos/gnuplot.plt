#Universidade Federal do Pampa - UNIPAMPA
#Curso de Engenharia de Computação 
#Projeto Integrador I 
#Julio Saraçol

set key below;
set grid ;
set boxwidth 1 ;
set style fill solid 0.5 ;
set datafile sep ';'
set term png ;
set title 'Gráfico do Julio';
set output 'grafico.png' ;
set ylabel 'brejas'; 
set xlabel 'tempo';
plot 'saida.csv' using 2:1 with lines lw 2 title 'Tempo no Bar vs Brejas' 
