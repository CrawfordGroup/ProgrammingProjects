If you've written your program so that the two-electron integrals are stored in a one-dimensional array, you may have recognized that your program spends quite a bit of its time calculating compound indices.  Is there a way to speed up this process?  Sure!  Pre-compute the indices instead.  Look again at the structure of a symmetric matrix, with the elements of the lower triangle numbered top-to-bottom/left-to-right:

```
EQUATION
\[
\left[
\begin{array}{cccccc}
0 & \ldots & \ldots & \ldots & \ldots & \ldots \\
1 & 2 & \ldots & \ldots & \ldots & \ldots \\
3 & 4 & 5 & \ldots & \ldots & \ldots \\
6 & 7 & 8 & 9 & \ldots & \ldots \\
10 & 11 & 12 & 13 & 14 & \ldots \\
\vdots & \vdots & \vdots & \vdots & \vdots & \ddots
\end{array}
\right]
\]
```

We calculate these above values from the raw row and column indices, *i* and *j*, respectively using:

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
