// test_lockguard.cpp
#include <mutex>
#include <thread>

class TestClass {
private:
    std::mutex m_mutex;
    int data = 0;

public:
    void explicit_locking() {
        m_mutex.lock();    // Direct lock call
        data++;
        m_mutex.unlock();  // Direct unlock call
    }
    
    void raii_locking() {
        std::lock_guard<std::mutex> guard(m_mutex);  // Constructor call
        data++;
        // Destructor called automatically at end of scope
    }
    
    void scoped_example() {
        {
            std::lock_guard<std::mutex> guard(m_mutex);
            data++;
        } // Destructor called here
        data--;
    }
};