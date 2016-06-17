library(ggplot2)
library(ggthemes)

slices <- c(106, 59)
lbls <- c("Yes", "No")
slices.df <- data.frame( real.world = lbls, number=slices)
ggplot(slices.df,aes(x=real.world,y=number,fill=real.world))+geom_bar(stat="identity")+labs(x="Real world problems?")+theme_tufte()
ggsave("realproblem.png",width=4,height=3)
#pie(slices, labels = lbls)

slices <- c(108, 35,10,12)
lbls <- c("GA", "GP","DE","Others")
slices.df <- data.frame( real.world = lbls, number=slices)
ggplot(slices.df,aes(x=real.world,y=number,fill=real.world))+geom_bar(stat="identity")+theme_tufte()+labs(x="Evolutionary algorithm type")
ggsave("algorithmtype.png",width=4,height=3)


slices <- c(1, 69,95)
lbls <- c("Chapter", "Journal","Conference")
slices.df <- data.frame( real.world = lbls, number=slices)
ggplot(slices.df,aes(x=real.world,y=number,fill=real.world))+geom_bar(stat="identity")+theme_tufte()+labs(x="Paper type")
ggsave("papertype.png",width=4,height=3)

