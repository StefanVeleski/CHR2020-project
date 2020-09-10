# CHR2020 project

This repository contains all the code, datasets, and full texts files that went into the "Weak negative correlation between the present day popularity and the mean emotional valence of late Victorian novels" conference paper, accepted to the [Computational Humanities Research 2020 conference](https://www.computational-humanities-research.org/cfp/). 

## Datasets

All the metadata for the books has been taken from the [At the Circulating Library website](http://www.victorianresearch.org/atcl/), before the June 2020 update. Big thanks to Prof. Troy J. Bassett for compiling this excellent resource. It should be noted that the raw data from the ACL website was cleaned in order to keep only novels and novellas, excluding collections of poems, short stories, and novellas, as well as plays (this is because books containing several disperate stories could seriously affect the results, i.e. if a book contains three stories, and the first and third have vastly different emotional valence, the end results could be heavily skewed).

Data from [Goodreads](https://www.goodreads.com/) (used as proxy for the present day popularity of the novels) was scraped over the course of June, and slight changes in the number of ratings since then are to be expected.  For easier access, the data has been split into several datasets, for each stage of the analysis.

## Code

All of the analyses in the paper were done in R (version 3.6.3.). The packages [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html) and [ggstatsplot](https://cran.r-project.org/web/packages/ggstatsplot/index.html) were used for the exploratory analyses and data visualization, [gutenbergr](https://cran.r-project.org/web/packages/gutenbergr/index.html) was used for dealing with the full text files taken from Project Gutenberg, [syuzhet](https://cran.r-project.org/web/packages/syuzhet/index.html) was used for getting the mean sentiment of each of the noveles, and [ggpubr](https://cran.r-project.org/web/packages/ggpubr/index.html) was used for the main analyses (Pearson correlation). Big thanks to the authors of the packages!

## Text files

The full text files of the novels covered in the paper were taken from [Project Gutenberg](https://www.gutenberg.org/), after the full dataset gotten from ACL was matched against the full Project Gutenberg dataset (which contains more than 60,000 titles). All the paratext in the files (advertisements, table of contents, foreword etc.), overlooked by the gutenbergr package, was manually removed. 

Note: each of the novels are assigned numbers from 1 to 847, but there are only 846 novels in total. This is because novel number 11 — A Christmas Child: A Sketch of A Boy's Life (published in 1880 and hence outside of the scope of this paper, which focuses on novels published between 1891 and 1901) was mistaken by the fuzzy lookup function I used for Marie Corelli's Boy: A Sketch (which surprisingly does not have a Project Gutenberg page, despite being a bestseller upon publication). I haven't noticed any other such errors in the data collection process.

Any suggestions, comments, and advice are more than welcome!
