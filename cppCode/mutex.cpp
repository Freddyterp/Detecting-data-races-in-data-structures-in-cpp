#include <mutex>
#include <queue>
#include <thread>
#include <iostream>

class MyQueue {
private:
    std::queue<int> q;
    std::mutex mtx;

public:
    // Push with normal lock/unlock
    void pushNormal(int value) {
        mtx.lock();          // normal lock
        q.push(value);
        mtx.unlock();        // normal unlock

        // immediately lock again (unlock → subsequent lock)
        mtx.lock();
        std::cout << "Queue size: " << q.size() << "\n";
        mtx.unlock();
    }

    // Push with lock_guard RAII
    void pushRAII(int value) {
        {
            std::lock_guard<std::mutex> lg(mtx); // constructor locks
            q.push(value);
        } // destructor unlocks automatically

        // RAII lock again
        {
            std::lock_guard<std::mutex> lg(mtx);
            std::cout << "Queue size: " << q.size() << "\n";
        }
    }

    // Pop with RAII and normal lock mixed
    void popMixed() {
        {
            std::lock_guard<std::mutex> lg(mtx);
            if (!q.empty()) q.pop();
        } // unlock

        mtx.lock();  // normal lock after RAII unlock
        std::cout << "Queue size after pop: " << q.size() << "\n";
        mtx.unlock();
    }
};