To open a file named "geom.dat", you need a file stream object:

```c++
#include <iostream>
#include <fstream>
#include <iomanip>

...

int main()
{  
  ifstream input("geom.dat");

  ...

  input.close();

  return 0;
}
```
