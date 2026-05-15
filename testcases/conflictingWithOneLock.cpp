#include <mutex>

class DataOneLock
{
    private:
        int value;
        std::mutex mtx;

    public:

        void setValue(int newValue) {
            std::lock_guard<std::mutex> guard(mtx);
            value = newValue;
        }

        int getValue() {
            int val = value; // unprotected access
            return val;
        }
};