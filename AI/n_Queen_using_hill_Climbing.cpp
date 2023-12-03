#include<bits/stdc++.h>

using namespace std;

int calculateAttacks(const vector<int> &board) {
    int attacks = 0;
    int n = board.size();

    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < n; ++j) {
            if (board[i] == board[j] || abs(board[i] - board[j]) == j - i) {
                attacks++;
            }
        }
    }

    return attacks;
}

vector<int> generateRandomBoard(int n) {
    vector<int> board(n);
    for (int i = 0; i < n; ++i) {
        board[i] = rand() % n;
    }
    return board;
}
vector<int> ans;
int steepestHillClimbing(int n) {
    vector<int> currentBoard = generateRandomBoard(n);
    int currentAttacks = calculateAttacks(currentBoard);
    for(int i = 0;i<n;i++){
        int queen = currentBoard[i];
        for(int j = 0;j<n;j++){
            if(j == queen) cout<<"Q ";
            else cout<<". ";
        }
        cout<<endl;
    }
    cout<<currentAttacks<<endl;

    while (currentAttacks > 0) {
        int bestAttacks = currentAttacks;
        vector<int> bestNextBoard = currentBoard;

        for (int col = 0; col < n; ++col) {
            for (int newRow = 0; newRow < n; ++newRow) {
                if (currentBoard[col] != newRow) {
                    vector<int> nextBoard = currentBoard;
                    nextBoard[col] = newRow;
                    int newAttacks = calculateAttacks(nextBoard);

                    if (newAttacks < bestAttacks) {
                        bestAttacks = newAttacks;
                        bestNextBoard = nextBoard;
                    }
                }
            }
        }

        if (bestAttacks >= currentAttacks) {
            return 0;
        } else {
            currentBoard = bestNextBoard;
            currentAttacks = bestAttacks;
        }
    }

    ans = currentBoard;
    return 1;
}

int main() {
    int n = 4; // Size of the chessboard and number of queens
    cin>>n;
    int flag = steepestHillClimbing(n);
    if(flag == 1){

    cout << "Solution found:" << endl;
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (ans[j] == i) {
                cout << "Q ";
            } else {
                cout << ". ";
            }
        }
        cout << endl;
    }
    }
    else{
        cout<<"NO SOLUTION FOUND"<<endl;
    }
    return 0;
}