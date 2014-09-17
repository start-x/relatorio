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
EDITAVEIS_SOURCES = abreviaturas.tex anexos.tex  consideracoes.tex divisoes.tex  \
					elementosdotexto.tex financeiro.tex interacoes.tex materiais.tex projeto.tex \
					resumo.tex abstract.tex apendices.tex cronograma.tex eap.tex   \
					epigrafe.tex  impactos.tex introducao.tex metas.tex proposta.tex \
					simbolos.tex agradecimentos.tex aspectosgerais.tex dedicatoria.tex \
					elementosdopostexto.tex errata.tex informacoes.tex logistica.tex \
					problema.tex conclusao.tex textoepostexto.tex figura.tex requisitos.tex contracapa.tex \
					rift.tex msp430.tex unity.tex automotiva.tex energia.tex

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
	pdfinfo $(TARGET)
     
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
	makeglossaries $(basename $(MAIN_FILE))
	makeindex $(addsuffix .glo, $(basename $(MAIN_FILE))) -s $(addsuffix .ist, $(basename $(MAIN_FILE))) -t $(addsuffix .glg, $(basename $(MAIN_FILE))) -o $(addsuffix .gls, $(basename $(MAIN_FILE)))
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
