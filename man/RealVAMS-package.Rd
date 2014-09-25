\name{RealVAMS-package}
\alias{RealVAMS-package}
\docType{package}
\title{
Multivariate VAM Fitting
}
\description{
The RealVAMs package fits a multivariate value-added model (VAM) (see Broatch and Lohr 2012)
 with normally distributed test scores and a binary outcome indicator. This material is based 
 upon work supported by the National Science Foundation under grants DRL-1336027 and DRL- 1336265. 
}
\details{
\tabular{ll}{
Package: \tab RealVAMS\cr
Type: \tab Package\cr
Version: \tab 0.3-1\cr
Date: \tab 2014-09-25\cr
License: \tab GPL-2\cr
}
}
\author{
Authors: Andrew Karl, Jennifer Broatch, and Jennifer Green

Maintainer: Andrew Karl <akarl@asu.edu>
}
\references{
Broatch, J. and Lohr, S. (2012) Multidimensional Assessment of Value Added by Teachers to Real-World Outcomes. \emph{Journal of Educational and Behavioral Statistics} \bold{37}, 256--277.

Karl, A., Yang, Y. and Lohr, S. (2012) Efficient Maximum Likelihood Estimation of Multiple Membership Linear Mixed Models, with an Application to Educational Value-Added Assessments. \emph{Computational Statistics & Data Analysis} \bold{59}, 13--27.  

Karl, A., Yang, Y. and Lohr, S. (2013) A Correlated Random Effects Model for Nonignorable Missing Data in Value-Added Assessment of Teacher Effects. \emph{Journal of Educational and Behavioral Statistics} \bold{38}, 577--603.

Karl, A., Yang, Y. and Lohr, S. (2014) Computation of Maximum Likelihood Estimates for Multiresponse Generalized Linear Mixed Models with Non-nested, Correlated Random Effects. \emph{Computational Statistics & Data Analysis} \bold{73}, 146--162.

Lockwood, J., McCaffrey, D., Mariano, L., Setodji, C. (2007) Bayesian Methods for Scalable Multivariate Value-Added Assesment. \emph{Journal of Educational and Behavioral Statistics} \bold{32}, 125--150.

Wolfinger, R. (1993) Generalized linear mixed models a pseudo-likelihood approach. \emph{Journal of Statistical Computation and Simulation} \bold{48} 233--243.

}

\keyword{ package }

\examples{
data(example.score.data)
data(example.outcome.data)
#The next line exists to show that the function can run and that the package
#installed correctly
res.test<-RealVAMS(example.score.data,example.outcome.data,max.PQL.it=1,max.iter.EM=2,
var.parm.hessian=FALSE)
#The next line (not run automatically) provides a full example of the function
\dontrun{res<-RealVAMS(example.score.data,example.outcome.data)}
}