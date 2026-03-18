#include <iostream>

int foo(int a) {
    int x = a + 1;      // line 5
    x = x * 2;          // line 6
    return x;           // line 7
}

void bar() {
    int y = 10;         // line 11
    if (y > 5) {
        y = y - 2;      // line 13
    } else {
        y = y + 2;      // line 15
    }
    y = y * 3;          // line 17
}

int main() {
    int a = 3;          // line 21
    int b = foo(a);     // line 22
    bar();              // line 23
    std::cout << b << std::endl;  // line 24
}