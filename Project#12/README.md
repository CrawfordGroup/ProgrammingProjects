# Project #12: Excited Electronic States: CIS and TDHF/RPA

The simplest *ab initio* methods for describing excited electronic states are
based on Hartree-Fock theory, namely configuration interaction singles (CIS)
and time-dependent Hartree-Fock (TDHF), which is also known as the random-phase
approximation (RPA). The purpose of this project is to develop simple
implementations of these two methods and to understand the basic differences
between them.  This project assumes you have completed at least the
[CCSD programming project](../Project%2305).

You can read more about these methods in 
[J.B. Foresman, M. Head-Gordon, J.A. Pople, and M.J. Frisch, J. Phys. Chem. 96, 135-141 (1992)](http://pubs.acs.org/doi/pdf/10.1021/j100180a030) (CIS) 
and [P. Jørgensen and J. Simons, "Second-Quantization Based Methods in Quantum Chemistry", Academic Press, New York, 1981.](http://addison.vt.edu/record=b1305858~S1) (RPA)

## Configuration Interaction Singles (CIS)

The fundamental idea behind CIS is the representation of the excited-state wave
functions as linear combinations of singly excited determinants relative to the
Hartree-Fock reference wave function, *viz.*

<img src="./figures/singly-excited-determinant.png" height="50">

where *m* identifies the various excited states, and we will use *i* and *j*
(*a* and *b*) to denote occupied (unoccupied) spin-orbitals. Inserting this
into the Schr<html>&ouml;</html>dinger equation and left-projecting onto a
particular singly excited determinant gives

<img src="./figures/excited-det-schrod-eqn.png" height="50">

If we recognize that we have one of these equations for every combination of
*i* and *a* spin-orbitals, then this equation may be viewed as a matrix
eigenvalue problem:

<img src="./figures/matrix-eigenvalue-problem.png" height="25">

To solve this equation, we need an expression for the matrix elements in terms
of things we already know, i.e. Fock matrix elements and two-electron
integrals.  This can be done using either algebraic or diagrammatic techniques
to obtain (in the spin-orbital notation of previous projects):

<img src="./figures/matrix-elements.png" height="30">

Our task is then relatively simple: Build the Hamiltonian matrix (expressed in
the basis of all singly excited determinants) using the above expression and
diagonalize it.  Note that the CIS Hamiltonian matrix is symmetric (check for
yourself by swapping *i/a* and *j/b*), with dimensions of the number of
occupied orbitals times the number of unoccupied orbitals.  For our
STO-3G/H<sub>2</sub>O test case, with its ten occupied and four unoccupied
spin-orbitals, the matrix will be 40 x 40.

  * [Hint](./hints/hint1.md): CIS Hamiltonian for STO-3G H<sub>2</sub>O

Make sure you can compute the correct CIS excitation energies for each of the
four test cases provided at the end of the page.  Before you move on to the
next section, can you explain the degeneracies appearing in the
excitation-energy list?

## Spin Adaptation of CIS

If you carefully examine the list of eigenvalues you computed above, you will
notice a pattern: some of the eigenvalues are unique (i.e., they occur only
once), while others appear in groups of three.  The former correspond to
spin-singlet excited states and the latter to spin-triplets, and all are
eigenfunctions of the S<sup>2</sup> and S<sub>z</sub> operators by virtue of
the fact that the spin-restricted Hartree-Fock reference wave function is such
an eigenfunction (by design, of course) and that the single-excitation
operators must yield identical amplitudes (to within a sign) for both
<html>&alpha;-</html> and <html>&beta;-</html>spin excitations.

Consider the structure of the singlet and triplet determinantal wave functions
from a simple two-electron/two-orbital example (such as the *1s 2s* excited
state configuration of the He atom).  One can easily show that the four
possible determinants arising from this configuration,

<img src="./figures/four-possible-determinants.png" height="50">

are components of one singlet and one triplet in the following combinations:

<img src="./figures/triplet-combinations.png" height="50">

<img src="./figures/singlet-combinations.png" height="50">

where the superscript is the spin multiplicity (*2S+1*) and the subscript is
the *M<sub>S</sub>* value of the wave function.  So, if we wanted to compute
only the eigenvalues and eigenfunctions corresponding spin singlets in our CIS
calculation, we could introduce the restriction on our CIS coefficients that <html>&alpha;</html> 
and <html>&beta;</html> excitations involving the same <i>spatial</i> orbitals 
must be identical (including the sign).  Similarly, if we wanted only triplets, 
we could require that the <html>&alpha;</html> and <html>&beta;</html> excitations 
have the same magnitude but opposite signs.

Let's begin with the singlets.  Starting from the spin-orbital eigenvalue
expression and the equation for the CIS Hamiltonian matrix elements in the
previous section, we may write a spin-factored equation for the <html>&alpha;</html> 
coefficients as

<img src="./figures/spin-factored-eqn.png" height="55">

Note that the mix-spin cases (where *j=*<html>&alpha;</html> and
*b=*<html>&beta;</html> or *vice versa*) do not contribute since the Fock
matrix elements and two-electron integrals must all give zero.  If we then
carry out spin integration on the integrals in the above expression and assume
that the <html>&alpha;</html> and <html>&beta;</html> CI coefficients are
identical for the same spatial orbitals, i.e.,

<img src="./figures/identical-ci-coeff.png" height="30">

we obtain the <b><i>spatial orbital</i></b> expression

<img src="./figures/spatial-orbital-expression.png" height="50">

The part in brackets above is an expression for the spatial-orbital CIS
Hamiltonian, spin-adapted for singlet excited states, and diagonalization of
this matrix will yield only the singlet eigenvalues you obtained from your
spin-orbital matrix earlier.

  * [Hint](./hints/hint2.md): Spin-adapted CIS singlet Hamiltonian for STO-3G H<sub>2</sub>O

How about the triplets?  We use exactly the same spin-factorization, but
instead require

<img src="./figures/inverse-ci-coeff.png" height="30">

This yields a slightly simpler Hamiltonian:

<img src="./figures/simpler-hamiltonian.png" height="50">

which, upon diagonalization, will yield only the triplet eigenvalues (but each only occurring once) from your earlier diagonalziation.

Why should we worry about spin adaptation?  Because the dimension of the
spatial-orbital Hamiltonian matrix is **half** that of the spin-orbital
Hamiltonian, which is a factor of **four** savings in the storage of the matrix
and a factor of **eight** in the diagonalization.  For large basis sets and/or
large molecules, this is a considerable computational savings and essential for
production-level codes.

Make sure you can implement the spin-adapted CIS approach entirely in spatial
orbitals and obtain the correct excitation energies so that you can take
advantage of this greater efficiency available in this formulation.  (NB: For
the CH<sub>4</sub> test case below, you still get groups of three excitation
energies in the spin-adapted formulation.  Do you understand why this
degeneracy arises?)

## Time-Dependent Hartree Fock (TDHF)/The Random Phase Approximation (RPA)

The TDHF/RPA approach is closely related to CIS in that only singles are
involved in the wave function expansion, except that both excitation and
"de-excitation" operators are involved. (It is probably better to view the
TDHF/RPA wave function expansion in terms of orbital rotations instead of
Slater determinants, but that's a discussion for another day.)  The TDHF/RPA
eigenvalue equations take the form

<img src="./figures/tdhf-eqn.png" height="50">

The definition of the ***A*** matrix is just the CIS matrix itself, *viz.*

<img src="./figures/A-matrix.png" height="30">

while **X** and **Y** are the parameters of single excitations and
de-excitations, respectively, and the ***B*** matrix is simply

<img src="./figures/B-matrix.png" height="25">

Thus, the row/column dimension of the TDHF/RPA Hamiltonian is twice that of the
CIS Hamiltonian, and the matrix is non-symmetric (so you must be careful about
the diagonalization function you choose).  Do you obtain twice as many
excitation energies?

  * [Hint](./hints/hint3.md): TDHF/RPA Hamiltonian for STO-3G H<sub>2</sub>O

## A Better Approach to Solving the TDHF/RPA Eigenvalue Equations

Instead of solving the full-dimensional TDHF/RPA equations, which, as noted
above, is twice the size of the CIS problem (and thus four times the
Hamiltonian storage cost), one can rearrange the eigenvalue equations.  First
write eigenvalue equation two separate equations, each in terms of the
submatrices **A** and **B**:

<img src="./figures/smarter-tdhf-1.png" height="22.5">

and

<img src="./figures/smarter-tdhf-2.png" height="22.5">

Now take +/- combinations of these equations to obtain

<img src="./figures/smarter-tdhf-3.png" height="22.5">

and

<img src="./figures/smarter-tdhf-4.png" height="22.5">

Solve for ***(X+Y)*** in the second equation:

<img src="./figures/smarter-tdhf-5.png" height="25">

Insert this result into the first equation, rearrange a bit, and finally
obtain:

<img src="./figures/smarter-tdhf-6.png" height="25">

This is an eigenvalue equation of the same dimension as the CIS eigenvalue
equation (number of occupied orbitals times number of unoccupied orbitals),
where the eigenvalue is the square of the excitation energy and the eigenvector
is ***X-Y*** .

Make sure you can get the same set of excitation energies using the
full-dimensional TDHF/RPA approach above, as well as this reduced-dimension
approach, for all four test cases below.

## Test Cases
The input structures, integrals, etc. for these examples may be found in the 
[input directory](./input).

| Test Case | CIS | RPA (Method 1) | RPA (Method 2) |
|-----------|-----|----------------|----------------|
| STO-3G Water | [output](./output/h2o/STO-3G/output_cis.txt) | [output](./output/h2o/STO-3G/output_rpa1.txt) | [output](./output/h2o/STO-3G/output_rpa2.txt) |
| DZ Water | [output](./output/h2o/DZ/output_cis.txt) | [output](./output/h2o/DZ/output_rpa1.txt) | [output](./output/h2o/DZ/output_rpa2.txt) |
| DZP Water | [output](./output/h2o/DZP/output_cis.txt) | [output](./output/h2o/DZP/output_rpa1.txt) | [output](./output/h2o/DZP/output_rpa2.txt) |
| STO-3G Methane | [output](./output/ch4/STO-3G/output_cis.txt) | [output](./output/ch4/STO-3G/output_rpa1.txt) | [output](./output/ch4/STO-3G/output_rpa2.txt) |

