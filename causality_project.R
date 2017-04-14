# Load the libraries 
library(vars)
library(urca)

# To install pcalg library you may first need to execute the following commands:
source("https://bioconductor.org/biocLite.R")
biocLite("graph")
biocLite("RBGL")
#library(pcalg)

# Read the input data 
data = read.csv("data.csv",header=TRUE)
head(data)
# Build a VAR model 
var.model = VAR(data,type ="const",lag.max=10,ic="SC" )



# Select the lag order using the Schwarz Information Criterion with a maximum lag of 10
# see ?VARSelect to find the optimal number of lags and use it as input to VAR()

# Extract the residuals from the VAR model 
# see ?residuals
res = resid(var.model)

# Check for stationarity using the Augmented Dickey-Fuller test 
# see ?ur.df

#perform the test for each column of the data
first_s = ur.df(res[,1],lags=1)
second_s = ur.df(res[,2],lags=1)
third_s = ur.df(res[,3],lags=1)

summary(first_s)
summary(second_s)
summary(third_s)
# Check whether the variables follow a Gaussian distribution  
# see ?ks.test

ks.test(as.numeric(res[,1]),"pnorm")
ks.test(as.numeric(res[,2]),"pnorm")
ks.test(as.numeric(res[,3]),"pnorm")
qqnorm(as.numeric(res[,1]))
qqnorm(as.numeric(res[,2]))
qqnorm(as.numeric(res[,3]))

# Write the residuals to a csv file to build causal graphs using Tetrad software
write.csv(res,file="res.csv")

# OR Run the PC and LiNGAM algorithm in R as follows,
# see ?pc and ?LINGAM 

# PC Algorithm

# LiNGAM Algorithm
