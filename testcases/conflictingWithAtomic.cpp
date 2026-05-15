#include <atomic>


class DataAtomic
{
    private:
        std::atomic<int> value;

    public:

        void setValue(int newValue) {
            value = newValue; // atomic assignment
        }

        int getValue() {
            return value; // atomic read
        }
};