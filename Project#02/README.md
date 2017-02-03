# Project #2: Harmonic Vibrational Analysis

The purpose of this project is to extend your fundamental C-language programming techniques through a normal coordinate/harmonic vibrational frequency calculation. The theoretical background and a concise set of instructions for this project may be found [here](./project2-instructions.pdf)

We thank Dr. Yukio Yamaguchi of the University of Georgia for the original version of this project.

## Step 1: Read the Coordinate Data

The coordinate data are given in a format identical to that for [Project #1](../Project%2301). The test case
for the remainder of this project is the water molecule, optimized at the SCF/DZP level of theory. You can find the coordinates (in bohr) in the input directory.

## Step 2: Read the Cartesian Hessian Data

The primary input data for the harmonic vibrational calculation is the Hessian matrix,
which consists of second derivatives of the energy with respect to atomic positions.

<img src="./figures/hessian.png" height="50">

The Hessian matrix (in units of E<sub>h</sub>/a<sub>0</sub><sup>2</sup>) can be downloaded [here](./input/h2o_hessian.txt) for the H<sub>2</sub>O test case. 
The first integer in the file is the number of atoms (which you should compare to the corresponding value from the geometry file as a test of consistency), 
while the remaining values have the following format:

<img src="./figures/hessian-file-format.png" width="200">

 * [Hint 1](./hints/hint1.md): Reading the Hessian

## Step 3: Mass-Weight the Hessian Matrix

Divide each element of the Hessian matrix by the product of square-roots of the masses of the atoms associated with the given coordinates:

<img src="./figures/mass-weighted-hessian.png" height="50">

where m<sub>i</sub> represents the mass of the atom corresponding to atom *i*. Use atomic mass units (amu) for the masses, just as 
for [Project #1](../Project%2301).

 * [Hint 2](./hints/hint2.md): Solution

## Step 4: Diagonalize the Mass-Weighted Hessian Matrix

Compute the eigenvalues of the mass-weighted Hessian:

<img src="./figures/diag-mass-weighted-hessian.png" height="20">

You should consider using the same canned diagonalization function 
you used in [Project #1](../Project%2301).

 * [Hint 3](./hints/hint3.md): Solution

## Step 5: Compute the Harmonic Vibrational Frequencies

The vibrational frequencies are proportional to the squareroot of the eigenvalues of the mass-weighted Hessian:

<img src="./figures/vib-freq.png" height="25">

The most common units to use for vibrational frequencies is cm<sup>-1</sup>.

 * [Hint 4](./hints/hint4.md): Solution

## Reference
E.B. Willson, J.C. Decius, and P.C. Cross, __Molecular Vibrations__, McGraw-Hill, 1955.

## Test Cases

 * Water: [Coordinates](./input/h2o_geom.txt) 
 | [Hessian](./input/h2o_hessian.txt) 
 | [Output](./output/h2o_vib_out.txt) (see the note at the bottom of [Hint 4](./hints/hint4.md))
 * Benzene: [Coordinates](./input/benzene_geom.txt) 
 | [Hessian](./input/benzene_hessian.txt) 
 | [Output](./output/benzene_vib_out.txt)
 * 3-chloro-1-butene: [Coordinates](./input/3c1b_geom.txt) 
 | [Hessian](./input/3c1b_hessian.txt) 
 | [Output](./output/3c1b_vib_out.txt)
