## The following two functions inverse a matrix and return it 

## Return a cached matrix

makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL
  set <- function(y) {
    x <<- y
    inverse <<- NULL
  }
  get <- function() x
  setInv <- function(i) inverse <<- i
  getInv <- function() inverse
  list(set = set, 
       get = get,
       setInv = setInv,
       getInv = getInv)
}


## Inverse a matrix with a function solve() in base R

cacheSolve <- function(x, ...) {
  inverse <- x$getInv()
  if(!is.null(inverse)) {
    message("getting cached data")
    return(inverse)
  }
  data <- x$get()
  inverse <- solve(data, ...)
  x$setInv(inverse)
  inverse
}


