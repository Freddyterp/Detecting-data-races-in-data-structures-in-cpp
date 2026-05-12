#include <mutex>

class DataLock
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
            std::lock_guard<std::mutex> guard(mtx);
            int val = value;
            return val;
        }
};