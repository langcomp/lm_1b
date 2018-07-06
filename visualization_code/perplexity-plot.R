library(tidyverse)

# order factors by value (default is alphabetical)
perplexity$Language_Model <- factor(perplexity$Language_Model, 
                                    levels=perplexity$Language_Model[order(-perplexity$Perplexity)])
# substitute line breaks between words in factors
levels(perplexity$Language_Model) <- gsub(" ", "\n", levels(perplexity$Language_Model))
# column chart + text
ggplot(perplexity, aes(x=Language_Model, y=Perplexity)) +
  geom_col() +
  xlab("Language Model") + geom_text(aes(label=Perplexity), vjust=-.5) +
  scale_y_continuous(limits=c(0,325))
