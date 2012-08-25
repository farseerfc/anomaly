default: 169

INTERACTION=errorstopmode
SIZE=14pt
MAIN=anomaly
LATEX=latexmk -xelatex 

all: 169 43 

dist:
	mkdir -p output
	cp *.pdf{,.info} output/

169: $(MAIN).tex
	echo "\\$(INTERACTION)" >$(MAIN).169.tex
	echo "\\documentclass[aspectratio=169,$(SIZE),$@]{beamer}" >>$(MAIN).$@.tex
	echo "\\setbeameroption{notes on second screen}"  >>$(MAIN).$@.tex
	cat 169.tex >>$(MAIN).$@.tex
	echo "\\input{$(MAIN).tex}" >>$(MAIN).$@.tex
	$(LATEX) $(MAIN).$@ 
	makebeamerinfo -t sane $(MAIN).$@.pdf
    
43: $(MAIN).tex
	echo "\\$(INTERACTION)" >$(MAIN).$@.tex
	echo "\\documentclass[aspectratio=43,$(SIZE),$@]{beamer}" >>$(MAIN).$@.tex
	echo "\\setbeameroption{notes on second screen}"  >>$(MAIN).$@.tex
	cat 43.tex >>$(MAIN).$@.tex
	echo "\\input{$(MAIN).tex}" >>$(MAIN).$@.tex
	$(LATEX) $(MAIN).$@ 
	makebeamerinfo -t sane $(MAIN).$@.pdf

notes: $(MAIN).tex
	echo "\\$(INTERACTION)" >$(MAIN).notes.tex
	echo "\\documentclass[aspectratio=169,$(SIZE),handout]{beamer}" >>$(MAIN).notes.tex
	echo "\\usepackage{pgf,pgfpages}"
	echo "\\setbeameroption{notes on second screen}"  >>$(MAIN).notes.tex
	echo "\\input{$(MAIN).tex}" >>$(MAIN).notes.tex
	$(LATEX) $(MAIN).notes

article: $(MAIN).tex
	echo "\\$(INTERACTION)" >$(MAIN).article.tex
	echo "\\documentclass[adobefonts]{ctexart}" >>$(MAIN).article.tex
	echo "\\usepackage[a4paper,vmargin={22mm,22mm},hmargin={22mm,30mm}]{geometry}" >>$(MAIN).article.tex
	echo "\\usepackage{beamerarticle,xeCJK,url,hyperref}" >>$(MAIN).article.tex
	#echo "\\begin{CJK}" >>$(MAIN).article.tex
	echo "\\input{$(MAIN).tex}" >>$(MAIN).article.tex
	#echo "\\end{CJK}" >>$(MAIN).article.tex
	$(LATEX) $(MAIN).article.tex

pure:
	rm -fv $(MAIN).{draft,handout,beamer,trans,second,notes,169,43}.{tex,aux,log,nav,out,snm,toc,tex,vrb,fls,bbl,blg,fdb\_latexmk}
	rm -fv $(MAIN).article.{tex,aux,log,nav,out,snm,toc,tex,vrb,fls,bbl,blg,fdb\_latexmk}
	rm -fv $(MAIN).{aux,log,nav,out,snm,toc,vrb,bbl,blg,fdb\_latexmk}
	rm -fv texlog texput.log missfont.log

clean:  pure
	rm -fv $(MAIN).{draft,handout,beamer,article,trans,second,notes,169,43}.pdf{,.info}
	rm -fv $(MAIN).article.pdf
	rm -fv $(MAIN).pdf


