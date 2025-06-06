#!/bin/bash

# variáveis para armazenar os parâmetros de entrada
linguagem=""
algoritmo=""
num_execucoes=""
tamanho=""
#  processa os parâmetros de entrada
while getopts "l:a:n:t:" opt; do
  case $opt in
    l) linguagem="$OPTARG";;
    a) algoritmo="$OPTARG";;
    n) num_execucoes="$OPTARG";;
    t) tamanho="$OPTARG";;
    \?) echo "Opção inválida: -$OPTARG" >&2; exit 1;;
  esac
done

if [ -z "$linguagem" ] || [ -z "$algoritmo" ] || [ -z "$num_execucoes" ] || [ -z "$tamanho" ]; then
    echo "Erro: Todos os parâmetros (-l, -a, -n, -t) são obrigatórios."
    echo "Uso: $0 -l <linguagem> -a <algoritmo> -n <num_execucoes> -t <tamanho_entrada>"
    exit 1
fi

arquivo_media="media_${algoritmo}_${linguagem}.csv"
soma_dos_tempos=0

echo "Executando $algoritmo em $linguagem para N=$num_execucoes, Tamanho=$tamanho vezes..."

# tava dando problema com a extração do tempo para o bc, a solução foi aplicar esse regex para fazer uma validação.
REGEX_NUMERO_VALIDO='^[+-]?([0-9]*\.)?[0-9]+([eE][-+]?[0-9]+)?$'

for i in $(seq 1 $num_execucoes)
do
    saida_programa=""
    tempo_extraido=""

    if [ "$linguagem" == "python" ]; then
        saida_programa=$(python3 "${algoritmo}.py" $tamanho)
    elif [ "$linguagem" == "c" ]; then
        saida_programa=$("./${algoritmo}" $tamanho)
    fi
    # para debugar pois estava com muitos problemas na extração do tempo
    echo "DEBUG [Iteração $i]: Saida completa do programa ($algoritmo $linguagem T$tamanho): [$saida_programa]"

    tempo_extraido=$(echo "$saida_programa" | cut -d';' -f2)
    
    echo "DEBUG: [Iteração $i]: Tempo extraído (antes de verificar): [$tempo_extraido]"

    if [[ "$tempo_extraido" =~ $REGEX_NUMERO_VALIDO ]] && [ -n "$tempo_extraido" ] ; then
        echo "DEBUG: [Iteração $i]: Tempo extraído É VÁLIDO para bc: [$tempo_extraido]"
        soma_dos_tempos_anterior=$soma_dos_tempos
        soma_dos_tempos=$(echo "$soma_dos_tempos_anterior + $tempo_extraido" | LC_ALL=C bc)
        echo "DEBUG: [Iteração $i]: bc executou: '$soma_dos_tempos_anterior + $tempo_extraido'. Nova soma: [$soma_dos_tempos]"
    else
        echo "AVISO [Iteração $i]: Tempo extraído inválido ou vazio: [$tempo_extraido]. Saida do programa: [$saida_programa]"
    fi
done

echo "DEBUG: Fim do loop. Soma total dos tempos: [$soma_dos_tempos]"

if [ "$num_execucoes" -gt 0 ] && [[ "$soma_dos_tempos" =~ $REGEX_NUMERO_VALIDO ]] && [ -n "$soma_dos_tempos" ]; then
    media_final_raw=$(echo "scale=10; $soma_dos_tempos / $num_execucoes" | LC_ALL=C bc)
    # formatar a saída do resultado caso ele seja menos que 1.
    if [[ "$media_final_raw" == .* ]]; then
        media_final_formatada="0${media_final_raw}"
    else
        media_final_formatada="$media_final_raw"
    fi
else
    echo "ERRO: Não foi possível calcular a média. num_execucoes=[$num_execucoes], soma_dos_tempos=[$soma_dos_tempos]"
    media_final_formatada="ERRO_NO_CALCULO"
fi

if [ ! -f "$arquivo_media" ]; then
    echo "tamanho_entrada;tempo_medio" > "$arquivo_media"
fi
echo "$tamanho;$media_final_formatada" >> "$arquivo_media"

echo "Tempo médio para N=$tamanho: $media_final_formatada salvo em $arquivo_media"
