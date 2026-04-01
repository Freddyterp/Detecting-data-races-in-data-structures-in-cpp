int counter = 0; // plain int, not atomic
int snd = 0;

void increment() {
    counter++;
}

void readCounter() {
    int value = counter;
}