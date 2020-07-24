####Creating the Sentiment_dataset1.csv file####
library(syuzhet)
library(stringr)
filenames <- list.files("/Text files", pattern="*.txt", full.names=TRUE)
ldf <- lapply(filenames, get_text_as_string)

#ldf is a list of lists, and I needed it to be a list of vectors so
ldf_as_vector <- lapply(ldf, function(x) unlist(ldf[x], use.names = FALSE))

#This line of code uses the syuzhet package to divide the novels into sentences
sentences <- lapply(ldf_as_vector, get_sentences)

#This line extracts the sentiment of each sentence of the novels
sentiment <- lapply(sentences, get_sentiment)

#These lines calculate the mean sentiment of each novel and creates a dataframe
mean_sentiment <- lapply(sentiment, mean)
mean_sentiment_df1 <- as.data.frame(mean_sentiment)
mean_sentiment_df2 <- as.data.frame(t(mean_sentiment_df1))

#Exporting the .csv file
write.csv(mean_sentiment_df2,"/Sentiment_dataset1.csv", row.names = TRUE)

#Extracting the names of the observations
names_of_observations <- sapply(sentences, "[[", 1)
names_of_observations <- as.data.frame(names_of_observations)
write.csv(names_of_observations, file="/Names_of_observations.csv", row.names = TRUE)

#This was then cleaned up and added to the Sentiment_dataset1.csv manually in Microsoft Excel, along with columns with the Goodreads ratings and the status of the novel 
#(Bestseller, canonical, both, neither)

#Plotting the data

####Correlation plot of the full dataset####
library(ggpubr)
options(scipen=10000)
E<- ggscatter(Sentiment_dataset1, x = 'Goodreads', y = 'Sentiment',
          add = "reg.line", conf.int = TRUE,
          color = 'dimgray',
          xscale = "log10",
          cor.coef = TRUE, cor.method = "pearson",
          title = "Correlation plot (full dataset)",
          xlab = "Number of Goodreads ratings (log)", ylab = "Mean Sentiment")

####Facet wrapped graph####
options(scipen=10000)
F<- ggscatter(Sentiment_dataset1, x = 'Goodreads', y = 'Sentiment',
          add = "reg.line", conf.int = TRUE,
          color = 'Status',
          xscale = "log10",
          cor.coef = TRUE, cor.method = "pearson",
          title = "Correlation plot (faceted by status)",
          xlab = "Number of Goodreads ratings (log)", ylab = "Mean Sentiment", 
          facet.by = 'Status')

#combining the two graphs
ggarrange(E, F, 
          labels = c("1", "2"),
          ncol = 1, nrow = 2)


####Power law plots for CHR2020 article####
library(ggpubr)

#overall non log
options(scipen=10000)
df <- Popularity_and_rank
A<- ggplot(df, aes(x=df$Rank, y=df$`Number of Ratings`)) +
    geom_point(alpha = 0.8, size = 3, color = 'dimgray') +
    labs(title = "Full dataset", 
         x = "Rank", 
         y ="Number of Ratings")

#overall
options(scipen=10000)
B <- ggplot(df, aes(x=df$Rank, y=df$`Number of Ratings`)) +
    geom_point(alpha = 0.8, size = 3, color = 'dimgray') +
    scale_x_log10()+
    labs(title = "Full dataset (log)", 
         x = "Rank", 
         y ="Number of Ratings")
#Merging all of them in a single graph
ggarrange(A, B,
          labels = c("1", "2"),
          ncol = 2, nrow = 1)

####Boxplot of Gutenberg IDs####
set.seed(123)

options(scipen=10000)

library("ggstatsplot")
ggbetweenstats(data = GutenbergIDboxplotdata, 
               x = Factor,
               y = `Number of ratings`,
               xlab = "Gutenberg page?",
               ylab = "Number of Ratings (log)") +
    scale_y_log10()

####Boxplot of bestsellers and different canonical editions####
set.seed(123)

options(scipen=10000)

ggbetweenstats(data = box_plot_data1, 
               x = Type,
               y = `Number of Ratings`,
               ylab = "Number of Ratings (log)",
               outlier.tagging = FALSE) +
    scale_y_log10()

####Boxplot of sentiment and status of the novels####
set.seed(123)
ggbetweenstats(data = Sentiment_dataset1, 
               x = Status,
               y = Sentiment,
               ylab = "Mean sentiment",
               outlier.tagging = TRUE,
               outlier.label = Title)
