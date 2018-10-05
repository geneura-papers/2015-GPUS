library(lubridate)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(grid)
library(stringr)
library(stopwords)

d <- readRDS(file="WoS_database.rds")

count.matches.abstract <- function(x) {
  tmp <- str_count(string = toupper(d$publication$abstract),pattern = toupper(x))
  #return(length(tmp[tmp>0]))
  return(length(tmp[tmp>0])/nrow(d$publication))
}




#Artículos por año
g_year <- ggplot(melt(table(d$publication$date.y)),aes(x=Var1,y=value)) + geom_point() + geom_line() + 
  xlab("Year") + ylab("Number of publications") 

#Tipos de artículos
type <- table(d$doc_type$doc_type)
type <- type[order(type,decreasing = TRUE)]
g_type <- ggplot(melt(head(type,n=30)),aes(x=Var1,y=value)) + geom_bar(stat="identity") + coord_flip() +
  xlab("Type") + ylab("Number of Papers")

#Autores con más publicaciones
authors <- table(d$author$display_name)
authors <- authors[order(authors,decreasing = TRUE)]
g_author <- ggplot(melt(head(authors,n=30)),aes(x=Var1,y=value)) + geom_bar(stat="identity") + 
  scale_y_continuous(limits = c(0,14)) +
  coord_flip() +
  xlab("Authors") + ylab("Number of Papers")

#Keywords más empleadas
keywords <- table(d$keyword$keyword)
keywords <- keywords[order(keywords,decreasing = TRUE)]
g_keywords <- ggplot(melt(head(keywords,n=30)),aes(x=Var1,y=value/nrow(d$publication))) + geom_bar(stat="identity") + 
  scale_y_continuous(labels = scales::percent) + 
  coord_flip() +
  xlab("Keywords") + ylab("Number of Papers")

t_keywords <- head(keywords,n=25)

t_keywords$percent <- 0

for(i in t_keywords$aw){
  t_keywords[t_keywords$aw==i,"percent"]   <- count.matches.abstract(i)
}

t <- t[order(t$percent,decreasing = TRUE),]
t$aw <- as.character(t$aw)
t$aw <- factor(t$aw, levels =  t[order(t$percent,decreasing = TRUE),"aw"])

g_aw_t <- ggplot(t,aes(x=aw,y=percent)) + geom_bar(stat="identity") + 
  scale_x_discrete() + scale_y_continuous(labels = scales::percent) +
  coord_flip() + xlab("Word in abstract") + ylab("Percentage of papers")
g_aw_t



#Palabras más empleadas en los abstract
aw <- unlist(str_split(d$publication$abstract,pattern = " "))
aw_t <- table(aw)
aw_t <- aw_t[order(aw_t,decreasing = TRUE)]
aw_d <- as.data.frame(aw_t)
aw_d$aw <- toupper(aw_d$aw)
aw_d_f<- aw_d[!aw_d$aw %in% toupper(c(stopwords("english"),"can","used","using","results","based","paper","proposed","also","large","use")),]
aw_d_f$aw <- factor(aw_d_f$aw, levels =  aw_d_f[order(aw_d_f$Freq,decreasing = TRUE),"aw"])
g_aw <- ggplot(head(aw_d_f,n=20),aes(x=aw,y=Freq)) + geom_bar(stat="identity") + 
  scale_x_discrete() +
  coord_flip() + xlab("Word in abstract") + ylab("Times")
g_aw

t <- head(aw_d_f,n=25)

t$percent <- 0

for(i in t$aw){
  t[t$aw==i,"percent"]   <- count.matches.abstract(i)
}

t <- t[order(t$percent,decreasing = TRUE),]
t$aw <- as.character(t$aw)
t$aw <- factor(t$aw, levels =  t[order(t$percent,decreasing = TRUE),"aw"])

g_aw_t <- ggplot(t,aes(x=aw,y=percent)) + geom_bar(stat="identity") + 
  scale_x_discrete() + scale_y_continuous(labels = scales::percent, limits = c(0,1)) +
  coord_flip() + xlab("Word in abstract") + ylab("Percentage of papers")
g_aw_t

#



by(data = t,INDICES = t$aw,FUN = function(x){
  print(x)
  tmp <- str_count(string = toupper(d$publication$abstract),pattern = toupper(x))  
  return(length(tmp[tmp>0])/nrow(d$publication))
})



sum(str_count(toupper(d$publication$abstract),pattern = "GPU"),na.rm = TRUE)


head(t$aw,n=25)

#return(length(tmp[tmp>0]))


count.matches("PARALLEL")

ggplot(head(aw_d_f,n=20),aes(x=aw,y=count.matches(pattern = aw))) + geom_bar(stat="identity") + 
  scale_x_discrete() +
  coord_flip() + xlab("Word in abstract") + ylab("Times")


#Palabras más empleadas
#Título








d$publication[d$publication$title>"Eff" & d$publication$title < "F","title"]


ggplot(d$publication, aes(x=date.y)) + geom_histogram(bins = 50) + scale_x_continuous() + 
  xlab("Year") + ylab("Publications in WoS") 


head(d$author)

length(unique(d$author$display_name))



#Imprimimos gráficos
ggsave(plot = g_year,file="2018_year.pdf",height = 4,width =6,scale=scale)
ggsave(plot = g_type,file="2018_type.pdf",height = 4,width =6,scale=scale)
ggsave(plot = g_author,file="2018_authors.pdf",height = 4,width =6,scale=scale)
ggsave(plot = g_keywords,file="2018_kw.pdf",height = 4,width =6,scale=scale)


grid.arrange(g_year,g_keywords,g_type, nrow=1)

