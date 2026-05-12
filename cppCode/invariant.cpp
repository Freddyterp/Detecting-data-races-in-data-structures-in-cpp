#include <vector>
#include <mutex>

// G1 VIOLATION: invariant not protected

class UnsafeVector {
public:
    int size;
    std::vector<int> data;

    UnsafeVector() : size(0) {}

    
    void push(int v) {
        data.push_back(v);
        ++size;
    }

   
    std::vector<int>& getData() {
        return data;
    }

    
    int& getSizeRef() {
        return size;
    }
};

// SAFE VERSION (no invariant exposure)
class SafeVector {
private:
    std::vector<int> data;
    int size;

public:
    SafeVector() : size(0) {}

    void push(int v) {
        data.push_back(v);
        ++size;
    }

    int getSize() const {
        return size;
    }

    
    std::vector<int> snapshot() const {
        return data;
    }
};