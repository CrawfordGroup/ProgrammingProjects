
This tutorial is intended to touch on many, but certainly not all, of the fundamentals of C++ programming with an emphasis on quantum chemistry.  Although I hope this section will get you started, it is not a substitute for a more complete reference manual. 

# A first example

This is a simple variation of the common "Hello World" program. It is one of the simplest, yet complete, C++ programs:

```c++
#include <iostream>

using std::cout;
using std::endl;

int main(int argc, char *argv[])
{
    cout << "Welcome to the Crawford Group!" << endl;

    return 0;
}
```

Open a new c++ source file called `welcome.cc` in your favorite editor and put the above code inside.
Then we must compile the source:

```
c++ -c welcome.cc
c++ welcome.o -o welcome
```

The first command will generate an object file, welcome.o, while the second will generate the actual executable program, `welcome`. You can execute the final program from the command line:

```
$ ./welcome
Welcome to the Crawford Group!
$
```

The lines that begin with `using …` in the source file allow you to use the functions `std::cout` and `std::endl` without typing the prefix `std::` every time. The signature `std::` indicates that these functions belong to the namespace called `std`. Namespaces allow you to have functions that may be called the same thing, without confusing which one is to be used. Declaring `using std::cout;` at the start of the program indicates to the complier that when we type `cout` we really mean `std::cout`. 

# What is a "compilation"?

Here is our simple program from the initial example:
```c++
#include <iostream>

using std::cout;
using std::endl;

int main(int argc, char *argv[])
{
    cout << "Welcome to the Crawford Group!" << endl;

    return 0;
}
```
Building a program from a source-code file like the above works in two stages: 
  - "compilation" of object files (\*.o) from the raw source code files (\*.cc): `c++ -c welcome.cc`
  - "linking" the object codes into an final executable: `c++ welcome.o -o welcome`

An object file is a translation of the source code into machine code, i.e. instructions recognizable by the computer's CPU.  However, an object file alone is not generally executable because it doesn't usually define all the necessary steps for a complete program.  The purpose of the linking step is to provide all the missing pieces to generate the final product.

Consider the simple program above as an illustration.  The code is intended only to print a few words to the screen, which is identified by the "file stream" named "cout".  However, the source code above does not *define* what `cout` actually is.  Thus, the object file, welcome.o, produced by the compilation step, includes an undefined reference to cout (called a *symbol*), and the linking step supplies the definition. (This definition is actually found in a library file named `libstdc++` located elsewhere in the computer system.)

The program above consists of two parts:
  - The preamble, which refers to the *header file*, iostream.h (but called "iostream" in the code).  This header includes a *declaration* of objects like cout that tell the compiler about the object's fundamental characteristics. If you don't include a declaration of every function or object you use in a program, the compiler should complain.  (Try it!  Remove the `#include <iostream>` line and re-compile.)
  - The `main()` function is the starting point for all programs.  Every C++language program must contain one - and only one - main().

# Code comments

Comments are text inserted into the code that programmer can read, but the complier will skip. In C, comments are surrounded by `/* */` pair. In c++ a comment begin with `// ` and includes everything from that point until the end of the line.

Some examples:

```c++
/* This is a c-style comment */
// this is a c++-style comment

/* This is a 
  C-syle comment that spans 
  several lines */

// This is a C++ style comment 
// that spans several lines.

int a=0; //comments can be on the same line as code. 

/* C-style comments can even be before code */ int b = 0;

// C++ comments can't before the code since they go from the comment indicator
// until the end of the line.
// This int won't be in the code int c= 0;
int c = 0; // but this will! 
``` 

Note: It is extremely important to document your code with appropriate comments, particularly when dealing with complicated scientific code, whose purpose can be difficult to glean by looking at the source.

# Data types and variables

There are several data types that are commonly used in C and C++ programs

| Name | Data | Typical Size (bytes) |
| :----- | :----- | :----- |
| int | Integer| 4 |
| char | Character| 1 |
| float | Floating-point number | 4|
| double | Double-precision Floating-point number | 8 |
| void | No Type (useful for defining functions with no return) | N/A |

Note: The size of data types can vary among computer systems, so you should never assume particular values. The sizes given in this table are only guidelines. Use the `sizeof()` function to determine the size of a type or variable inside your programs.

A variable is a location in memory used to store data. Variables are assigned names and data types by the programer either when they are first used or before hand. Here are some examples: 

```C++
int iter = 0;       // An integer with an initial value of zero 
double energy;      // A double-precision floating-point number with no initial value
int z_vals[50];     // An array of 50 integers
double geom[10][3]; // A 2-d array of doubles, there are 10 sets of 3 values each
```

Note: You should never assume that an uninitialized variable has been zero'd out.

# Operators

There are several types of operators available in C/C++:

Note: this list is not exhaustive and some symbols have multiple operator definitions depending on the context, e.g. the `*` operator can be used for multiplication or to dereference a pointer. ([Pointers/references](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Variable-Scope-and-Reference-Types) will be covered later in the tutorial). 

## Arithmetic Operators

| Operator | Action| Example|
|:---|:---|:---| 
| = | Assignment | `x = y`|
| + | Addition | `c = a+b` |
| - | Subtraction | `c = a-b` |
| * | Multiplication | `c = a*b` |
| / | Division |` c = a/b` |
| % | Modulo (remainder after division) | ` rem = a%b `|
| += | Add then assign | ` a += b` (equivalent to ` a = a+b`)| 
| -= | Subtract then assign | ` a-=b` (equivalent to `a = a-b`)|
| *= | Multiply then assign | ` a*=b` (equivalent to ` a = a*b`)|
| /= | Divide then assign | ` a /=b` (equivalent to ` a = a/b`)|
| ++ | Increment | `a = 0; a++;` (a now is 1 )|
| -- | Decrement | `a = 1; a--;` (a is now 0)|  

## Boolean Comparison Operators
| Operator | Action | Example |
|:---|:---|:---|
| == | Equal to | `a == b` |
| != | Not equal to | ` a != b` |
| > | Greater than | ` a > b` |
| < | Less than | ` a < b `|
| >= | Greater than or equal to | ` a >= b` |
| <= | Less than or equal to | ` a <= b` |

Note: Boolean operator statements return zero if false and non-zero if true

## Logical Operators
| Operator | Action | Example |
|:---|:---|:---|
| && | And | ` (a == b) && (b == c) ` |
| \|\| | Or | ` (a == b) || (b == c) ` |
| ! | Not | `!(a == b)` | 

# Control statements

An executable program consists of a series of statements/instructions that the computer executes in order. That is each line of code is executed from top to bottom sequentially. Control statements define when the default flow of the program should be disrupted. Either by repeating, or skipping instructions: 

<table>
  <tr>
    <td><b>if-else</b></td>
    <td>Select different instructions based on a given set of conditions.</td>
  </tr>
</table>

```C++
if(iter >= maxiter){
    cout<< " Number of iterations exceeded\n";
    exit(2);
}
else {
    cout << "iter = " << iter << endl;
}
```

<table>
  <tr>
    <td><b>switch</b></td>
    <td>A multi-choice if statement.</td>
  </tr>
</table>

```c++
switch(val){
   case 0:
     cout << " Zilch\n";
   case 1:
     cout << " Uno\n";
   case 2: 
     cout << " Dos\n";
   case 3:
     cout << " Tres\n;
   default:
     cout << "A bunch";
     break;
}
```

<table>
  <tr>
    <td><b>while loop</b></td>
    <td>Repeat a series of instructions while the given conditions hold true.</td>
  </tr>
</table>

```c++
int iter = 0;
int maxiter = 10;
while(iter < maxiter){
  x_coord += 2.0;
  iter++; 
}
```

Note the values of `iter` and `maxiter` must be initialized outside the loop. Also note that if `iter` is not incremented inside the loop body, this would result in a infinite loop because the condition would always be true!

<table>
  <tr>
    <td><b>do-while loop</b></td>
    <td>Similar to while, but the instructions are always evaluated at least one time, since the condition is not checked until the end.</td>
  </tr>
</table>

```c++
do {
   x_coord += 2.0;
   iter++;
} while(iter < maxiter);
```

<table>
  <tr>
    <td><b>for loop</b></td>
    <td>One of the most common and powerful control statements. Defines an initial state, a condition, and increment. Loop continues incrementing until the condition is no longer true.</td>
  </tr>
</table>

Standard for loop:
```c++
for(int i = 0; i < max; i++)
{
    cout<< " iter = "<< i << endl;
}
```

The for loop also has several C++ only variants involving what are called `iterators` and are very powerful when used in combination with the  Standard template library (stl) containers. 

For loop using `std::vector<double>::iterator`
```c++
#include <vector>
std::vector<double> vec = {1.0,2.0,3.0,4.0};
cout << " vec = { ";
for(std::vector<double>::iterator it = vec.begin(); it != vec.end(); ++it) {
  cout << " " << *it <<" "; \\ it is a pointer to an element of the vector
                            \\ we use the * operator to get the value pointed to by "it"
}
cout << " }\n"; 

```
Range based for loop. Here is a shorthand for the example above but we will capture the value rather 
than a pointer by declaring the loop variable as a reference. 
```c++
#include <vector>
std::vector<double> vec = {1.0,2.0,3.0,4.0};
cout << " vec = { ";
for(double& val: vec} {
  cout << " " << val << " ";
}
cout << " }\n";
```

<table>
  <tr>
    <td><b>break</b></td>
    <td>Exit a loop or switch based on a given condition (usually placed after an if statement for some condition).</td>
  </tr>
</table>

```c++
for(int i = 0; i < max; i++) { 
   energy += 2.0; 
   cout << " iter = " << i << endl;
   if(energy > 10.0) break;
}

```
This for loop will exit when `energy` gets larger than 10.0, even if `i` is less than `max`!

# Input/Output

The code examples you've seen so far in this tutorial have used the cout object, which automatically writes to the screen. However, one often wishes to write to files for longer-term storage. In addition, one often finds it necessary to read from existing files, e.g. to obtain data necessary for a computation.

There are two fundamental types of file-based input/output (I/O): formatted and unformatted. Formatted means that the data is written to/read from the file as integers, doubles, characters, etc., while unformatted means that the data is handled as raw bytes and (perhaps) interpreted later. Formatted files are convenient because they can be read by simple text editors like vi or emacs (or even Microsoft Word!), while unformatted files appear as gibberish to such programs. On the other hand, unformatted files are usually much more compact than formatted files, and they store numerical data with no additional loss of precision. In this section, we focus on formatted I/O as it's easier to learn and will get you started.

## Header files: cstdio and iostream
To use the functionality described here in a C++ program, you must use the standard I/O header file:
```c++
#include <iostream>
#include <fstream>  // necessary for formatted I/O
```
However, it is also possible to make use of older (but often more convenient) C-language output:
```c
#include <cstdio>
```
which provides declarations for functions like printf() that will be described below.

## File Streams
In C++-based I/O, writing to or reading from files involves special objects called "streams" of type "ifstream" (input stream) or "ofstream" (output stream). Three special C++ streams are:
<table>
  <tr>
    <td><b>cin</b></td>
    <td>Stream for input to a program. This can be keyboard input or input from a "<" redirect, for example.</td>
  </tr>
  <tr>
    <td><b>cout</b></td>
    <td>Stream for output from a program. This can be to the screen or output from a ">" redirect, for example.</td>
  </tr>
  <tr>
    <td><b>cerr</b></td>
    <td>Stream for error or diagnostic information.</td>
  </tr>
</table>

In C-style I/O, the corresponding streams "stdin", "stdout", and "stderr" are of the type "FILE *".

A nice Wikipedia page on standard streams [exists](https://en.wikipedia.org/wiki/Standard_streams)

## Opening and Closing File Streams
### C++ Style
Before you can read or write data, you must first open the desired file stream. If you intend only to read from a given file, the simplest approach declare the stream to be of type “ifstream” and including the name of the file with the declaration:
```c
ifstream my_input("data_file");

// Do something with the file here

my_input.close();
```
If you intend only to write to the file, use “ofstream” instead of “ifstream”. Alternatively, the more general approach is to declare the access mode explicitly:
```c
ifstream my_input("data_file", ios::out | ios::app);
  
// Do something with the file here
  
my_input.close();
```
The name of the file stream is “my_input”, while the physical file is “data_file”. The “ios::out | ios::app” indicates that the file is opened for output, and we will write all new data starting at the end of the file (“append”). Selected C++ access modes are:
<table>
  <tr>
    <td><b>ios::in</b></td>
    <td>Open the file for reading.</td>
  </tr>
  <tr>
    <td><b>ios::out</b></td>
    <td>Create the file for writing.</td>
  </tr>
  <tr>
    <td><b>ios::ate</b></td>
    <td>Set the initial position at the end of the file.</td>
  </tr>
  <tr>
    <td><b>ios::app</b></td>
    <td>All writing occurs at the end of the file (“append”).</td>
  </tr>
  <tr>
    <td><b>ios::trunc</b></td>
    <td>Create a new file for read/write. If the file already exists, delete (“truncate”) its contents.</tr>
</table>
### C Style
In C, open the file with the fopen() function. After you're finished with the file, but before your program ends, you should also close the file stream with the fclose() function.
<table>
  <tr>
    <td><b>fopen()</b></td>
    <td>Open a file for reading and/or writing data.</td>
  </tr>
  <tr>
    <td><b>fclose()</b></td>
    <td>Close an open file stream.</td>
  </tr>
</table>
For example:

```c
#include <cstdio>
FILE *my_input;
my_input = fopen("data_file", "r");
 
// Do something with the file here
 
fclose(my_input);
```
The name of the file stream is “my_input”, while the physical file is “data_file”. The “r” argument (called the “mode”) to fopen() indicates that you will only be reading data from the file. (If you try to write to the file, you'll get an error.) Other common modes:
<table>
  <tr>
    <td><b>r</b></td>
    <td>Open the file for reading.</td>
  </tr>
  <tr>
    <td><b>w</b></td>
    <td>Create the file for writing.</td>
  </tr>
  <tr>
    <td><b>a</b></td>
    <td>Open an existing file for writing, starting at the end of the file ("append").</td>
  </tr>
  <tr>
    <td><b>r+</b></td>
    <td>Open an existing file for read/write.</td>
  </tr>
  <tr>
    <td><b>w+</b></td>
    <td>Create a new file for read/write.</td>
  </tr>
  <tr>
    <td><b>a+</b></td>
    <td>Open an existing file for read/write, starting at the end of the file.</td>
  </tr>
</table>
Note that the standard C-I/O header file must be included for proper declaration of functions like fopen() and fclose().
## Writing Data: << and fprintf()
### C++ Style
Writing data to a file stream in C++ is easy, as long as one isn't too picky about how the output looks. To write to a stream, one need only use the “«” operator, e.g.:
```c++
double a = 3.1415927;
double b = 1.414;
my_file.precision(5);
my_file << a << b << endl;
```
where the precision function sets the number of significant figures to be printed and the “endl” identifier prints an end-of-line and carriage return. The difficulty with C++ formatted output arises when one wants to control the number of decimal places, significant figures (precision), scientific notation, etc. on a compact, field-by-field basis. The syntax for this is significantly less concise than in C, and we will not discuss it further in this tutorial.
### C Style
Writing data to a file stream in C is accomplished with the fprintf() function. For example:
```c
fprintf(my_output, "The number of atoms is %d\n", natoms);
```
Here the file stream is identified by the variable my_output. The second argument to fprintf() is the “format string”, which includes control characters like “%d”. Variables containing data related to the control characters make up the remaining arguments. Note that the “printf()” function is the same as “fprintf(stdout,…).”

Some examples of commonly used control characters include:
<table>
  <tr>
    <td><b>%d</b></td>
    <td>Signed integer.</td>
  </tr>
  <tr>
    <td><b>%u</b></td>
    <td>Unsigned integer.</td>
  </tr>
  <tr>
    <td><b>%f</b></td>
    <td>Floating-point number.</td>
  </tr>
  <tr>
    <td><b>%e</b></td>
    <td>Scientific notation with lower-case "e".</td>
  </tr>
  <tr>
    <td><b>%E</b></td>
    <td>Scientific notation with upper-case "E".</td>
  </tr>
  <tr>
    <td><b>%s</b></td>
    <td>String.</td>
  </tr>
  <tr>
    <td><b>%c</b></td>
    <td>Character.</td>
  </tr>
</table>
You can control the number of digits printed by numerical values between the “%” and the control character. For example:
<table>
  <tr>
    <td><b>%3d</b></td>
    <td>Use three digits for integers, with spaces for leading zeroes.</td>
  </tr>
  <tr>
    <td><b>%03d</b></td>
    <td>Use three digits for integers, including leading zeroes, e.g. "007".</td>
  </tr>
  <tr>
    <td><b>%3d</b></td>
    <td>Print a 20-digit floating point number, with 12 digits to the right of the decimal point.</td>
  </tr>
</table>

## Reading Data: >> and fscanf()

### C++ Style

C++ provides a very simple means for reading data from a file, naturally using the “»” operator (the opposite of “«”):
```c++
int natom;
double energy;
 
my_input >> natom >> energy;
```

Similarly, one may read from the keyboard using the “cin” stream.

### C Style
There are numerous ways to read data from a file stream, but we'll focus here on the fscanf() function, which works very similarly to fprintf():
```c
int natom;
double energy;
 
fscanf(my_input, "%d %lf", &natom, &energy);
```
This function reads from the current position of the stream “my_input” an integer and a double, placing the results into the variables natom and energy, respectively. (Note that, in order for the values of the variables to be changed, the **addresses** of natom and energy must be given to fscanf(). More on this in later sections of this tutorial.)

The control characters are much like those used with fprintf(), though field widths are not specified. Some common control characters:
<table>
  <tr>
    <td><b>%d</b></td>
    <td>Signed integer.</td>
  </tr>
  <tr>
    <td><b>%f</b></td>
    <td>Single-precision floating-point number.</td>
  </tr>
  <tr>
    <td><b>%lf</b></td>
    <td>Double-precision floating-point number.</td>
  </tr>
  <tr>
    <td><b>%s</b></td>
    <td>String.</td>
  </tr>
  <tr>
    <td><b>%c</b></td>
    <td>Character.</td>
  </tr>
</table>
Note that the “scanf()” function is the same as “fscanf(stdin,…).”

# Functions

Functions are essential in C++ because they can be used for repetitive tasks and to simplify code. For example,
```c++
#include <iostream>
using namespace std;
 
double power(double, int);
 
int main()
{
  int exponent=18;
  double base=5.3;
  double value;
 
  value = power(base,exponent);
  cout.precision(12);
  cout << value << endl;
 
  return 0;
}
 
double power(double a, int n)
{
  int i;
  double val=a;
 
  for(i=1; i < n; i++)
    val *= a;
 
  return val;
}
```
The function power() calculates the value of (base)^(exponent), and is defined explicitly in the code segment following main(). The function takes two arguments, a double and an int (in that order), and it returns a double, which main() prints to stdout. Some points to note:

* Above the code for main() we find the “declaration” of the power() function, including the types of its arguments and return value. This declaration is necessary so that the compiler can make sure that the use of power() remains consistent throughout the code. (Think of the compiler as reading the source code blindly from top to bottom.)
* Note that the names of the variables passed to power() by main() do not match (a and n vs. base and exponent). This is an example of [variable scope](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Variable-Scope-and-Reference-Types).
* The cout.precision(12) directive tells the output stream to include 12 significant figures when printing the numerical value.

## Functions in Difference Source-Code Files
The example above includes the definition of the power() function in the same file as main(), but this is not actually necessary. We could instead put all the code down to the end of main() in one file (perhaps called “func.cc”) and the code for power() into another file (perhaps called “power.cc”). If we then try to [compile](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/What-is-a-%22Compilation%22%3F) func.cc, we get an error:
```shell
[arrakis:~] crawdad% c++ -c func.c
[arrakis:~] crawdad% c++ func.o -o func
  "power(double, int)", referenced from:
      _main in func.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
```
This rather cryptic-looking output tells us that the compiler doesn't know what this thing called “power()” is and so the [link step](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/What-is-a-%22Compilation%22%3F) failed. Hence, we must first compile each source file and link both together in the end:
```shell
[arrakis:~] crawdad% c++ func.o power.o -o func
[arrakis:~] crawdad% c++ power.o func.o -o func
[arrakis:~] crawdad% func
1.08884397618e+13
```
## CMake

When you have more than a couple of source code files, the command-line compilation and link process can get very tedious. The “cmake” program can simplify one's like greatly. More on this topic is available [here](https://cmake.org/cmake/help/latest/guide/tutorial/A%20Basic%20Starting%20Point.html).

# Variable scope and reference types

A variable can be “local” (available only to the function that declared it) or “global” (available to all or some subset of functions in a program).

## Local Variables
Here's a simple example:
```c++
#include <iostream>
 
using namespace std;
 
void junk(int);
 
int main()
{
  int i=1;
 
  cout << "in main, i= " << i << endl;
  junk(i);
  cout << "in main, i= " << i << endl;
 
  return 0;
}
 
void junk(int i)
{
  i=2;
  cout << "in junk, i= " << i << endl;
}
```
If we compile this code and run it, we obtain the following output:
```
in main, i=1
in junk, i=2
in main, i=1
```
Notice that the variable “i” in main() is completely independent of the variable “i” in junk(). Even though its name appears to be the same, the variable i is declared separately in each function and is therefore **local** to each function.

How can we change the value of a variable in a function? By providing the function with the address of the variable (i.e. a pointer to it):
```c++
#include <iostream>
 
using namespace std;
 
void junk(int *);
 
int main()
{
  int i=1;
 
  cout << "in main, i= " << i << endl;
  junk(&i);
  cout << "in main, i= " << i << endl;
 
  return 0;
}
 
void junk(int *i)
{
  *i=2;
  cout << "in junk, i= " << *i << endl;
}
```
This code gives a slightly different output:
```
in main, i=1
in junk, i=2
in main, i=2
```
What did we modify?
1. The argument of junk() changed from int to pointer-to-int.The argument of junk() changed from int to pointer-to-int.
2. Inside junk(), since i is now an address, we must dereference it (“*i”) to refer to the value at that address.
3. The call to junk() in main() changed to use the reference to its local variable i (“&i”).

## Global Variables
If you want a variable to be available to several functions simultaneously, you must declare the variable *globally*. For example, we could make the variable “i” above global by moving its declaration outside of both main() and junk():
```c++
#include <iostream>
 
using namespace std;
 
int i;
void junk(void);
 
int main()
{
  i=1;
 
  cout << "in main, i= " << i << endl;
  junk();
  cout << "in main, i= " << i << endl;
 
  return 0;
}
 
void junk(void)
{
  i=2;
  cout << "in junk, i= " << i << endl;
}
```
This gives exactly the same output as before, even though “i” is handled very differently:
```
in main, i=1
in junk, i=2
in main, i=2
```

## Reference Types

C++ also provides reference types, which are related to pointers, but a bit safer to use (and thus less flexible). Reference types are declared using the “&” syntax, as we can see by the following example:
```c++
#include <iostream>
 
using namespace std;
 
void junk(int &);
 
int main()
{
  int i=1;
 
  cout << "in main, i= " << i << endl;
  junk(i);
  cout << "in main, i= " << i << endl;
 
  return 0;
}
 
void junk(int &i)
{
  i=2;
  cout << "in junk, i= " << i << endl;
}
```
Here “i” is of type int, but is implicitly cast to type “reference to int” when passed into junk(). Modifying “i” inside junk() now changes its value from within the scope of main() as well.

Reference types differ from pointers in that, once a reference type has been initialized, it cannot be re-assigned (“reseated”). This is helpful to compilers that cannot make such assumptions with pointers, which can be reseated at will (and often dangerously!). This also implies that reference types cannot be NULL (again unlike pointers), and so must be initialized as soon as they are defined.

# Memory allocation

The computer's physical memory is used to store the data contained in variables, arrays, etc. In quantum chemistry programs, where the size of the computed data can range from megabytes to terabytes (and petabytes are approaching rapidly), efficient use of memory is vital. The purpose of this section is to explain the fundamentals of C++-language memory allocation/deallocation.

## Pointers
Each piece of data used by a program (integers, doubles, characters, etc.) is associated with a memory location/address, often referred to by a hexadecimal number (e.g., 0x8130). A pointer is a data type that can be used to store such addresses. For example, imagine we have an integer variable named “natom” whose address we need [e.g., to pass to a function]. We can obtain the address using the “address of” operator (also called the “reference” operator):
```c++
int natom
...
great_function(&natom);
```
Note carefully the difference between natom and &natom: the former refers to the *value* of the variable natom; the latter refers to the *memory address* of the value of the variable natom. (An explanation of the need to pass a pointer in this case can be found in the section on [scope](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Variable-Scope-and-Reference-Types).)

If we needed to *store* this address for later use, we could declare a variable of type “pointer-to-int”:
```c++
int *natom_address;
 
natom_address = &natom;
```
Notice the use of the “*” syntax to identify the pointer variable. This syntax can be used with any data type: int, double, char, etc. (even “void”).

What if we know the pointer (address), and we'd like to know the value stored there? We can access that using the “indirection” (dereference) operator:
```c++
cout << "Number of atoms: " << *natom_address << endl;
```
(If you instead tried to print natom_address instead of *natom_address, above, you would most likely get a strange-looking integer value, i.e. the hexadecimal representation of the actual memory address.)

The notion of a pointer also means that we can indirectly change the value of natom using its address. For example, the following code will print the number 10, not 7:
```c++
natom = 7;
natom_address = &natom;
*natom_address = 10;
cout << "Number of atoms: " << natom << endl;
```
## Arrays
One way to declare an array in C++ is using the standard bracket notation, e.g.
```c++
int zvals[10];  /* declare an array of 10 integers */
...
cout << "The z-value of the first atom is: " << zvals[0] << endl;
```
Notice that in C++, array indices begin at element “0”. However, the variable named “zvals” is actually a pointer-to-int, meaning we could also use the syntax:
```c++
cout << "The z-value of the first atom is: " << *zvals << endl;
```
How do we access the other elements of the array using this notation? We can take advantage of so-called “pointer arithmetic”:
```c++
cout << "The z-value of the second atom is: " << *(zvals+1) << endl;  // Same as zvals[1]
```
The notation “zvals+1” refers to the memory address of the next element in the array, which we dereference with the “*” operator (This notation works because the integers in the array occupy consecutive memory locations). Hence, we could print all the elements of the array using the bracket notation:
```c++
for(i=0; i < 10; i++)
  cout << "Z-value of atom " << i << " is " << zvals[i] << endl;
```
or, equivalently,
```c++
for(i=0; i < 10; i++)
  cout << "Z-value of atom " << i << " is " << *(zvals+i) << endl;
```

## new[] and delete[]
There are two ways to allocate memory for things like arrays: statically or dynamically. In fact, there are two types of memory available to your program: the “stack” and the “heap”. The former is used for all data, instructions, etc. allocated at compile-time (static); the latter is for memory allocated at run time (dynamic). 

Static allocation means that the memory is allocated when the program is compiled (aptly named "compile-time"), as in cases when one uses syntax like:
```c++
int zvals[10];
```
Dynamic means that the memory is allocated when the program is executed (“run-time”). The advantage of dynamic allocation is that the program itself can determine how much memory it needs as it runs (e.g. based on input data).

In C++, a common approach to allocate memory dynamically is using the new[] operator:
```c++
int *zvals = new int[10];
...
delete[] zvals;
```
Alternatively, one can use the malloc() function:
```c++
int *zvals = (int *) malloc(10 * sizeof(int));
...
free(zvals);
```
In these examples, we explicitly declare the variable zvals to be a pointer-to-int, but until we assign it a value, it's meaningless. The new[] operator takes the data type (in this case, “int”) and the number of elements needed and returns a pointer. The malloc() function takes as an argument the number of bytes needed and returns a pointer to the allocated memory. The sizeof() function returns the number of bytes associated with a given data type (See the section on [data types](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Data-Types-and-Variables) for more information). (Note: Technically, the malloc() function takes as an argument a value of type “size_t”, which can generally be thought of as a “byte”). The “(int *)” syntax to the left of malloc() is called a “cast”; it converts the value returned by malloc() (called a “pointer-to-void” or “void *”) into a pointer-to-int, to match the declared type of zvals. Note also the use of stdlib.h, which provides the necessary declaration of malloc().

If the call to new[] or malloc() is successful, we may then access the elements of zvals using the usual syntax: zvals[0], zvals[1], etc.

After we are finished with the memory, we must release it back to the computer. If we allocated it using new[], then we return it using the delete[] operator:
```c++
delete[] zvals;
```
If we used malloc(), then we return it with the free() function:
```c++
free(zvals);
```
It's important to delete[]/free() memory allocated with new[]/malloc(), not only because it's good coding practice, but also because it can often reveal subtle memory access errors elsewhere in your program.

## Matrices
As with arrays, C++ provides syntax to declare matrices and higher-dimensional structures:
```c++
int geom[10][3];
```
With the above syntax, the matrix “geom” would be allocated at compile-time (statically) using 30 consecutive integers in memory stored “row-wise” or in “row-major” ordering (i.e., the first three elements in memory would constitute row 0, the next three row 1, etc. Note that the Fortran programming language stores matrices “column-wise”, such that consecutive memory locations follow along the matrix columns). We access the elements of the matrix using the usual bracket notation, e.g. “geom[6][2]” would yield the value on the 7th row and 3rd column of the matrix.

An equivalent way to achieve the above using dynamic memory allocation is to declare geom as a “pointer-to-pointer-to-int”:
```c++
int **geom = new int* [10];
for(int i=0; i < 10; i++)
  geom[i] = new int[3];
```
This is complicated the first few times you go through it, so be patient:
* The variable geom is a pointer-to-pointer-to-int, but the value to which it points is also a pointer, e.g. geom is of type “int **”, but geom[0] is of type “int *”.
* The first call to new[] allocates space for an array of pointers-to-int, each of which will contain the address of the first element of each row of the matrix.
* The calls to new[] inside the loop independently allocate each row of the matrix as an array of integers.
* We can access the elements of the matrix with exactly the same syntax as that for the statically allocated matrix, e.g. “geom[6][2]”.
Note that the static allocation of a matrix above yields a set of *consecutive* addresses in memory (“contiguous” memory allocation), while the dynamic method above only guarantees that each row of the matrix is contiguous. A method for dynamically allocating a matrix with contiguous storage will be described elsewhere.

To release the memory after we are finished with it, we could use:
```c++
for(int i=0; i < 10; i++)
  delete[] geom[i];
delete[] geom;
```
Notice that we have one delete[] call for every new[] call above and that the release of the rows occurs before the release of the pointers to the rows.

# Classes and objects

An important feature of the C++ language is its facility for object-oriented programming (OOP), enabled through constructs called “classes”. Classes often allow the programmer to design code with a more natural structure that can be easier to maintain and extend. We'll briefly summarize the concepts and syntax here, and the later programming projects will help to solidify the ideas.

## A Simple Example: Molecule
What are the basic characteristics of a molecule? A molecule consists of a number of nuclei and electrons, and the difference between the sum of the atomic numbers of the nuclei and the number of electrons is the overall molecular charge. In the Born-Oppenheimer approximation, the massive nuclei have fixed relative positions in space, and these positions may or may not exhibit some amount of symmetry.

What do we typically do with these data? We can imagine rotating the molecule in space or translating it to a new position. Or we might imagine computing the principal moments of inertia of the molecule and subsequently its rotational constants. We might want to compute the distances between the molecule's substituent atoms, or the relevant bond angles or torsional angles.

A class is a special type that collects data (e.g. the molecule's characteristics) and operations/functions (e.g. actions we take on such data) together. For example, we could define a “Molecule” class using the above information as follows:
```c++
#include <string>
 
using namespace std;
 
class Molecule
{
  public:
    int natom;
    int charge;
    int *zvals;
    double **geom;
    string point_group;
 
    void print_geom();
    void rotate(double phi);
    void translate(double x, double y, double z);
    double bond(int atom1, int atom2);
    double angle(int atom1, int atom2, int atom3);
    double torsion(int atom1, int atom2, int atom3, int atom4);
 
    Molecule();
    ~Molecule();
};
```
The syntax gives a name of the class (“Molecule”), defines the relevant data/variables (natom, charge, etc.), and provides declarations (but not yet definitions) of various member functions associated with the class [rotate(), translate(), bond(), etc.]. The “public:” directive indicates that all of these variables and functions are available to any code making use of an object of type Molecule. If some data needs to be kept accessible only by member functions, then they would be placed under a “private:” directive.

The last two functions “Molecule()” and “~Molecule()” are called the “constructor” and “destructor”, respectively. The former is automatically called whenever an object of type “Molecule” is declared (“instantiated”, to use the language of C++ afficionados), while the latter is automatically called whenever the object goes out of [scope](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Variable-Scope-and-Reference-Types).

If we place the above code into a file called “molecule.h” then we can create another file called, for example, “molecule.cc”, in which we define the relevant functions:
```c++
#include "molecule.h"
#include <cstdio>
 
void Molecule::print_geom()
{
  for(int i=0; i < natom; i++)
    printf("%d %8.5f %8.5f %8.5f\n", zvals[i], geom[i][0], geom[i][1], geom[i][2]);
}
 
void Molecule::translate(double x, double y, double z)
{
  for(int i=0; i < natom; i++) {
     geom[i][0] += x;
     geom[i][1] += y;
     geom[i][2] += z;
  }
}
 
Molecule::Molecule(){ }
Molecule::~Molecule(){ }
```
Here we've explicitly defined the “print_geom()” and “translate()” member functions using the name of the class as a prefix (“Molecule::”) to keep them separate from any other “print_geom()” or “translate()” functions that might exist in some other part of the program (i.e., these functions can only be used with Molecule objects). In addition, we've defined constructor and destructor functions that don't do anything (for now).

How do we use this new class? Here's an example in which we prepare a water molecule, print its coordinates, translate it along the x-axis, and print the coordinates again:
```c++
#include "molecule.h"
 
using namespace std;
 
int main(int argc, char *argv[])
{
  Molecule h2o;
 
  h2o.natom = 3;
  h2o.charge = 0;
  h2o.zvals = new int[h2o.natom];
  h2o.geom = new double* [h2o.natom];
  for(int i=0; i < h2o.natom; i++)
    h2o.geom[i] = new double[3];
 
  h2o.zvals[0] = 8;
  h2o.geom[0][0] =  0.000000000000;
  h2o.geom[0][1] =  0.000000000000;
  h2o.geom[0][2] = -0.122368916506;
  h2o.zvals[1] = 1;
  h2o.geom[1][0] =  0.000000000000;
  h2o.geom[1][1] =  1.414995841403;
  h2o.geom[1][2] =  0.971041753535;
  h2o.zvals[2] = 1;
  h2o.geom[2][0] =  0.000000000000;
  h2o.geom[2][1] = -1.414995841403;
  h2o.geom[2][2] =  0.971041753535;
 
  h2o.print_geom();
  h2o.translate(5, 0, 0);
  h2o.print_geom();
 
  delete[] h2o.zvals;
  for(int i=0; i < h2o.natom; i++)
    delete[] h2o.geom[i];
  delete[] h2o.geom;
 
  return 0;
}
```
First, we declare an object named “h2o” that is of type “Molecule” and directly set the number of atoms, the molecular charge, the atomic numbers, and the Cartesian coordinates (in bohr) using the name of the object and a period to identify the member data or function (e.g. “h2o.natom”). If we place this code into a separate file named “water.cc” in the same directory as “molecule.h” and “molecule.cc”, we can compile this code using the following commands:
```
c++ -c molecule.cc
c++ -c water.cc
c++ water.o molecule.o -o water
```
The output from the program is:
```
8  0.00000  0.00000 -0.12237
1  0.00000  1.41500  0.97104
1  0.00000 -1.41500  0.97104
8  5.00000  0.00000 -0.12237
1  5.00000  1.41500  0.97104
1  5.00000 -1.41500  0.97104
```
You can extend the class by adding your own definitions of the member functions rotate(), bond(), etc., which may be very useful for [Project #1](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2301).

## Constructor and Destructor Functions
In the above molecule.cc example, we entered blank placeholders for the constructor [“Molecule()”] and destructor [“~Molecule()”]. Let's make them more useful. First, let's have the constructor take arguments as the number of atoms and the molecular charge:
```c++
Molecule::Molecule(int n, int q)
{
  natom = n;
  charge = q;
  zvals = new int[natom];
  geom = new double* [natom];
  for(int i=0; i < natom; i++)
    geom[i] = new double[3];
}
```
Next, let's have the destructor delete[] the memory we allocated in the constructor automatically (Remember that the destructor member function is called when the object goes out of scope).
```c++
Molecule::~Molecule()
{
  delete[] zvals;
  for(int i=0; i < natom; i++)
    delete[] geom[i];
  delete[] geom;
}
```
Since we changed the constructor to take two arguments, we also need to modify its declaration in molecule.h:
```c++
#include <string>
 
class Molecule
{
  public:
    int natom;
    int charge;
    int *zvals;
    double **geom;
    string point_group;
 
    void print_geom();
    void rotate(double phi);
    void translate(double x, double y, double z);
    double bond(int atom1, int atom2);
    double angle(int atom1, int atom2, int atom3);
    double torsion(int atom1, int atom2, int atom3, int atom4);
 
    Molecule(int n, int q);
    ~Molecule();
};
```
Now our water.cc code becomes a bit simpler because the constructor and destructor do the work of allocating and deleting the memory for us:
```c++
#include "molecule.h"
 
using namespace std;
 
int main(int argc, char *argv[])
{
  Molecule h2o(3,0);
 
  h2o.zvals[0] = 8;
  h2o.geom[0][0] =  0.000000000000;
  h2o.geom[0][1] =  0.000000000000;
  h2o.geom[0][2] = -0.122368916506;
  h2o.zvals[1] = 1;
  h2o.geom[1][0] =  0.000000000000;
  h2o.geom[1][1] =  1.414995841403;
  h2o.geom[1][2] =  0.971041753535;
  h2o.zvals[2] = 1;
  h2o.geom[2][0] =  0.000000000000;
  h2o.geom[2][1] = -1.414995841403;
  h2o.geom[2][2] =  0.971041753535;
 
  h2o.print_geom();
  h2o.translate(5, 0, 0);
  h2o.print_geom();
 
  return 0;
}
```
However, this is still very inconvenient, because the programmer is required to include the Z-values and Cartesian coordinates of each atom explicitly in the program. What if we instead define the constructor such that the values could be read from a file containing the necessary data, such as:
```
3
8 0.000000000000  0.000000000000 -0.122368916506
1 0.000000000000  1.414995841403  0.971041753535
1 0.000000000000 -1.414995841403  0.971041753535
```
The first integer is the number of atoms, and each subsequent line contains the atomic number, and coordinates (in bohr) each each atomic center. A molecule constructor that can read this file for us could be written as:
```c++
#include <iostream>
#include <fstream>
#include <iomanip>
#include <cstdio>
#include <cassert>

Molecule::Molecule(const char *filename, int q)
{
  charge = q;

  // open filename
  std::ifstream is(filename);
  assert(is.good());

  // read the number of atoms from filename
  is >> natom;

  // allocate space
  zvals = new int[natom];
  geom = new double* [natom];
  for(int i=0; i < natom; i++)
    geom[i] = new double[3];

  for(unsigned int i=0; i < natom; i++)
    is >> zvals[i] >> geom[i][0] >> geom[i][1] >> geom[i][2];

  is.close();
}
```
Don't forget to change the declaration of the constructor in “molecule.h” to use the new arguments:
```c++
Molecule(const char *filename, int q);
```

This code simplifies our main program considerably:
```c++
#include "molecule.h"

using namespace std;

int main(int argc, char *argv[])
{
  Molecule h2o("geom.dat", 0);

  h2o.print_geom();
  h2o.translate(5, 0, 0);
  h2o.print_geom();

  return 0;
}
```
If we place the Z-values and coordinates in the file “geom.dat”, the above code will automatically build the molecule object making use of these data, including dynamic allocation of the requisite memory. Furthermore, when the object goes out of scope, the memory is automatically returned to the system.

# Overloading and templates

An essential feature of an object-oriented language like C++ is the ability to “overload” functions – that is, to use the same function name to perform different tasks depending on the arguments provided. For example, we could define a new version of the constructor for our molecule class that reads the Z-values and Cartesian coordinates of the atoms from a file, rather than forcing the programming to provide them in the code itself:
```c++
#include <iostream>
#include <fstream>
#include <iomanip>
#include <cstdio>
#include <cassert>

Molecule::Molecule(const char *filename, int n, int q)
{
  natom = n;
  charge = q;

  // allocate space
  zvals = new int[natom];
  geom = new double* [natom];
  for(int i=0; i < natom; i++)
    geom[i] = new double[3];

  std::ifstream is(filename);
  assert(is.good());

  for(unsigned int i=0; i < natom; i++)
    is >> zvals[i] >> geom[i][0] >> geom[i][1] >> geom[i][2];

  is.close();
}
```

# Linear Algebra in C++: Eigen

Work through the [Eigen tutorial](https://eigen.tuxfamily.org/dox/GettingStarted.html). Eigen can be linked to your executable/library using CMake

```cmake
cmake_minimum_required(VERSION 3.0)
project(solution)

find_package(Eigen3 3.4 REQUIRED NO_MODULE)

add_executable(solution solution.cpp)
target_link_libraries(solution Eigen3::Eigen3)
```

and building out of source

```bash
mkdir build && cd build && cmake -DCMAKE_PREFIX_PATH=/usr/local/miniconda3 .. && cmake --build .
```

# References

For more C++ language details, you may find the standard text by Josuttis [buy it](http://www.amazon.com/C-Standard-Library-Tutorial-Reference/dp/0201379260) useful or, for VT users, get it [on-line from the campus library](http://proquest.safaribooksonline.com/0201379260) or a decent on-line tutorial such as [this one](http://www.cplusplus.com/doc/tutorial/) or [this one](http://www.cprogramming.com/tutorial.html).
