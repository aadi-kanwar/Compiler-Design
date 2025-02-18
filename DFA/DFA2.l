%{
#include <stdio.h>
#include <stdlib.h>

int move(int state, char c);
int is_accepting_state(int state);

%}

token DIGIT
%%

[0-9] { return DIGIT; }

%%

int move(int state, char c) {
    switch (state) {
        case 0:
            if (c == '0') return 0;
            if (c == '1') return 1;
            break;
        case 1:
            if (c == '0') return 1;
            if (c == '1') return 0;
            break;
        default:
            return -1;  // Invalid state transition
    }
    return -1;  // Invalid character transition
}

int is_accepting_state(int state) {
    // Define the accepting state(s)
    if (state == 0) return 1;  // Let's assume state 0 is accepting
    return 0;  // Not accepting
}

int main() {
    int state = 0;  // Start state
    char c;
    
    while ((c = getchar()) != EOF) {
        state = move(state, c);
        if (state == -1) {
            printf("no\n");
            return 0;
        }
    }
    
    if (is_accepting_state(state)) {
        printf("yes\n");
    } else {
        printf("no\n");
    }
    return 0;
}

