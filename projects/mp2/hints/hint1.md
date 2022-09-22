Here's a code block that demonstrates how to carry out the AO to MO two-electron integral transformation using a single N<sup>8</sup> step.  Note that the original AO- and transformed MO-basis integrals are stored in a one-dimensional array taking full advantage of their eight-fold permutational symmetry, as described in [Project #3](../../Project%2303).

Note how the loop structure in the MO-indices (*i*, *j*, *k*, and *l*) automatically takes into account the permutational symmetry of the fully transformed integrals.

```c++
  #define INDEX(i,j) ((i>j) ? (((i)*((i)+1)/2)+(j)) : (((j)*((j)+1)/2)+(i)))
  ...
  double *TEI_AO, *TEI_MO;
  int i, j, k, l, ijkl;
  int p, q, r, s, pq, rs, pqrs;
  ...

  for(i=0,ijkl=0; i < nao; i++) {
    for(j=0; j <= i; j++) {
      for(k=0; k <= i; k++) {
        for(l=0; l <= (i==k ? j : k); l++,ijkl++) {

          for(p=0; p < nao; p++) {
            for(q=0; q < nao; q++) {
              pq = INDEX(p,q);
              for(r=0; r < nao; r++) {
                for(s=0; s < nao; s++) {
                  rs = INDEX(r,s);
                  pqrs = INDEX(pq,rs);

                  TEI_MO[ijkl] += C[p][i] * C[q][j] * C[r][k] * C[s][l] * TEI_AO[pqrs];

                }
              }
            }
          }

        }
      }
    }
  }
```
