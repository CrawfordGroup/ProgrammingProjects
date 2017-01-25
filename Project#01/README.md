# Molecular-Geometry-Analysis
The purpose of this project is to introduce you to fundamental C-language (or C++) programming techniques in the context of a scientific problem, viz. the calculation of the internal coordinates (bond lengths, bond angles, dihedral angles), moments of inertia, and rotational constants of a polyatomic molecule. A concise set of instructions for this project may be found [here](./project1-instructions.pdf).

We thank Dr. Yukio Yamaguchi of the University of Georgia for the original version of this project.

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
    
The first line above is the number of atoms (an integer), while the remaining lines contain the z-values and x-, y-, and z-coordinates of each atom (one integer followed by three double-precision floating-point numbers). This [input file](./input/acetaldehyde.dat) ("acetaldehyde.dat") along with a few other test cases can be found in this repository in the [input directory](./input).

After downloading the file to your computer (to a file called “geom.dat”, for example), you must open the file, read the data from each line into appropriate variables, and finally close the file.

- [Hint #1](./hints/hint1-1.md): Opening and closing the file stream
- [Hint #2](./hints/hint1-2.md): Reading the number of atoms
- [Hint #3](./hints/hint1-3.md): Storing the z-values and the coordinates
- [Solution](./hints/step1-solution.md)

## Step 2: Bond Lengths
Calculate the interatomic distances using the expression:

![Bond Lengths](./figures/distances.pdf)
```
EQUATION
R_{ij} = \sqrt{\left(x_{i} - x_{j}\right)^{2} + \left(y_i - y_j\right)^{2} + \left(z_i - z_j \right)^{2}}
```

where x, y, and z are Cartesian coordinates and i and j denote atomic indices.

- [Hint 1](./hints/hint2-1.md): Memory allocation
- [Hint 2](./hints/hint2-2.md): Loop structure
- [Hint 3](./hints/hint2-3.md): Printing the results
- [Hint 4](./hints/hint2-4.md): Extending the Molecule class
- [Solution](./hints/step2-solution.md)

## Step 3: Bond Angles
Calculate all possible bond angles. For example, the angle, &phi;<sub>ijk</sub>, between atoms i-j-k, where j is the central atom is given by:

```
EQUATION
{\rm cos}\phi_{ijk} = {\bf {\rm \tilde{e}_{ji}} \dot {\bf {\rm \tilde{e}_{jk}}}
```

where the e&#8407;<sub>ij</sub> are unit vectors between the atoms, e.g.,

```
EQUATION
e_{ij}^{x} = - \left(x_i - x_j\right) / R_{ij}, \qquad e_{ij}^{y} = - \left(y_i - y_j\right) / R_{ij}, \qquad e_{ij}^{z} = - \left( z_i - z_j\right)/R_{ij}
```

- [Hint 1](./hints/hint3-1.md): Memory allocation for the unit vectors
- [Hint 2](./hints/hint3-2.md): Avoiding a divide-by-zero
- [Hint 3](./hints/hint3-3.md): Memory allocation for the bond angles
- [Hint 4](./hints/hint3-4.md): Smart printing
- [Hint 5](./hints/hint3-5.md): Trigonometric functions
- [Solution](./hints/step3-solution.md)

## Step 4: Out-of-Plane Angles
Calculate all possible out-of-plane angles. For example, the angle &theta;<sub>ijkl</sub> for atom i out of the plane containing atoms j-k-l (with k as the central atom, connected to i) is given by:

```
EQUATION
\sin\theta_{ijkl} = \frac{ {\bf {\rm \tilde{e}_{kj}}} \cross {\bf {\rm \tilde{e}_{kl}}}}{\sin\phi_{jkl}} \dot {\bf {\rm \tilde{e}_{ki}}}
```

- [Hint 1](./hints/hint4-1.md): Memory allocation?
- [Hint 2](./hints/hint4-2.md): Cross products
- [Hint 3](./hints/hint4-3.md): Numerical precision
- [Hint 4](./hints/hint4-4.md): Smarter printing
- [Solution](./hints/step4-solution.md)

## Step 5: Torsion/Dihedral Angles
Calculate all possible torsional angles. For example, the torsional angle &tau;<sub>ijkl</sub> for the atom connectivity i-j-k-l is given by:

```
EQUATION
\cos \tau_{ijkl}  =
\frac{
  \left({\bf {\rm \tilde{e}_{ij}}} \cross {\bf {\rm \tilde{e}_{jk}}}\right) \dot
  \left({\bf {\rm \tilde{e}_{jk}}} \cross {\bf {\rm \tilde{e}_{kl}}}\right)
  }{\sin \phi_{ijk} \sin \phi_{jkl}}
```

Can you also determine the sign of the torsional angle?

- [Hint 1](./hints/hint5-1.md): Memory allocation?
- [Hint 2](./hints/hint5-2.md): Numerical precision
- [Hint 3](./hints/hint5-3.md): Smart printing
- [Hint 4](./hints/hint5-4.md): Sign
- [Solution](./hints/step5-solution.md)

## Step 6: Center-of-Mass Translation
Find the center of mass of the molecule:

```
EQUATION
{\rm X}_{c.m.} = \frac{\sum_{i} m_i x_i}{\sum_i m_i}, \qquad
{\rm Y}_{c.m.} = \frac{\sum_{i} m_i y_i}{\sum_i m_i}, \qquad
{\rm Z}_{c.m.} = \frac{\sum_{i} m_i z_i}{\sum_i m_i}.
```

where m<sub>i</sub> is the mass of atom i and the summation runs over all atoms in the molecule.

Translate the input coordinates of the molecule to the center-of-mass.

- [Hint 1](./hints/hint6-1.md): Atomic masses
- [Hint 2](./hints/hint6-2.md): Translating between atomic number and atomic mass
- [Solution](./hints/step6-solution.md)

## Step 7: Principal Moments of Inertia
Calculate elements of the [moment of inertia tensor](http://en.wikipedia.org/wiki/Moment_of_inertia_tensor).

Diagonal:
```
EQUATION
{\rm I}_{xx} = \sum_i m_i\left(y_{i}^{2} + z_{i}^{2}\right), \qquad
{\rm I}_{yy} = \sum_i m_i\left(x_{i}^{2} + z_{i}^{2}\right), \qquad
{\rm I}_{zz} = \sum_i m_i\left(x_{i}^{2} + y_{i}^{2}\right).
```

Off-diagonal:
```
EQUATION
{\rm I}_{xy} = \sum_i m_i x_i y_i, \qquad
{\rm I}_{xz} = \sum_i m_i x_i z_i, \qquad
{\rm I}_{yz} = \sum_i m_i y_i z_i.
```

Diagonalize the inertia tensor to obtain the principal moments of inertia:
```
EQUATION
{\rm I}_a \le {\rm I}_b \le {\rm I}_c
```

Report the moments of inertia in amu bohr<sup>2</sup>, amu &#8491;<sup>2</sup>, and g cm<sup>2</sup>.

Based on the relative values of the principal moments, determine the [molecular rotor type](http://en.wikipedia.org/wiki/Rotational_spectroscopy): linear, oblate, prolate, asymmetric.

- [Hint 1](./hints/hint7-1.md): Diagonalization of a 3×3 matrix
- [Hint 2](./hints/hint7-2.md): Physical constants
- [Solution](./hints/step7-solution.md)

## Step 8: Rotational Constants
Compute the rotational constants in cm<sup>-1</sup> and MHz:

```
EQUATION
A = \frac{h}{8\pi^2c I_a} \\
B = \frac{h}{8\pi^2c I_b} \\
C = \frac{h}{8\pi^2c I_c} \\
A \ge B \ge C

```

- [Solution](./hints/step8-solution.md)


## Test Cases
- Acetaldehyde: [input coordinates](./input/acetaldehyde.dat) | [output](./output/acetaldehyde_out.txt)
- Benzene: [input coordinates](./input/benzene.dat) | [output](./output/benzene_out.txt)
- Allene: [input coordinates](./input/allene.dat) | [output](./output/allene_out.txt)

## References
E.B. Wilson, J.C. Decius, and P.C. Cross, __Molecular Vibrations__, McGraw-Hill, 1955.
