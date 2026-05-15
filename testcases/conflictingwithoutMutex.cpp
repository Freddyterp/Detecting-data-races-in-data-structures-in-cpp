#include <mutex>

class DataWithoutMutex 
{
    private:
        int value;
        std::mutex mtx;

    public:

        void setValue(int newValue) {
            value = newValue; // unprotected access
        }

        int getValue() {
            int val = value; // unprotected access
            return val;
        }
};