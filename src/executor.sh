#!/bin/bash

# --- Parâmetros Configuráveis ---
LINGUAGENS=("c" "python")
ALGORITMOS=("merge" "bubble") 
TAMANHOS_ENTRADA=(10 100 1000 10000 100000 1000000)
NUM_EXECUCOES_MEDIA=10 # Número de vezes que cada combinação será executada para a média

# Caminho para o script executor (assumindo que está no mesmo diretório)
EXECUTAR_MEDIAS="./geraMedias.sh"
EXECUTAR_GRAFICOS="./graficos.plot"
MODO=""

while getopts ":mg" opt; do
    case ${opt} in
    	m) MODO="MEDIA";;
    	g) MODO="GRAFICO";;
 	\?) echo "Opção inválida: -$OPTARG" >&2;;
    esac
done   	

if [ -z "$MODO" ]; then
    echo "Erro: Selecione um modo de execução! -m (média), -g (gráfico)."
    exit 1
fi


if [ "$MODO" = "MEDIA" ]; then # modo para gerar as médias
    echo "=== INICIANDO GERAÇÃO DE MÉDIAS ==="

    # Verificação do executor de médias 
    if [ ! -f "$EXECUTAR_MEDIAS" ]; then
        echo "Erro: Script '$EXECUTAR_MEDIAS' não encontrado."
        exit 1
    fi
    if [ ! -x "$EXECUTAR_MEDIAS" ]; then
        echo "Erro: Script '$EXECUTAR_MEDIAS' não tem permissão de execução."
        exit 1
    fi

    for lang in "${LINGUAGENS[@]}"; do
        for algo in "${ALGORITMOS[@]}"; do
            for tamanho in "${TAMANHOS_ENTRADA[@]}"; do
                echo "-----------------------------------------------------"
                echo "Executando: Linguagem=$lang, Algoritmo=$algo, N=$NUM_EXECUCOES_MEDIA, Tamanho=$tamanho"

                # Chama o script executor de médias
                "$EXECUTAR_MEDIAS" -l "$lang" -a "$algo" -n "$NUM_EXECUCOES_MEDIA" -t "$tamanho"

                sleep 1
                echo "Concluído."
            done
        done
    done

    echo "-----------------------------------------------------"
    echo "=== GERAÇÃO DE MÉDIAS CONCLUÍDA ==="

elif [ "$MODO" = "GRAFICO" ]; then # modo para o gráfico gnuplot
    echo "=== INICIANDO GERAÇÃO DE GRÁFICOS ==="

    # Verificação do .plot
    if [ ! -f "$EXECUTAR_GRAFICOS" ]; then
        echo "Erro: Script '$EXECUTAR_GRAFICOS' não encontrado."
        exit 1
    fi

    # Chama o script que gera os gráficos das médias geradas em .csv
    gnuplot "$EXECUTAR_GRAFICOS"

    echo "=== GERAÇÃO DE GRÁFICOS CONCLUÍDA ==="
fi

