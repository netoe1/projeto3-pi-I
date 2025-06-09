# Este script Gnuplot foi documentado e comentado com a ajuda do Gemini.

# ---------- Definições de Variáveis ----------

# -> Configurações de Saída do Gráfico
RES_X = 1380;    # Largura da imagem em pixels
RES_Y = 768;     # Altura da imagem em pixels

# -> Configurações de Dados
CSV_SEPARADOR = ';'; # Separador de colunas no arquivo CSV (ponto e vírgula)
CSV_PROP_X = 1;      # Coluna para o eixo X (Entradas)
CSV_PROP_Y = 2;      # Coluna para o eixo Y (Tempo)

# -> Títulos do Gráfico e Rótulos dos Eixos
TITULO_GRAFICO = 'Análise de Algoritmos - Médias';
X_TITULO = 'Entradas(n)';
Y_TITULO = 'Tempo(s)';

# Títulos para as legendas das linhas
TITULO_BUBBLE_C = 'Bubble Sort (C)';
TITULO_MERGE_C = 'Merge Sort (C)';
TITULO_BUBBLE_PY = 'Bubble Sort (Python)';
TITULO_MERGE_PY = 'Merge Sort (Python)';

# -> Nomes dos Arquivos de Entrada (CSV)
FILE_BUBBLE_C = "media_bubble_c.csv";
FILE_BUBBLE_PY = "media_bubble_python.csv";
FILE_MERGE_C = "media_merge_c.csv";
FILE_MERGE_PY = "media_merge_python.csv";

# -> Saída do Gráfico
ARQUIVO_SAIDA = TITULO_GRAFICO . '.png'; # Concatena o título com a extensão

# -> Parâmetros de Estilo
LARGURA_LINHA = 2; # Largura padrão das linhas

# Fontes (ajustadas para a resolução de 1280x768)
FONTE_TITULO = 20;
FONTE_LABEL = 16;
FONTE_TICS_KEY = 14;

# Ranges dos Eixos
X_MIN = 10;
X_MAX = 1000000; # Corrigido para 10^6
Y_MIN = 1e-6;    # Tempo mínimo visível

# ---------- Script .plot (Comandos Gnuplot) ----------

set key below;
set grid ;
set boxwidth 1 ;

# Usando a variável definida para o separador de dados
set datafile sep CSV_SEPARADOR;

# Configuração do terminal de saída (PNG) e resolução
set term png size RES_X,RES_Y;

# Definição do arquivo de saída
set output ARQUIVO_SAIDA ;

# Definição dos títulos do gráfico e dos eixos com fontes
set title TITULO_GRAFICO font ",".FONTE_TITULO;
set xlabel X_TITULO font ",".FONTE_LABEL;
set ylabel Y_TITULO font ",".FONTE_LABEL;

# Definição das fontes para os tiques e a legenda
set xtics font ",".FONTE_TICS_KEY;
set ytics font ",".FONTE_TICS_KEY;
set key font ",".FONTE_TICS_KEY;

# Definição das escalas logarítmicas para ambos os eixos
set logscale x;
set logscale y;

# Definição dos ranges dos eixos
set xrange [X_MIN:X_MAX];
set yrange [Y_MIN:200]; # '*' para que o Gnuplot determine o máximo automaticamente
set ytics 1e-6, 1e2, 1e6

# Comando PLOT para todas as linhas
plot FILE_BUBBLE_C  using  CSV_PROP_X:CSV_PROP_Y  with linespoints lw LARGURA_LINHA title TITULO_BUBBLE_C, \
     FILE_MERGE_C   using  CSV_PROP_X:CSV_PROP_Y with linespoints lw LARGURA_LINHA  title TITULO_MERGE_C, \
     FILE_BUBBLE_PY using  CSV_PROP_X:CSV_PROP_Y  with linespoints lw LARGURA_LINHA  title TITULO_BUBBLE_PY, \
     FILE_MERGE_PY  using  CSV_PROP_X:CSV_PROP_Y  with linespoints lw LARGURA_LINHA  title TITULO_MERGE_PY
