```c++
    for(h=0; h < nirreps; h++) {
      for(i=0; i < sopi[h]; i++) {
        I = symm_offset[h] + i;
        for(j=0; j < sopi[h]; j++) {
          J = symm_offset[h] + j;
          F[h][i][j] = H[h][i][j];

          for(g=0; g < nirreps; g++) {
            for(k=0; k < sopi[g]; k++) {
              K = symm_offset[g] + k;
              for(l=0; l < sopi[g]; l++) {
                L = symm_offset[g] + l;

                ij = INDEX(I,J); kl = INDEX(K,L);
                ijkl = INDEX(ij,kl);
                ik = INDEX(I,K); jl = INDEX(J,L);
                ikjl = INDEX(ik,jl);

                F[h][i][j] += D[g][k][l] * (2.0 * TEI[ijkl] - TEI[ikjl]);
              }
            }

          }
        }
      }
    }
```
