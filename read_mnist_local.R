read_mnist_local <- function(data_dir = "/home/dinesh/MNIST_data/"){
  mnist <- list(train=list(images=c(), 
                           labels=c()), 
                test=list(images=c(), 
                          labels=c()))
  
  for (ttt in c("train", "t10k"))  {
    # Open connection to read image file
    fn <- paste0(ttt,"-images-idx3-ubyte.gz")
    
    file <- paste0(data_dir,fn)
    
    # create binary connection to file
    conn <- gzfile(file, open = "rb")
    
    magic <- readBin(conn, 'integer', n = 1, size = 4, endian = "big")  # magic bytes
    typ <- bitwAnd(bitwShiftR(magic,8), 0x000000ff)   # should be 8 => unsigned byte    
    ndm <- bitwAnd(magic, 0x000000ff)                 # dimensionality (should be 3)
    
    # Read dimensions
    dim <- readBin(conn, 'integer', n = ndm, size = 4, endian = "big")
    
    # Read unsigned bytes
    data <- readBin(conn, 'integer', n = prod(dim), size = 1, signed = FALSE)
    
    # store "t10k" data to "test" list
    tt <- ttt
    if(tt == "t10k")
      tt <- "test"
    
    # Save as matrix, row is image number, col is the image as 
    # single-dimensional 28 x 28 array of real.
    mmm <- matrix(data, nrow=dim[1], byrow = TRUE) 
    mnist[[tt]][["images"]] <- mmm
    close(conn)
    
    # Open connection to read label file  
    fn <- paste0(ttt,"-labels-idx1-ubyte.gz")
    
    file <- paste0(data_dir,fn)
    
    conn <- gzfile(file, open = "rb")
    
    magic <- readBin(conn, 'integer', n = 1, size = 4, endian = "big")  # magic bytes
    nlb <- readBin(conn, 'integer', n = 1, size = 4, endian = "big")    # number of labels
    
    # Read unsigned bytes
    data <- readBin(conn, 'integer', n = nlb, size = 1, signed = FALSE)
    
    # Store as integer
    mnist[[tt]][["labels"]] <- data
    close(conn)
  }
  
  mnist
}
