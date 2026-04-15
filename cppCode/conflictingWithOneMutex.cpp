#include <mutex>

class Data {
    private:
        int value;
        std::mutex mtx;

    public:

        void setValue(int newValue) {
            value = newValue;
        }

        int getValue() {
            mtx.lock();
            int val = value;
            mtx.unlock();
            return val;
        }
};