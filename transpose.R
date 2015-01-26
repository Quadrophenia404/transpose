print("Written by Josh Rosen")

#Enter mapping file
map <- read.delim(readline( prompt = "Please enter mapping file: "), header = TRUE, sep = "\t", quote = "\"",
                  dec = ".", fill = TRUE, row.names = 1, comment.char = "#")
#Enter reading file
read <- read.delim(readline( prompt = "Please enter otu file: "), header = TRUE, sep = "\t", quote = "\"",
                   dec = ".", fill = TRUE, row.names = 1, comment.char = "#")
#Enter new OTU file name
nameOTU<- readline( prompt = "Please enter new OTU file name: ")

#Data frame newDat is created with the specific row length equal to the column length of the mapping file
newDat<-data.frame(matrix(ncol =0 , nrow = length(colnames(map))))

#Vect creates a dummy vector of NA to appease the length needs of the data frame 
vect<- rep.int(NA, length(colnames(map)))

#Loop over the columns of the otu file
for (col in colnames(read)){
  #check if each col header is actually in the mapping file
  if (is.element(col, rownames(map))){
    #if the col header is in the mapping file, the column goes into the data frame newDat
    newDat<- cbind(newDat,t(map[col,]))
    
    #if not add a column as NA to newDat
    }else{
     newDat<- cbind(newDat, vect)
    }
 
}

#First the old OTU will be written, then a newline will be written, and then the newDat (transposed and ordered map data) will be appended

write.table(read, file = nameOTU, append = FALSE, quote = FALSE, sep = "\t",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")

write.table("\n", file = nameOTU, append = TRUE, quote = FALSE, sep = "\t",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = FALSE, qmethod = c("escape", "double"),
            fileEncoding = "")

write.table(newDat, file = nameOTU, append = TRUE, quote = FALSE, sep = "\t",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = FALSE, qmethod = c("escape", "double"),
            fileEncoding = "")

