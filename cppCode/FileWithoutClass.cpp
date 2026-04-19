#include <mutex>

void setValue(int newValue) {
    static int value;
    static std::mutex mtx;

    mtx.lock();
    value = newValue;
    mtx.unlock();
}