# TODO:
- [ ] Add embedded equations
- [ ] Add hints and solutions for each step
- [x] Add input/output links for test cases

# Molecular-Geometry-Analysis
The purpose of this project is to introduce you to fundamental C-language (or C++) programming techniques in the context of a scientific problem, viz. the calculation of the internal coordinates (bond lengths, bond angles, dihedral angles), moments of inertia, and rotational constants of a polyatomic molecule. A concise set of instructions for this project may be found [here](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2301/project1-instructions.pdf).

## Step 1: Read the Coordinate Data from Input
The input to the program is the set of Cartesian coordinates of the atoms (in bohr) and their associated atomic numbers. A sample molecule (acetaldehyde) to use as input to the program is:

    7
    6  0.000000000000     0.000000000000     0.000000000000
    6  0.000000000000     0.000000000000     2.845112131228
    8  1.899115961744     0.000000000000     4.139062527233
    1 -1.894048308506     0.000000000000     3.747688672216
    1  1.942500819960     0.000000000000    -0.701145981971
    1 -1.007295466862    -1.669971842687    -0.705916966833
    1 -1.007295466862     1.669971842687    -0.705916966833
    
The first line above is the number of atoms (an integer), while the remaining lines contain the z-values and x-, y-, and z-coordinates of each atom (one integer followed by three double-precision floating-point numbers). This [input file](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2301/input/acetaldehyde.dat) ("acetaldehyde.dat") along with a few other test cases can be found in this repository in the [input directory](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2301/input).

After downloading the file to your computer (to a file called “geom.dat”, for example), you must open the file, read the data from each line into appropriate variables, and finally close the file.

- Hint #1: Opening and closing the file stream
- Hint #2: Reading the number of atoms
- Hint #3: Storing the z-values and the coordinates
- Solution

## Step 2: Bond Lengths
Calculate the interatomic distances using the expression:

```
EQUATION
```

where x, y, and z are Cartesian coordinates and i and j denote atomic indices.

- Hint 1: Memory allocation
- Hint 2: Loop structure
- Hint 3: Printing the results
- Hint 4: Extending the Molecule class
- Solution

## Step 3: Bond Angles
Calculate all possible bond angles. For example, the angle, &phi;<sub>ijk</sub>, between atoms i-j-k, where j is the central atom is given by:

```
EQUATION
```

where the e&#8407;<sub>ij</sub> are unit vectors between the atoms, e.g.,

```
EQUATION
```

- Hint 1: Memory allocation for the unit vectors
- Hint 2: Avoiding a divide-by-zero
- Hint 3: Memory allocation for the bond angles
- Hint 4: Smart printing
- Hint 5: Trigonometric functions
- Solution

## Step 4: Out-of-Plane Angles
Calculate all possible out-of-plane angles. For example, the angle &theta;<sub>ijkl</sub> for atom i out of the plane containing atoms j-k-l (with k as the central atom, connected to i) is given by:

```
EQUATION
```

- Hint 1: Memory allocation?
- Hint 2: Cross products
- Hint 3: Numerical precision
- Hint 4: Smarter printing
- Solution

## Step 5: Torsion/Dihedral Angles
Calculate all possible torsional angles. For example, the torsional angle &tau;<sub>ijkl</sub> for the atom connectivity i-j-k-l is given by:

```
EQUATION
```

Can you also determine the sign of the torsional angle?

- Hint 1: Memory allocation?
- Hint 2: Numerical precision
- Hint 3: Smart printing
- Hint 4: Sign
- Solution

## Step 6: Center-of-Mass Translation
Find the center of mass of the molecule:

```
EQUATION
```

where m<sub>i</sub> is the mass of atom i and the summation runs over all atoms in the molecule.

Translate the input coordinates of the molecule to the center-of-mass.

- Hint 1: Atomic masses
- Hint 2: Translating between atomic number and atomic mass
- Solution

## Step 7: Principal Moments of Inertia
Calculate elements of the [moment of inertia tensor](http://en.wikipedia.org/wiki/Moment_of_inertia_tensor).

Diagonal:
```
EQUATION
```

Off-diagonal:
```
EQUATION
```

Diagonalize the inertia tensor to obtain the principal moments of inertia:
```
EQUATION
```

Report the moments of inertia in amu bohr<sup>2</sup>, amu &#8491;<sup>2</sup>, and g cm<sup>2</sup>.

Based on the relative values of the principal moments, determine the [molecular rotor type](http://en.wikipedia.org/wiki/Rotational_spectroscopy): linear, oblate, prolate, asymmetric.

- Hint 1: Diagonalization of a 3×3 matrix
- Hint 2: Physical constants
- Solution

## Step 8: Rotational Constants
Compute the rotational constants in cm<sup>-1</sup> and MHz:

```
EQUATION
```

- Solution


## Test Cases
- Acetaldehyde: [input coordinates](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2301/input/acetaldehyde.dat) | [output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2301/output/acetaldehyde_out.txt)
- Benzene: [input coordinates](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2301/input/benzene.dat) | [output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2301/output/benzene_out.txt)
- Allene: [input coordinates](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2301/input/allene.dat) | [output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2301/output/allene_out.txt)

## References
E.B. Wilson, J.C. Decius, and P.C. Cross, __Molecular Vibrations__, McGraw-Hill, 1955.
