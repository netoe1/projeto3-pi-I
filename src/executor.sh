#!/bin/bash

# --- Parâmetros Configuráveis ---
LINGUAGENS=("python" "c")
ALGORITMOS=("bubble" "merge") 
TAMANHOS_ENTRADA=(10 100 1000 10000) 
NUM_EXECUCOES_MEDIA=10 # Número de vezes que cada combinação será executada para a média [cite: 11]

# Caminho para o script executor (assumindo que está no mesmo diretório)
EXECUTOR="./executaScriptShell.sh"

# --- Verificação do Executor ---
if [ ! -f "$EXECUTOR" ]; then
    echo "Erro: Script executor '$EXECUTOR' não encontrado."
    exit 1
fi
if [ ! -x "$EXECUTOR" ]; then
    echo "Erro: Script executor '$EXECUTOR' não tem permissão de execução."
    echo "Execute: chmod +x $EXECUTOR"
    exit 1
fi

echo "=== INICIANDO PROCESSO ==="

for lang in "${LINGUAGENS[@]}"; do
    for algo in "${ALGORITMOS[@]}"; do
        for tamanho in "${TAMANHOS_ENTRADA[@]}"; do
            echo "-----------------------------------------------------"
            echo "Executando: Linguagem=$lang, Algoritmo=$algo, N=$NUM_EXECUCOES_MEDIA, Tamanho=$tamanho"
            
            # Chama o script executor
            "$EXECUTOR" -l "$lang" -a "$algo" -n "$NUM_EXECUCOES_MEDIA" -t "$tamanho"
            
            sleep 2 
            echo "Concluído."
        done
    done
done

echo "-----------------------------------------------------"
echo "=== PROCESSO CONCLUÍDO ==="
