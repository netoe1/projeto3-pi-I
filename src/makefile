BUBBLE_C = bubblesort.c
MERGE_C = mergesort.c
BUBBLE_PY = bubble.py
MERGE_PY = merge.py

scripts: # Compilar os scripts
	gcc -o bubble ${BUBBLE_C}
	gcc -o merge ${MERGE_C}
clean: # Limpar os arquivos objeto da linguagem C
	rm -f *.obj *.o   
	rm -f bubble merge
	rm -f ./*.csv
	rm -f ./*.png
graphics: # Gerar apenas o plot dos arquivos.csv
	./executor.sh -g

create_logs:
	./executor.sh -m >> logsexemplo.txt
run: # Para rodar todo o projeto
	make clean
	make scripts
	./executor.sh -m
	./executor.sh -g
	

	