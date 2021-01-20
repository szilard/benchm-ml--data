library(data.table)
library(lightgbm)

d_train <- fread("https://s3.amazonaws.com/benchm-ml--main/train-1m.csv")
d_test <- fread("https://s3.amazonaws.com/benchm-ml--main/test.csv")

d_all <- rbind(d_train, d_test)
d_all$dep_delayed_15min <- ifelse(d_all$dep_delayed_15min=="Y",1,0)

d_all_wrules <- lgb.convert_with_rules(d_all)       
d_all <- d_all_wrules$data

d_train <- d_all[1:nrow(d_train)]
d_test <- d_all[(nrow(d_train)+1):(nrow(d_train)+nrow(d_test))]

fwrite(d_train, "train-1m-intenc.csv")
fwrite(d_test, "test-1m-intenc.csv")



