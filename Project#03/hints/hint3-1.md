## Symettric Matrices
How do we conveniently store the elements of the four-dimensional two-electron integral array in a one-dimensional array?  Consider the lower triangle of an *n x n* symmetric matrix:

```
EQUATION
\[
\left[
\begin{array}{ccccc}
A_{00} & \ldots & \ldots & \ldots & \ldots \\
A_{10} & A_{11} & \ldots & \ldots & \ldots \\
A_{20} & A_{21} & A_{22} & \ldots & \ldots \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
A_{n0} & A_{n1} & A_{n2} & \cdots & A_{nn}\\
\end{array}
\right]
\]
```

The total number of elements in the lower triangle is *M = n(n+1)/2*.  We could store these in a one-dimensional array by ordering them from top-to-bottom, left-to-right:

```
EQUATION
\[
\left[
\begin{array}{cccccc}
0 & \ldots & \ldots & \ldots & \ldots \\
1 & 2 & \ldots & \ldots & \ldots  \\
3 & 4 & 5 & \ldots & \ldots \\
6 & 7 & 8 & 9 & \ldots \\
\vdots & \vdots & \vdots & \vdots & \ddots \\
\end{array}
\right]
\]
```

How do we translate row (*i*) and column (*j*) indices of the matrix to the position in the linear array (*ij*)?

```
EQUATION
\[
ij \equiv \left\{
\begin{array}{lc}
i(i+1)/2 + j & {\rm if}\ \  i>j \\~\\
j(j+1)/2 + i & {\rm if}\ \  i<j \\
\end{array}
\right.
\]

```

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

```
EQUATION
\[
\left[
\begin{array}{cccccc}
(00|00) & \ldots & \ldots & \ldots & \ldots \\
(10|00) & (10|10) & \ldots & \ldots & \ldots \\
(11|00) & (11|10) & (11|11) & \ldots & \ldots \\
(20|00) & (20|10) & (20|11) & (20|20) & \ldots \\
\vdots & \vdots & \vdots & \vdots & \ddots \\
\end{array}
\right]
\]
```

Thus, just as for the two-dimensional case above, we only need to store the lower triangle of this matrix, and a one-dimensional array of length *M(M+1)/2* will do the trick.  Given four AO indices, *i*, *j*, *k*, and *l* corresponding to the integral, (ij|kl), we can translate these into compound row (*ij*) and column (*kl*) indices using the expression above, as well as the final compound index:

```
EQUATION
\[
ijkl \equiv \left\{
\begin{array}{lc}
ij(ij+1)/2 + kl & {\rm if}\ \  ij>kl \\~\\
kl(kl+1)/2 + ij & {\rm if}\ \  ij<kl \\
\end{array}
\right.
\]
```
