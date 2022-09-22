Now that we've written some code to compute bond distances, we can extend the Molecule class a bit more to define our `bond()` function:
```c++
double Molecule::bond(int a, int b)
{
  return sqrt( (geom[a][0]-geom[b][0])*(geom[a][0]-geom[b][0])
             + (geom[a][1]-geom[b][1])*(geom[a][1]-geom[b][1])
             + (geom[a][2]-geom[b][2])*(geom[a][2]-geom[b][2]) );
}
```

Note that since `bond()` is a member function of the Molecule class, we can access the geom array with just `geom` rather than `mol.geom`
