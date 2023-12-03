#include <bits/stdc++.h>
using namespace std;
// ----------------------------------------------------------------------------------------------------------------------
string destination;
int N = 3;
map<string,int> mp;
bool flag = false;

void bfs(string source){
    queue<pair<string,int>> q;
    vector<string> vis;
    int ind;
    for(int i = 0;i<source.size();i++){ if(source[i] == '0'){ind = i ;break;} }
    q.push({source,ind});
    vis.push_back(source);
    int stop = 0;
    while(!q.empty()){
        auto it = q.front();
        q.pop();
        string s = it.first;
        ind = it.second;
        stop++;
        if(stop>10000) break;
        if(s == destination){
            flag = true;
            return;
        }
        if(ind + N < s.size() && ind + N >= 0){
            swap(s[ind],s[ind+N]);
            if(find(vis.begin(),vis.end(),s) == vis.end()){
                vis.push_back(s);
                q.push({s,ind+N});
                mp[s] = 2;
                s = it.first;
            }
        }
        if(ind - N < s.size() && ind - N >= 0){
            swap(s[ind],s[ind-N]);
            if(find(vis.begin(),vis.end(),s) == vis.end()){
                vis.push_back(s);
                q.push({s,ind-N});
                mp[s] = 1;
                s = it.first;
            }
        }
        if(ind + 1 < s.size() && ind + 1 >= 0){
            swap(s[ind],s[ind+1]);
            if(find(vis.begin(),vis.end(),s) == vis.end()){
                vis.push_back(s);
                q.push({s,ind+1});
                mp[s] = 4;
                s = it.first;
            }
        }
        if(ind - 1 < s.size() && ind - 1 >= 0){
            swap(s[ind],s[ind-1]);
            if(find(vis.begin(),vis.end(),s) == vis.end()){
                vis.push_back(s);
                q.push({s,ind-1});
                mp[s] = 3;
                s = it.first;
            }
        }
    }
    flag = false;
}

// 1 - up
// 2 - down
// 3 - left
// 4 - right
vector<string> steps(string source){
    vector<string> ans;
    string s = "123456780";
    int ind = s.size()-1;  
    ans.push_back(s);
    while(s != source){
        if(mp[s] == 1){
            swap(s[ind] , s[ind+N]);
            ans.push_back(s);
            ind = ind+N;
            continue;
        }
        if(mp[s] == 2){
            swap(s[ind] , s[ind-N]);
            ind = ind-N;
            ans.push_back(s);
            continue;
        }
        if(mp[s] == 3){
            swap(s[ind],s[ind+1]);
            ind = ind+1;
            ans.push_back(s);
            continue;
        }
        if(mp[s] == 4){
            swap(s[ind],s[ind-1]);
            ind = ind-1;
            ans.push_back(s);
            continue;
        }
    }
    return ans;
}
void printMaze(string s){
    int cnt = 1;
    cout<<s[0]<<" "<<s[1]<<" "<<s[2]<<endl;
    cout<<s[3]<<" "<<s[4]<<" "<<s[5]<<endl;
    cout<<s[6]<<" "<<s[7]<<" "<<s[8]<<endl;
}
void solve(){
    string source;
    vector<vector<char>> maze(3,vector<char>(3,0));
    vector<vector<char>> des(3,vector<char>(3,0));
    for(int i= 0 ;i<3;i++){
        for(int j = 0;j<3;j++){
            cin>>maze[i][j];
            source.push_back(maze[i][j]);
        }
    }
    for(int i= 0 ;i<3;i++){
        for(int j = 0;j<3;j++){
            cin>>des[i][j];
            destination.push_back(des[i][j]);
        }
    }

    bfs(source);
    if(flag == 1){
        cout<<"Yes"<<endl;
        vector<string> ans = steps(source);
        for(int i = ans.size()-1;i>=0;i--){
            printMaze(ans[i]);
            cout<<endl;
        }
    }
    else{
        cout<<"NO"<<endl;
    }
}
int32_t main()
{
    // #ifndef ONLINE_JUDGE
    //     freopen("input.txt", "r", stdin);
    //     freopen("output.txt", "w", stdout);
    //     freopen("Error.txt", "w", stderr);
    // #endif
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);

    //---------------------------------------------------------------
    solve();
    
    return 0;
}

/*


1 2 3
0 4 5
7 8 6

1 2 3
4 5 6
7 8 0



*/