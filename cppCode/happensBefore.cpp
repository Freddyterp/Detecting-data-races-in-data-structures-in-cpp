#include <iostream>

int foo(int a) {
    int x = a + 1;      
    x = x * 2;          
    return x;           
}

void bar() {
    int y = 10;         
    if (y > 5) {
        y = y - 2;      
    } else {
        y = y + 2;      
    }
    y = y * 3;         
}

int main() {
    int a = 3;          
    int b = foo(a);     
    bar();              
    std::cout << b << std::endl;
}