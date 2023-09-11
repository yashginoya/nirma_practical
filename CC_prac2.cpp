#include <bits/stdc++.h>
using namespace std;
string input;
size_t pos = 0;

bool parseS();
bool parseA();

bool parseS() {
    if (input[pos] == 'c') {
        pos++;
        if (parseA()) {
            if (input[pos] == 'd') {
                pos++;
                return true;
            }
        }
    }
    return false;
}

bool parseA() {
    if (input[pos] == 'a' || input[pos] == 'c') {
        pos++;
        return true;
    }
    return false;
}

int main() {
    cout << "Enter a string: ";
    cin >> input;

    if (parseS() && pos == input.length()) {
        cout << "String Accept" << endl;
    } else {
        cout << "String Not Accept" << endl;
    }

    return 0;
}
/*s->cAd
A->a/c
cad accept
cdd not accept
*/