.PHONY : all
all : data sampler.html

# sampler data
.PHONY : data
data : datac.tab datajs.tab datapy.tab datajl.tab data.tab

gibbs : gibbs.c
	gcc -O4 $< -lgsl -lgslcblas -lm -o $@

datac.tab : gibbs
	./$< > $@

datajs.tab : gibbs.js
	node $< > $@

datapy.tab : gibbs.py
	python3 $< > $@

datajl.tab : gibbs.jl
	julia $< > $@

data.tab : gibbs.R
	Rscript $< > $@

# description of sampler
sampler.html : sampler.Rmd
	Rscript -e "library(rmarkdown); render('$<')"

.PHONY: cleanall cleangibbs cleandata cleansampler
cleanall : cleangibbs cleandata cleansampler
	rm Rplots.pdf

cleangibbs :
	rm gibbs

cleandata :
	rm *.tab

cleansampler :
	rm *.html
