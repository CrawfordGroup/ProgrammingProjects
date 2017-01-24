An elegant way to translate between the atomic number (z-value) of a given atom and its mass is to prepare a static array of the masses of the most abundant isotope of each element.  I suggest preparing a header file containing a [global array](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Variable-Scope-and-Reference-Types#global-variables), e.g.:
```c++
  double masses[] = {
  0.0000000, 
  1.007825, 
  4.002603,  
  6.015123,
  ...};
```
Note that, for example, `masses[1] = 1.007825`, which is the correct atomic mass for a hydrogen atom.
