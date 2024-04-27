


data <- scan("../Project Dataset/CRND0103-202404080750/2000/CRND0103-2000-NC_Asheville_8_SSW.txt", what="character")
headers <- scan("../Project Dataset/headers.txt", what="character")
headers <- headers[29:56]

data <- data.frame(matrix(data, ncol=length(headers), byrow = TRUE))
names(data) <- headers

for (i in headers[-20]){ #convert types into numerics
  data[i] <- as.numeric(data[[i]])
}

head(data)

