#include <mutex>

class Data 
{
    private:
        int value;
        std::mutex mtx;

    public:

        void setValue(int newValue) {
            mtx.lock();
            value = newValue;
            mtx.unlock();
        }

        int getValue() {
            mtx.lock();
            int val = value;
            mtx.unlock();
            return val;
        }
};
