# Project #3: The Hartree-Fock self-consistent field (SCF) procedure

The purpose of this project is to provide a deeper understanding of Hartree-Fock theory by 
demonstrating a simple implementation of the self-consistent-field method. 
The theoretical background can be found in Ch. 3 of the text by Szabo and Ostlund or in the 
[nice set of on-line notes](http://vergil.chemistry.gatech.edu/notes/hf-intro/hf-intro.html) written by David Sherrill.
A concise set of instructions for this project may be found [here](./project3-instructions.pdf).

We thank Dr. Yukio Yamaguchi of the University of Georgia for the original version of this project.

The test case used in the following discussion is for a water molecule with a bond-length of 1.1 <html>&Aring;</html> 
and a bond angle of 104.0<sup>o</sup> with an STO-3G basis set.  The input to the project consists of the 
[nuclear repulsion energy](./input/h2o/STO-3G/enuc.dat)
   and pre-computed sets of one- and two-electron integrals: 
[overlap integrals](./input/h2o/STO-3G/s.dat),
[kinetic-energy integrals](./input/h2o/STO-3G/t.dat),
[nuclear-attraction integrals](./input/h2o/STO-3G/v.dat),
[electron-electron repulsion integrals](./input/h2o/STO-3G/eri.dat).


## Step 1: Nuclear Repulsion Energy

Read the nuclear repulsion energy from the [enuc.dat](./input/h2o/STO-3G/enuc.dat)

## Step 2: One-Electron Integrals

Read the AO-basis [overlap](./input/h2o/STO-3G/s.dat)

```
EQUATION
S_{\mu \nu} \equiv \int \phi_\mu({\mathbf r}) \phi_{\nu}({\mathbf
  r}) d{\mathbf r}
```

[kinetic-energy](./input/h2o/STO-3G/t.dat)

```
EQUATION 
T_{\mu \nu} \equiv \int \phi_\mu({\mathbf r}) \left( -\frac{1}{2}
  \nabla^2_{\mathbf r} \right) \phi_\nu({\mathbf r}) d{\mathbf r}
```

[nuclear-attraction integrals](./input/h2o/STO-3G/v.dat)

```
EQUATION 
V_{\mu \nu} \equiv \int \phi_\mu({\mathbf r}) \left( -\sum_A^N
\frac{Z}{r_A} \right) \phi_\nu({\mathbf r}) d{\mathbf r},
```

and store them in appropriately constructed matrices.  Then form the "core Hamiltonian":

```
EQUATION 
H^{\rm core}_{\mu \nu} = T_{\mu \nu} + V_{\mu \nu}.
```

Note that the one-electron integrals provided include only the *permutationally unique* integrals, but you should store the full matrices for convenience.  
Note also that the AO indices on the integrals in the files start with "1" rather than "0".

 * [Hint 1](./hints/hint2-1.md): Core Hamiltonian

## Step #3: Two-Electron Integrals

Read the two-electron repulsion integrals from the 
[eri.dat](./input/h2o/STO-3G/eri.dat) 
file.
The integrals in this file are provided in Mulliken notation over real AO basis functions:

```
EQUATION
(\mu \nu | \lambda \sigma) \equiv \int \phi_\mu({\mathbf r}_1)
\phi_\nu({\mathbf r}_1) r_{12}^{-1} \phi_\lambda({\mathbf r}_2)
\phi_\sigma({\mathbf r}_2) d{\mathbf r}_1 d{\mathbf r}_2.
```
Hence, the integrals obey the eight-fold permutational symmetry relationships:

```
EQUATION
  (\mu \nu | \lambda \sigma) = (\nu \mu | \lambda \sigma) = (\mu \nu
  | \sigma \lambda ) = (\nu \mu | \sigma \lambda) =  (\lambda \sigma | \mu \nu) = (\sigma \lambda | \mu \nu) =
  (\lambda \sigma | \nu \mu) = (\sigma \lambda | \nu \mu),
```
and only the permutationally unique integrals are provided in the file, with the restriction that, for each integral, the following relationships hold:

```
EQUATION
\mu \geq \nu,\ \ \ \ \ \lambda \geq \sigma,\ \ \ \ \ \ {\rm and}\ \ \ \
\ \ \mu\nu \geq \lambda\sigma,
```
where

```
EQUATION
\mu\nu \equiv \mu(\mu+1)/2 + \nu\ \ \ \ \ \ {\rm and} \ \ \ \ \ \ \lambda\sigma \equiv
\lambda(\lambda+1)/2 + \sigma.
```
Note that the two-electron integrals may be stored efficiently in a one-dimensional array and the above relationship used to map between given 
&mu;, &nu;, &lambda;, and &sigma; indices and a "compound index" defined as:

```
EQUATION
\mu\nu\lambda\sigma \equiv \mu\nu(\mu\nu+1)/2 + \lambda\sigma.
```
  * [Hint 1](./hints/hint3-1.md): Compound indices
  * [Hint 2](./hints/hint3-2.md): Pre-Computed Lookup Arrays
  * [Hint 3](./hints/hint3-3.md): Reading the two-electron integrals


## Step 4: Build the Orthogonalization Matrix

Diagonalize the overlap matrix:

```
EQUATION
{\mathbf S} {\mathbf L}_S = {\mathbf L}_S \Lambda_S,
```
where L<sub>S</sub> is the matrix of eigenvectors (columns) and &Lambda;<sub>S</sub> is the diagonal matrix of corresponding eigenvalues.

Build the symmetric orthogonalization matrix using:

```
EQUATION
{\mathbf S}^{-1/2} \equiv {\mathbf L}_S \Lambda^{-1/2} {\mathbf {\tilde L}}_S,
```
where the tilde denotes the matrix transpose.

  * [Hint 1](./hints/hint4-1.md): S<sup>-1/2</sup> Matrix


## Step 5: Build the Initial Guess Density

Form an initial (guess) Fock matrix in the orthonormal AO basis using the core Hamiltonian as a guess:

```
EQUATION
{\mathbf F}'_0 \equiv {\mathbf {\tilde S}}^{-1/2} {\mathbf H}^{\rm core} {\mathbf S}^{-1/2}
```
Diagonalize the Fock matrix:

```
EQUATION
{\mathbf F}'_0 {\mathbf C}'_0 = {\mathbf C}'_0 \epsilon_0.
```
Note that the &epsilon;<sub>0</sub> matrix contains the initial orbital energies.

Transform the eigenvectors into the original (non-orthogonal) AO basis:

```
EQUATION
{\mathbf C_0} = {\mathbf S}^{-1/2} {\mathbf C}'_0
```
Build the density matrix using the occupied MOs:

```
EQUATION
D^0_{\mu\nu} = \sum_m^{\rm occ.} \left( {\mathbf C}_0 \right )_\mu^m \left( {\mathbf C}_0 \right )_\nu^m,
```
where *m* indexes the columns of the coefficient matrices, and the summation includes only the occupied spatial MOs.

  * [Hint 1](./hints/hint5-1.md): Transformed Fock matrix
  * [Hint 2](./hints/hint5-2.md): Initial MO Coefficients
  * [Hint 3](./hints/hint5-3.md): Initial Density Matrix

## Step 6: Compute the Inital SCF Energy

CF electronic energy may be computed using the density matrix as:

```
EQUATION
E^0_{\rm elec} = \sum_{\mu\nu}^{\rm AO} D^0_{\mu\nu} \left( H^{\rm core}_{\mu\nu} + F_{\mu\nu} \right )
```

The total energy is the sum of the electronic energy and the nuclear repulsion energy:

```
EQUATION
E^0_{\rm total} = E^0_{\rm elec} + E_{\rm nuc},
```

where *0* denotes the initial SCF energy.

 * [Hint 1](./hints/hint6-1.md): Initial Electronic Energy

## Step #7: Compute the New Fock Matrix 

Start the SCF iterative procedure by building a new Fock matrix using the previous iteration's density as:

```
EQUATION
F_{\mu\nu} = H^{\rm core}_{\mu\nu} + \sum_{\lambda\sigma}^{\rm AO} D^{i-1}_{\lambda\sigma} \left[ 2 (\mu\nu | \lambda\sigma) - (\mu\lambda|\nu\sigma) \right],
```
where the double-summation runs over all the AOs and *i-1* denotes the density for the last iteration.

  * [Hint 1](./hints/hint7-1.md): New Fock Matrix
  * [Hint 2](./hints/hint7-2.md): Fock-Build Code

## Step #8: Build the New Density Matrix 

Form the new density matrix following the same procedure as in Step #5 above:

Orthogonalize:
```
EQUATION
{\mathbf F}' \equiv {\mathbf {\tilde S}}^{-1/2} {\mathbf F} {\mathbf S}^{-1/2}
```
Diagonalize:

```
EQUATION
{\mathbf F}' {\mathbf C}' = {\mathbf C}' \epsilon.
```
Back-transform:

```
EQUATION
{\mathbf C} = {\mathbf S}^{-1/2} {\mathbf C}'
```
Compute the density:

```
EQUATION
D^i_{\mu\nu} = \sum_m^{\rm occ.} \left( {\mathbf C} \right)_\mu^m \left( {\mathbf C} \right)_\nu^m,
```
where *i* denotes the current iteration density.

## Step #9: Compute the New SCF Energy 

Compute the new SCF energy as before:

```
EQUATION
E^i_{\rm elec} = \sum_{\mu\nu}^{\rm AO} D_{\mu\nu} \left( H^{\rm core}_{\mu\nu} + F_{\mu\nu} \right)
```
```
EQUATION
E^i_{\rm total} = E^i_{\rm elec} + E_{\rm nuc},
```
where *i* denotes the SCF energy for the *i*th iteration.

## Step #10: Test for Convergence 
Test both the energy and the density for convergence:

```
EQUATION
\Delta E = E^i_{\rm elec} - E^{i-1}_{\rm elec} < \delta_1
```

```
EQUATION
{\rm rms}_D = \left[ \sum_{\mu\nu} \left( D^i_{\mu\nu} - D^{i-1}_{\mu\nu} \right)^2 \right]^{1/2} < \delta_2
```
If the difference in consecutive SCF energy and the root-mean-squared difference in consecutive densities do not fall below the prescribed thresholds, return to Step #7 and continue from there.

  * [Hint 1](./hints/hint10-1.md): Energies for Each Iteration

## Additional Concepts
###  The MO-Basis Fock Matrix
At convergence, the canonical Hartree-Fock MOs are, by definition, eigenfunctions of the Fock operator, viz.

```
EQUATION
\[ \hat{F} \chi_i = \epsilon_i \chi_i \]
```
If we multiply on the left by an arbitrary MO and integrate, we obtain:

```
EQUATION
F_{ij} \equiv \epsilon_i\delta_{ij} = \langle \chi_j | \hat{F} | \chi_i \rangle. 
```
In other words, the Fock matrix should be diagonal in the MO basis, with the orbital energies as its diagonal elements.  We can demonstrate this explicitly using the AO-basis Fock matrix by first re-writing the above expression using the LCAO-MO coefficients:

```
EQUATION
F_{ij} = \sum_{\mu\nu} C^j_\mu C^i_\nu \langle \phi_\mu | \hat{F} | \phi_\nu \rangle = \sum_{\mu\nu} C^j_\mu C^i_\nu F_{\mu\nu}.
```
Use the above equation to transform the Fock matrix from the AO basis to the MO basis and demonstrate that it is indeed diagonal (to within the convergence limits of the SCF iterative procedure).

### One-Electron Properties 
As discussed in detail in Ch. 3 of the text by Szabo and Ostlund, the calculation of one-electron properties requires density matrix and the relevant property integrals.  The electronic contribution to the electric-dipole moment may be computed using,

```
EQUATION
\langle \vec{\mu} \rangle = 2 \sum_{\mu\nu} D_{\mu\nu} \langle \phi_\mu | \vec{\mu} | \phi_\nu \rangle,
```
where the vector notation implies three sets of dipole-moment integrals -- one for each Cartesian component of the dipole operator.

Two points to note:
  - In order to compute the total dipole moment, you must include the nuclear contribution, which requires the atomic numbers and Cartesian coordinates of the nuclei, in addition to the above.
  - The factor 2 appearing above arises because the definition of the density used in this project differs from that used in Szabo & Ostlund.

The test cases provided below include the structural information dipole integrals needed to compute the dipole moment.

### Population Analysis/Atomic Charges
A Mulliken population analysis (also described in Szabo & Ostlund, Ch. 3) requires the overlap integrals and the electron density, in addition to information about the number of basis functions centered on each atom.  The charge on atom *A* may be computed as:

```
EQUATION
q_A = Z_A - 2 \sum_{\mu \in A} ({\mathbf D S})_{\mu\mu},
```
where the summation is limited to only those basis functions centered on atom *A*.

## Test Cases
 * STO-3G Water [Geometry](./input/h2o/STO-3G/geom.dat) | [Enuc](./input/h2o/STO-3G/enuc.dat) | [S](./input/h2o/STO-3G/s.dat) | [T](./input/h2o/STO-3G/t.dat) | [V](./input/h2o/STO-3G/v.dat) | [ERI](./input/h2o/STO-3G/eri.dat) | [Mu_X](./input/h2o/STO-3G/mux.dat) | [Mu_Y](./input/h2o/STO-3G/muy.dat) | [Mu_Z](./input/h2o/STO-3G/muz.dat) | [output](./output/sto3g_h2o/output.dat)
 *  DZ Water [Geometry](./input/h2o/DZ/geom.dat) | [Enuc](./input/h2o/DZ/enuc.dat) | [S](./input/h2o/DZ/s.dat) | [T](./input/h2o/DZ/t.dat) | [V](./input/h2o/DZ/v.dat) | [ERI](./input/h2o/DZ/eri.dat) | [Mu_X](./input/h2o/DZ/mux.dat) | [Mu_Y](./input/h2o/DZ/muy.dat) | [Mu_Z](./input/h2o/DZ/muz.dat) | [output](./output/dz_h2o/output.dat)
 *  DZP Water [Geometry](./input/h2o/DZP/geom.dat) | [Enuc](./input/h2o/DZP/enuc.dat) | [S](./input/h2o/DZP/s.dat) | [T](./input/h2o/DZP/t.dat) | [V](./input/h2o/DZP/v.dat) | [ERI](./input/h2o/DZP/eri.dat) | [Mu_X](./input/h2o/DZP/mux.dat) | [Mu_Y](./input/h2o/DZP/muy.dat) | [Mu_Z](./input/h2o/DZP/muz.dat) | [output](./output/dzp_h2o/output.dat)
 *  STO-3G Methane [Geometry](./input/ch4/STO-3G/geom.dat) | [Enuc](./input/ch4/STO-3G/enuc.dat) | [S](./input/ch4/STO-3G/s.dat) | [T](./input/ch4/STO-3G/t.dat) | [V](./input/ch4/STO-3G/v.dat) | [ERI](./input/ch4/STO-3G/eri.dat) | [Mu_X](./input/ch4/STO-3G/mux.dat) | [Mu_Y](./input/ch4/STO-3G/muy.dat) | [Mu_Z](./input/ch4/STO-3G/muz.dat) | [output](./output/sto3g_ch4/output.dat)
