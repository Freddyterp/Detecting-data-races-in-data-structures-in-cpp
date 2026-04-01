#include <mutex>
#include <queue>
#include <thread>
#include <iostream>

class MyQueue {
private:
    std::queue<int> q;
    std::mutex mtx;

public:
    void pushNormal(int value) {
        mtx.lock();
        q.push(value);
        mtx.unlock();

        
        mtx.lock();
        std::cout << "Queue size: " << q.size() << "\n";
        mtx.unlock();
    }

    
    void pushRAII(int value) {
        {
            std::lock_guard<std::mutex> lg(mtx);
            q.push(value);
        }

        
        {
            std::lock_guard<std::mutex> lg(mtx);
            std::cout << "Queue size: " << q.size() << "\n";
        }
    }

    
    void popMixed() {
        {
            std::lock_guard<std::mutex> lg(mtx);
            if (!q.empty()) q.pop();
        }

        mtx.lock(); 
        std::cout << "Queue size after pop: " << q.size() << "\n";
        mtx.unlock();
    }
};