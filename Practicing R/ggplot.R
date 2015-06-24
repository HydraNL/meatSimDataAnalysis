dat1 <- data.frame(
  sex = factor(c("Female","Female","Male","Male")),
  time = factor(c("Lunch","Dinner","Lunch","Dinner"), levels=c("Lunch","Dinner")),
  total_bill = c(13.53, 16.81, 16.24, 17.42)
)

# Load the ggplot2 package
library(ggplot2)
library(reshape2)

print(
ggplot(data=dat1, aes(x=time, y=total_bill, group=1)) +
  geom_line() +
  geom_point()
)