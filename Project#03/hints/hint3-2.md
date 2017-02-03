If you've written your program so that the two-electron integrals are stored in a one-dimensional array, you may have recognized that your program spends quite a bit of its time calculating compound indices.  Is there a way to speed up this process?  Sure!  Pre-compute the indices instead.  Look again at the structure of a symmetric matrix, with the elements of the lower triangle numbered top-to-bottom/left-to-right:

<img src="../figures/lower-triang-numbered-matrix2.png" height="150">

We calculate these above values from the raw row and column indices, *i* and *j*, respectively using:

<img src="../figures/ioff-compound-index2.png" height="70">

The expensive part of the above expression is the repeated evaluation of the *i(i+1)/2* and *j(j+1)/2* parts (which correspond to the first column of numbers in the above matrix).  However, if we were to build an integer array (named `ioff`, for example) to store these values, then we could simplify the task to use array look-ups instead:
```c++
ij = (i>j) ? ioff[i] + j : ioff[j] + i;
```

We can build the ioff array using a recursion:
```c++
ioff[0] = 0;
for(int i=1; i < BIGNUM; i++)
  ioff[i] = ioff[i-1] + i;
```
where `BIGNUM` is some large number exceeding the maximum row/column dimension we expect to use in our calculations.
