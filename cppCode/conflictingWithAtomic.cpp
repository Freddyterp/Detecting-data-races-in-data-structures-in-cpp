#include <atomic>


class DataAtomic
{
    private:
        std::atomic<int> value;

    public:

        void setValue(int newValue) {
            value = newValue;
        }

        int getValue() {
            return value;
        }
};