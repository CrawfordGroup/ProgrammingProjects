The final out-of-plane angle is computed using the `asin()` function. Note that since sine yields values between -1 and +1, the `asin()` function can only take arguments between -1.0 and +1.0. However, numerical precision in the calculation of the cross- and dot-products earlier in the calculation can yield results slightly outside this domain. Hence, you should test the argument of `asin()` before you call it:
```c++
  theta = (exx + eyy + ezz)/sin(phi[j][k][l]);
 
  if(theta < -1.0) theta = asin(-1.0);
  else if(theta > 1.0) theta = asin(1.0);
  else theta = asin(theta);
```
