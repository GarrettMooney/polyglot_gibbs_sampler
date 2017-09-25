.PHONY : all
all : data sampler.html

# sampler data
.PHONY : data
data : datac.tab datapy.tab data.tab

gibbs : gibbs.c
	gcc -O4 $< -lgsl -lgslcblas -lm -o $@

datac.tab : gibbs
	./$< > $@

datapy.tab : gibbs.py
	python3 $< > $@

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
