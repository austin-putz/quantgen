#' Calculate selection intensity with optional adjustment for finite population size
#'
#' This function calculates the intensity of selection, which is the mean of the 
#' selected group expressed in standard deviation units of the unselected population.
#' It can incorporate a correction for finite population size, and also returns
#' variance reduction and the variance in the selected population.
#'
#' @param p Proportion selected (between 0 and 1, not percentage)
#' @param pop_size Optional finite population size for adjusted calculation
#'
#' @return A list with three components:
#' \itemize{
#'   \item \code{i} - Intensity of selection
#'   \item \code{var_reduc} - Variance reduction
#'   \item \code{var_sel} - Variance in selected population
#' }
#'
#' @examples
#' # Calculate selection intensity when selecting the top 10%
#' intensity(0.1)
#'
#' # With finite population adjustment
#' intensity(0.1, pop_size = 100)
#'
#' @importFrom stats qnorm dnorm
#' @export
intensity <- function(p, pop_size = NULL) {
  
  # check if p < 0 or > 1
  if (p < 0 | p > 1) {
    stop("ERROR: p not between 0 and 1")
  }
  
  # check if population size (pop_size) is NULL
  if (is.null(pop_size)) {
    
    # threshold for p on standard normal (0,1) distribution (x cutoff)
    x <- qnorm(1-p)
    
    # height of distribution at threshold x
    z <- dnorm(x)
    
    # intensity = height / proportion selected
    i <- z / p
    
    # variance reduction from total group as proportion
    var_reduc <- i * (i - x)
    
    # variance of selected group
    var_sel <- 1 - var_reduc
    
  } else {
    
    # check if population size is positive integer
    if (pop_size < 2) {
      stop("ERROR: pop_size is less than 2")
    }
    
    # threshold for p on standard normal (0,1) distribution (x cutoff)
    x <- qnorm(1-p)
    
    # height of distribution at threshold x
    z <- dnorm(x)
    
    # intensity = height / proportion selected
    i <- z / p
    
    # intensity corrected for population size
    i_correct <- i - (pop_size - (pop_size*p)) / (2 * p * pop_size * ((pop_size+1)*i))
    
    # reset i equal to the corrected i for population size
    i <- i_correct
    
    # variance reduction from total group as proportion
    var_reduc <- i * (i - x)
    
    # variance of selected group
    var_sel <- 1 - var_reduc
    
  }
  
  # return intensity
  return(list(i = i, var_reduc = var_reduc, var_sel = var_sel))
  
}