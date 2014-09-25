\name{RealVAMS}
\alias{RealVAMS}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Multivariate VAM Fitting
}
\description{
The RealVAMs package fits a multivariate value-added model (VAM) (see Broatch and Lohr 2012)
with normally distributed test scores and a binary outcome indicator. This material is based
upon work supported by the National Science Foundation under grants DRL-1336027 and DRL- 1336265. 
  
The package fits continuous test score results jointly with a binary outcome in a multivariate generalized linear mixed model 
(see Broatch and Lohr (2012); Karl, Yang, and Lohr (2013); and Karl, Yang, and Lohr (2014)) using a pseudo-likelihood approximation.
}
\usage{
RealVAMS(score.data, outcome.data, persistence = "CP",school.effects = FALSE, 
REML = TRUE, score.fixed.effects = formula(~as.factor(year) + 0), 
outcome.fixed.effects = formula(~1), max.iter.EM = 10,
outcome.family = binomial(link = "probit"), 
tol1 = 1e-07, max.PQL.it = 30, pconv = .Machine$double.eps*1e9, var.parm.hessian = TRUE,
verbose = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{score.data}{
a data frame that contains at least a column "y" containing the student scores, 
a column "student" containing unique student ID's, a column "teacher" containing 
the teacher ID's, and a column "year" which contains the year (or semester, etc.) 
of the time period. The "y" and "year" variables needs to be numeric. If other 
variables are to be included as fixed effects, they should also be included in 
score.data. See 'Note' for further discussion.
}
  \item{outcome.data}{
a data frame that contains at least a column "r" containing the binary student outcomes (coded 0/1),
and a column "student" containing unique student ID's. The student ID's should match those in \code{score.data}.
If other variables are to be included as fixed effects, they should also be included in 
outcome.data.
}
  \item{persistence}{
a character. Choices are "CP" or "VP", for complete and variable persistence of the teacher score effects, respectively. 
The teacher outcome effects are modeled with complete persistence, regardless of the selection here.
}
\item{school.effects}{
logical. If TRUE, correlated random school-level effects are fitted in the score and outcome response models. For both responses, the
school effects are fit with zero-persitence (a student's score in each year is associated with the current school attended, and their outcome is associated with the last school the student attended). The school ID should be included
as a column schoolID in the score.data data frame. 
}
  \item{REML}{
logical. If TRUE, the pseudo-response is fit using REML. If FALSE, ML is used.
}
  \item{score.fixed.effects}{
an object of class formula describing the structure of the fixed effects for the student scores. Categorical variables should be wrapped in an as.factor statement.
}
  \item{outcome.fixed.effects}{
an object of class formula describing the structure of the fixed effects for the student outcomes. Categorical variables should be wrapped in an as.factor statement.
}
  \item{max.iter.EM}{
numeric. The maximum number of EM iterations during each pseudo-likelihood iteration
}
  \item{outcome.family}{
an object of class family describing the assumed distribution of the response. Currently only "binomial" has been tested, though "poisson" should work as well. 
}
  \item{tol1}{
numeric. Convergence tolerance for EM algorithm during each interior pseduo-likelihood iteration. The convergence criterion is specified under 'Details'.
}
  \item{max.PQL.it}{
numeric. Maximum number of outer pseudo-liklihood iterations.
}
  \item{pconv}{
numeric. Convergence criterion for outer pseudo-likelihood iterations. Compare to the PCONV option of SAS PROC GLIMMIX.
}
\item{var.parm.hessian}{
logical. If TRUE, the Hessian of the parameters in the error and random effects covariance matrices
is calculated, providing standard errors for those parameters. Setting this option to FALSE will reduce the
run time of the program: only standard errors for the fixed effects will be returned.
}
  \item{verbose}{
logical. If TRUE, model information will be printed at each iteration.
}
}
\details{

*The \code{persistence} option determines the type of persistence effects that are modeled. 
The variable persistence model ("VP") assumes that teacher effects in future years are multiples of their effect in the current year (Lockwood et al. 2007). 
The multipliers in the VP model are called persistence parameters, and are estimated. By contrast, the complete persistence ("CP") model fixes the persistence 
parameters at 1 and 0 (Lockwood et al. 2007). 

*Convergence is declared for each interior iteration when \eqn{(l_k-l_{k-1})/l_k < \code{tol1}}, where \eqn{l_k} is the log-likelihood 
at iteration \eqn{k}.


*The model is linearized using a pseudo-likelihood approach (Wolfinger 1993) and the resuling multiple membership linear mixed model is estimated 
via an EM algorithm (Karl et al. 2012). 


}
\value{
RealVAMS returns an object of class \code{RealVAMS}


\item{loglik}{the maximized log-likelihood at convergence of the EM algorithm. Warning: Likelihood-ratio tests are not valid with results from a PQL estimation routine.}
\item{teach.effects}{a data frame containing the predicted teacher effects and standard errors}
\item{parameters}{a matrix of estimated model parameters and standard errors}
\item{Hessian}{the Hessian of the variance parameters}
\item{R_i}{a matrix containing the error covariance matrix of a student. The bottom-right component corresponds to the variance of the binary response, and is fixed at 1.}
\item{teach.cov}{a list containing the unique blocks of the covariance matrix of teacher effects (the G matrix)}
\item{mresid}{a vector of the raw marginal residuals}
\item{cresid}{a vector of the raw conditional residuals}
\item{y}{a vector of the pseudo-responses from the final PQL iteration. The test scores will be the same as those given as an input, but the 0/1 responses for the binary distribution will be different.}
\item{yhat}{a vector of the predicted values}
\item{num.obs}{total number of observations (test scores and binary responses)}
\item{num.student}{total number of students included in the data}
\item{num.year}{number of years over which test scores were modeled}
\item{num.teach}{a vector listing the number of teachers in each year}
\item{persistence}{a charachter vector indicating the persistence structure (VP or CP) used to model the teacher test-score effects}   
\item{persistence_parameters}{a matrix of the persistence parameters. The (i,j)-th component gives the persistence parameter for year-j teachers on year-i scores.}
\item{X}{the fixed effects design matrix}
\item{Z}{the random effecs design matrix}
\item{G}{the random effects covariance matrix}
\item{R.full}{the error covariance matrix, which is formed as the product diag(sqrt.w)\%*\%R\%*\%diag(sqrt.w). The matrix R assumes a variance of 1 for all of the binomial responses, while R.full includes the variance from the binomial distribution (in Wolfinger (1993), diag(sqrt.w) is called R_{mu}).}
\item{sqrt.W}{vector of weights for the error covariance matrix. See the description for R.full above}
}
\references{
Broatch, J. and Lohr, S. (2012) Multidimensional Assessment of Value Added by Teachers to Real-World Outcomes. \emph{Journal of Educational and Behavioral Statistics} \bold{37}, 256--277.

Karl, A., Yang, Y. and Lohr, S. (2012) Efficient Maximum Likelihood Estimation of Multiple Membership Linear Mixed Models, with an Application to Educational Value-Added Assessments. \emph{Computational Statistics & Data Analysis} \bold{59}, 13--27.  

Karl, A., Yang, Y. and Lohr, S. (2013) A Correlated Random Effects Model for Nonignorable Missing Data in Value-Added Assessment of Teacher Effects. \emph{Journal of Educational and Behavioral Statistics} \bold{38}, 577--603.

Karl, A., Yang, Y. and Lohr, S. (2014) Computation of Maximum Likelihood Estimates for Multiresponse Generalized Linear Mixed Models with Non-nested, Correlated Random Effects. \emph{Computational Statistics & Data Analysis} \bold{73}, 146--162.

Lockwood, J., McCaffrey, D., Mariano, L., Setodji, C. (2007) Bayesian Methods for Scalable Multivariate Value-Added Assesment. \emph{Journal of Educational and Behavioral Statistics} \bold{32}, 125--150.

Wolfinger, R. (1993) Generalized linear mixed models a pseudo-likelihood approach. \emph{Journal of Statistical Computation and Simulation} \bold{48} 233--243.
}
\author{
Andrew Karl \email{akarl@asu.edu}
Jennifer Broatch
Jennifer Green
}
\note{
The first few iterations of the EM algorithm will take longer than subsequent iterations. This is a result of the hybrid gradient-ascent/Newton-Raphson method used in the M-step for the R matrix in the first two iterations (Karl et al. 2012).


The model assumes that each teacher teaches only one year. If, for example, a teacher teaches in years 1 and 2, his/her first year performance is modeled independently of the second year performance.
To keep these effects seperate, the progam appends "(year i)" to each teacher name, where i is the year in which the teacher taught.

The \code{fixed.effects} arguments of \code{RealVAMS} utilizes the functionality of R's \code{formula} class. In the statement \code{score.fixed.effects=formula(~as.factor(year)+cont_var+0))}, \code{as.factor(year)} identifies \code{year} as a categorical variable. \code{+0} indicates that no intercept is to be fitted, and \code{+cont_var} indicates that a seperate effect is to be fitted for the continuous variable "cont_var." An interaction between "year" and "cont_var" could be specified by \code{~as.factor(year)*cont_var+0}, or equivalently, \code{~as.factor(year)+cont_var+as.factor(year):cont_var+0}. See \code{\link{formula}} for more details.


}

%% ~Make other sections like Warning with \section{Warning }{....} ~


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
\keyword{regression}

