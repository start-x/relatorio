TARGET = START-X_Oculus.pdf

BIBTEX = bibtex
LATEX = pdflatex
DVIPS = dvips
PS2PDF = ps2pdf

VERSION = 0.1.0

FIXOS_DIR = fixos
FIXOS_SOURCES = informacoes.tex novosComandos.tex fichaCatalografica.tex \
		folhaDeAprovacao.tex pacotes.tex comandos.tex setup.tex	\
		listasAutomaticas.tex indiceAutomatico.tex

FIXOS_FILES = $(addprefix $(FIXOS_DIR)/, $(FIXOS_SOURCES))

EDITAVEIS_DIR = editaveis
EDITAVEIS_SOURCES = analisefinanceira.tex \
					anexos.tex \
					apendices.tex \
					conclusao.tex \
					confiabilidade.tex \
					contracapa.tex \
					desenvolvimento.tex \
					errata.tex \
					financeiro.tex \
					futuros.tex \
					gerenciamentoproduto.tex \
					gerenciamento.tex \
					impactos.tex \
					informacoes.tex \
					introducao.tex \
					marketing.tex \
					registro.tex \
					resultados.tex \
					resumo.tex \
					solucao.tex \
					testes.tex

EDITAVEIS_FILES = $(addprefix $(EDITAVEIS_DIR)/, $(EDITAVEIS_SOURCES))

MAIN_FILE = relatorio.tex
DVI_FILE  = $(addsuffix .dvi, $(basename $(MAIN_FILE)))
AUX_FILE  = $(addsuffix .aux, $(basename $(MAIN_FILE)))
PS_FILE   = $(addsuffix .ps, $(basename $(MAIN_FILE)))
PDF_FILE  = $(addsuffix .pdf, $(basename $(MAIN_FILE)))

SOURCES = $(FIXOS_FILES) $(EDITAVEIS_FILES)

.PHONY: all clean dist-clean

all: 
	@make $(TARGET)
     
$(TARGET): $(MAIN_FILE) $(SOURCES) bibliografia.bib
	# $(LATEX) $(MAIN_FILE) $(SOURCES)
	# $(BIBTEX) $(AUX_FILE)
	# $(LATEX) $(MAIN_FILE) $(SOURCES)
	# $(LATEX) $(MAIN_FILE) $(SOURCES)
	# $(DVIPS) $(DVI_FILE)
	# $(PS2PDF) $(PS_FILE)
	# @cp $(PDF_FILE) $(TARGET)
	$(LATEX) $(MAIN_FILE)
	$(BIBTEX) $(AUX_FILE) -ters
	# makeglossaries tcc
	# makeindex tcc.glo -s tcc.ist -t tcc.glg -o tcc.gls
	$(LATEX) -interaction=batchmode $(MAIN_FILE)
	$(LATEX) -interaction=batchmode $(MAIN_FILE)
	@mv $(PDF_FILE) $(TARGET)

clean:
	rm -f *~ *.dvi *.ps *.backup *.aux *.log
	rm -f *.lof *.lot *.bbl *.blg *.brf *.toc *.idx
	#rm -f *.pdf
	
dist: clean
	tar vczf start-x_latex-$(VERSION).tar.gz *

dist-clean: clean
	rm -f $(PDF_FILE) $(TARGET)
