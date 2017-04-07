# Project #13: The Davidson-Liu Algorithm: CIS

A common problem in quantum chemistry is the need to compute a few eigenvalues
of a very large matrix -- far too large to store entirely in core memory.  In
1975, Ernest Davidson published a robust algorithm<sup id="r1">[1](#f1)</sup>
to solve this problem, and it has been used in electronic structure
software packages ever since.  A few years later, Bowen Liu extended the
algorithm to allow computation of several eigenvalues simultaneously rather
than one at a time<sup id="r2">[2](#f2)</sup>. The
purpose of this project is to illustrate the use of what is now called the
Davidson-Liu algorithm in the context of a 
[CIS computation](../Project%2312).

## The Basic Algorithm

This is an outline of the essential aspects of the Davidson-Liu algorithm.
There are many ways to tweak the approach to improve its rate of convergence or
efficiency, and for details I recommend David Sherrill's excellent CI review
article<sup id="r3">[3](#f3)</sup>, from which also we take our notation below.

## Step #1: Select Guess Vectors

Compute a set of *L* orthonormal guess eigenvectors, {***b***<sub>i</sub>} ---
at least one for every desired root.  A simple choice is a set of unit vectors,
or one can taken them from another level of theory or perhaps the eigenvectors
from a well-chosen subspace of the full determinantal space.

## Step #2: Build and Diagonalize the Subspace Hamiltonian

Compute a representation of the Hamiltonian within the space of guess vectors,

<img src="./figures/guess-vector-hamiltonian.png" height="22.5">

and then diagonalize this so-called "subspace Hamiltonian",

<img src="./figures/diag-subspace-hamiltonian.png" height="25">

where *M* is the number of roots of interest. The current estimate of each of
the *M* eigenvectors we want is a linear combination of the guess vectors,
with the &alpha;<sup>k</sup> subspace eigenvectors providing the
coefficients, *viz.*

<img src="./figures/coefficients.png" height="60">

The dimension of ***G*** is typically very small (perhaps a dozen times the
number of guess vectors, *L*), so one can used a standard diagonalization
package (such as DSYEV in LAPACK) for this task.  Note that the most expensive
part of the Davidson-Liu algorithm is the computation of &sigma;,
the products of the Hamiltonian matrix with the guess vectors.  In some of the
largest CI calculations, the Hamiltonian cannot even be stored on disk and its
elements must be computed "on the fly" during the computation of each
<b>&sigma;</b>.

## Step #3: Build the Correction Vectors

Build a set of "correction vectors",

<img src="./figures/correction-vectors.png" height="30">

where the "residual" vectors are defined as

<img src="./figures/residual-vectors.png" height="60">

and *N* is the dimension of the Hamiltonian (i.e. the number of determinants).
The inverse appearing in the definition of the correction vectors is commonly
referred to as the "preconditioner". Notice that the residual vectors are so
named because they would be zero if the guess vectors, ***b***<sub>i</sub>,
were the true eigenvectors.  Thus, convergence of the algorithm is checked at
this point, based on the norms of the residual vectors (one for each desired
root) and the change in the corresponding eigenvalue between each iteration.
## Step #4: Orthonormalize the Correction Vectors

Normalize each correction vector, f<b>&delta;</b><sup>k</sup>, 
then orthogonalize it against the existing set of guesses, **b**<sub>i</sub>, 
using the [Schmidt Orthogonalization procedure](http://en.wikipedia.org/wiki/Gram–Schmidt_process),
for example.  If the orthonormalized correction vector has a norm larger than some chosen threshold (e.g. 10<sup>-3</sup>), 
include it in the set of guess vectors.  If not, discard it.  (Thus, the dimension of the guess space, *L*, gradually increases in each iteration.)

Return to step #2 and continue.

## CIS Sigma Equation

We will focus on the spin-adapted singlet formulation of CIS, 
for which the <b>&sigma;</b> = <b>H c</b> equation was given in 
[Project 12](../Project%2312):

<img src="./figures/spin-adapted-cis-eqn.png" height="50">

## Unit Guess Vectors

What should we choose for guess vectors?  As noted above, the simplest choice
is probably a set of unit vectors, one for each eigenvalue you want.  But in
what position of the vector should we put the 1?  For a hint, look at the
structure of the [spin-adapted singlet CIS Hamiltonian](../Project%2312/hints/hint2.md)  
for the H<sub>2</sub>O STO-3G test case and note that it is
strongly diagonally dominant.  Thus, if the diagonal elements are reasonable
approximations to the true eigenvalues, and we want to compute only the lowest
*M* eigenvalues, then our guess unit vectors should have a 1 in the position
corresponding to the row/column of the smallest elements of the Hamiltonian.

## Subspace Collapse

If the number of guess vectors grows to be too large, we may need to reduce its
dimension to something more manageable before continuing the Davidson-Liu
algorithm.  A typical choice is to collapse to the current best set of guesses
using the equation given above for the current final eigenvectors:

<img src="./figures/final-eigenvectors.png" height="60">

#### References
 - <b id="f1">1</b>: E.R. Davidson, "The iterative calculation of a few of the lowest eigenvalues and corresponding eigenvectors of large real-symmetric matrices," *J. Comput. Phys.* **17**, 87 (1975). [(return to text)](#r1)
 - <b id="f2">2</b>: B.Liu, "The simultaneous expansion method for the iterative solution of several of the lowest eigenvalues and corresponding eigenvectors of large real-symmetric matrices," Technical Report LBL-8158, Lawrence Berkeley Laboratory, University of California, Berkeley, 1978. [(return to text)](#r2)
 - <b id="f3">3</b>: C.D. Sherrill, "The Configuration Interaction Method: Advances in Highly Correlated Approaches," *Adv. Quantum Chem.* **34**, 143 (1998). [(return to text)](#r3)
