Use the ">>" operator to read the data from the file:

```c++
#include <iostream>
#include <fstream>
#include <iomanip>

...

int main()
{  
  ifstream input("geom.dat");

  int natom;
  input >> natom;
    
  input.close();

  return 0;
}
```
