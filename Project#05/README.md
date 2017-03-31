# Project #5: The coupled cluster singles and doubles (CCSD) energy
The coupled cluster model provides a higher level of accuracy beyond the MP2 approach.  The purpose of this project is to understand the fundamental aspects of the calculation of the CCSD wave function and corresponding energy.  A good reference article (with correct, factored equations!) is [J.F. Stanton, J. Gauss, J.D. Watts, and R.J. Bartlett, J. Chem. Phys. volume 94, pp. 4334-4345 (1991)]( http://sirius.chem.vt.edu/wiki/lib/exe/fetch.php?media=crawdad:programming:jcp_94_4334_1991.pdf).
## Step #1: Preparing the Spin-Orbital Basis Integrals 
Each term in the equations given in the above paper by Stanton et al. depends on the T<sub>1</sub> or T<sub>2</sub> 
amplitudes as well as Fock-matrix elements and antisymmetrized, Dirac-notation two-electron integrals, all given in the molecular spin-orbital basis 
(as opposed to the spatial-orbital basis used in the earlier [MP2 Project](../Project%2304).
Thus, the transformation of the AO-basis integrals into the spatial-MO basis must also include their translation into the spin-orbital basis:

<img src="./figures/spin-orbital-eri.png" height="160">

Thus, if you know the ordering of the orbitals (e.g. all occupied orbitals before virtual orbitals, perhaps alternating between alpha and beta spins), it is straightforward to carry out the integration over the spin components (the &sigma;'s) in the above expression.  Thus, each spatial-orbital MO-basis two-electron integral translates to 16 possible spin-orbital integrals, only four of which are non-zero.

Don't forget that you must also create the spin-orbital Fock matrix:

<img src="./figures/spin-orbital-fock.png" height="60">

Suggestion: For simplicity, store the two-electron integrals in a four-dimensional array.  This will greatly facilitate debugging of the complicated CCSD equations.

  * [Hint 1](./hints/hint1.md): Sample spatial- to spin-orbital translation code.

## Step #2: Build the Initial-Guess Cluster Amplitudes 
For Hartree-Fock reference determinants, the most common initial guess for the cluster amplitudes are the Moller-Plesset first-order perturbed wave function:

<img src="./figures/init-t-amps.png" height="120">

Note that if you have constructed the Fock matrix, two-electron integrals, and initial-guess amplitudes correctly at this point, 
you should be able to compute the MP2 correlation energy using the simple spin-orbital expression and get identical results to those from [Project #4](../Project%2304):

<img src="./figures/mp2-energy.png" height="60">

## Step #3: Calculate the CC Intermediates 
Use the spin-orbital Eqs. 3-13 from Stanton's paper to build the two-index (F) and four-index (W) intermediates, as well as the effective doubles (labelled with the Greek letter &tau;).

## Step #4: Compute the Updated Cluster Amplitudes 
Use Eqs. 1 and 2 from Stanton's paper to compute the updated T<sub>1</sub> and T<sub>2</sub> cluster amplitudes.

## Step #5: Check for Convergence and Iterate 
Calculate the current CC correlation energy:

<img src="./figures/cc-correlation-energy.png" height="60">

Compare energies and cluster amplitudes (using RMS differences) between iterations to check for convergence to some specified cutoff.
If convergence is reached, you're done; if not, return to Step #3 and continue.

## Test Cases 
The input structures, integrals, etc. for these examples are found in the 
[input directory](./input).

* STO-3G Water | [output](./output/h2o/STO-3G/output.txt)
* DZ Water | [output](./output/h2o/DZ/output.txt)
* DZP Water | [output](./output/h2o/DZP/output.txt)
* STO-3G Methane | [output](./output/ch4/STO-3G/output.txt)
