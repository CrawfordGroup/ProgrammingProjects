# Molecular-Geometry-Analysis
The purpose of this project is to introduce you to fundamental C-language (or C++) programming techniques in the context of a scientific problem, viz. the calculation of the internal coordinates (bond lengths, bond angles, dihedral angles), moments of inertia, and rotational constants of a polyatomic molecule. A concise set of instructions for this project may be found in project1-intsructions.pdf

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
    
The first line above is the number of atoms (an integer), while the remaining lines contain the z-values and x-, y-, and z-coordinates of each atom (one integer followed by three double-precision floating-point numbers). This input file ("acetaldehyde.dat") can be found in this repository.

After downloading the file to your computer (to a file called “geom.dat”, for example), you must open the file, read the data from each line into appropriate variables, and finally close the file.

- Hint #1: Opening and closing the file stream
- Hint #2: Reading the number of atoms
- Hint #3: Storing the z-values and the coordinates
- Solution

## Step 2: Bond Lengths
Calculate the interatomic distances using the expression:

```EQUATION```

where x, y, and z are Cartesian coordinates and i and j denote atomic indices.

- Hint 1: Memory allocation
- Hint 2: Loop structure
- Hint 3: Printing the results
- Hint 4: Extending the Molecule class
- Solution

## Step 3: Bond Angles
Calculate all possible bond angles. For example, the angle, \phi_{ijk}, between atoms i-j-k, where j is the central atom is given by:
