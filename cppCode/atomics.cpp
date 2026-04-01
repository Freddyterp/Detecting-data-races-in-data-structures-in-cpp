#include <atomic>

std::atomic<int> counter(0);


int get() {
    int value = counter.load();
    return value;
}

void increment() {
    counter.fetch_add(1);
}