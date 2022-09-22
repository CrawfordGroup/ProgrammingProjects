This block of code takes the one-dimensional array of MO-basis spatial-orbital two-electron integrals we've been using thus far and translates it to a four-dimensional array of antisymmetrized integrals over spin-orbitals.  Note that alpha and beta spin functions alternate here, with even-numbered orbitals corresponding to alpha, and odd-numbered to beta.  The variable `nmo` is the number of spin orbitals, and the `INDEX` function is the same as that [used before](../../Project%2303/hints/hint7-2.md).

```c++
  /* Translate integrals to spin-orbital basis */
  for(p=0; p < nmo; p++)
    for(q=0; q < nmo; q++)
      for(r=0; r < nmo; r++)
        for(s=0; s < nmo; s++) {
          pr = INDEX(p/2,r/2);
          qs = INDEX(q/2,s/2);
          prqs = INDEX(pr,qs);
          value1 = TEI[prqs] * (p%2 == r%2) * (q%2 == s%2);
          ps = INDEX(p/2,s/2);
          qr = INDEX(q/2,r/2);
          psqr = INDEX(ps,qr);
          value2 = TEI[psqr] * (p%2 == s%2) * (q%2 == r%2);
          ints[p][q][r][s] = value1 - value2;
        }
```
