## Symettric Matrices
How do we conveniently store the elements of the four-dimensional two-electron integral array in a one-dimensional array?  Consider the lower triangle of an *n x n* symmetric matrix:

<img src="../figures/n-by-n-symmetric-matrix.png" height="125">

The total number of elements in the lower triangle is *M = n(n+1)/2*.  We could store these in a one-dimensional array by ordering them from top-to-bottom, left-to-right:

<img src="../figures/lower-triang-numbered-matrix.png" height="125">

How do we translate row (*i*) and column (*j*) indices of the matrix to the position in the linear array (*ij*)?

<img src="../figures/ioff-compound-index.png" height="70">

Here's a code block to calculate the compound index using a standard [if-then-else conditional](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Control-Statements):
```c++
  int i, j, ij;
  ...
  if(i>j) ij = i*(i+1)/2 + j;
  else ij = j*(j+1)/2 + i;
```
Here's an equivalent piece of code that requires fewer keystrokes:
```c++
  int i, j, ij;
  ...
  ij = i>j ? i*(i+1)/2 + j : j*(j+1)/2 + i;
```

## Four-Dimensional Arrays
The eight-fold permutational symmetry of the two-electron repulsion integrals can be viewed similarly.  The Mulliken-notation integrals are symmetric to permutations of the bra indices or of the ket indices.  Hence, we can view the integral list as a symmetric "super-matrix" of the form:

<img src="../figures/symmetric-integral-matrix.png" height="125">

Thus, just as for the two-dimensional case above, we only need to store the lower triangle of this matrix, and a one-dimensional array of length *M(M+1)/2* will do the trick.  Given four AO indices, *i*, *j*, *k*, and *l* corresponding to the integral, (ij|kl), we can translate these into compound row (*ij*) and column (*kl*) indices using the expression above, as well as the final compound index:

<img src="../figures/ioff-final-compound-index.png" height="70">
