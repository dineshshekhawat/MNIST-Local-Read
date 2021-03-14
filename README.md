# MNIST-Local-Read
R Function to read mnist data from local files

I was having issues executing the read_mnist function in R as files were failing
to download from the internet and HTTP response 503 was thrown.

I made some modifications in the existing code of read_mnist() to allow reading
the dataset with local files that were downloaded in my machine.

I have also added the datasets in the repository in case someone wants to those files.

By default the function will expect to read from '/home/dinesh/MNIST_Data/' Directory
but you can pass any other location in the argument to make it read files from your
preferred location.
