Here's a code block that demonstrates how to carry out the AO to MO two-electron integral transformation using four N<sup>5</sup> steps.  Note that the original AO- and transformed MO-basis integrals are stored in a one-dimensional array taking advantage of their eight-fold permutational symmetry, as described in [Project #3](../../Project%2303).  However, the half-transformed integrals, which lack bra-ket permutational symmetry, are stored in a two-dimensional array.

A number of convenient functions [`mmult()`, `init_matrix()`, etc.] used in this code block can be found in the [diag.cc](http://sirius.chem.vt.edu/~crawdad/programming/diag.cc) discussed in [Project #1](../../Project%2301).

```c++
  #define INDEX(i,j) ((i>j) ? (((i)*((i)+1)/2)+(j)) : (((j)*((j)+1)/2)+(i)))
  ...
  double **X, **Y, **TMP, *TEI;
  int i, j, k, l, ij, kl, ijkl, klij;

  ...
  X = init_matrix(nao, nao);
  Y = init_matrix(nao, nao);

  TMP = init_matrix((nao*(nao+1)/2),(nao*(nao+1)/2));
  for(i=0,ij=0; i < nao; i++)
    for(j=0; j <= i; j++,ij++) {
      for(k=0,kl=0; k < nao; k++)
        for(l=0; l <= k; l++,kl++) {
          ijkl = INDEX(ij,kl);
          X[k][l] = X[l][k] = TEI[ijkl];
        }
      zero_matrix(Y, nao, nao);
      mmult(C, 1, X, 0, Y, nao, nao, nao);
      zero_matrix(X, nao, nao);
      mmult(Y, 0, C, 0, X, nao, nao, nao);
      for(k=0, kl=0; k < nao; k++)
        for(l=0; l <= k; l++, kl++)
          TMP[kl][ij] = X[k][l];
    }

  zero_array(TEI, (nao*(nao+1)/2)*((nao*(nao+1)/2)+1)/2);

  for(k=0,kl=0; k < nao; k++)
    for(l=0; l <= k; l++,kl++) {
      zero_matrix(X, nao, nao);
      zero_matrix(Y, nao, nao);
      for(i=0,ij=0; i < nao; i++)
        for(j=0; j <=i; j++,ij++)
          X[i][j] = X[j][i] = TMP[kl][ij];
      zero_matrix(Y, nao, nao);
      mmult(C, 1, X, 0, Y, nao, nao, nao);
      zero_matrix(X, nao, nao);
      mmult(Y, 0, C, 0, X, nao, nao, nao);
      for(i=0, ij=0; i < nao; i++)
        for(j=0; j <= i; j++,ij++) {
          klij = INDEX(kl,ij);
          TEI[klij] = X[i][j];
        }
    }

  ...

  free_matrix(X, nao);
  free_matrix(Y, nao);
  free_matrix(TMP, (nao*(nao+1)/2));

```

