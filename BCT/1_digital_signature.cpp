#include <bits/stdc++.h>
using namespace std;

int n;
int public_key;
int private_key;

const int maxN = 1000;
bool sieve[maxN+1];
set<int> primes;

int gcd(int a, int b) {if (b > a) {return gcd(b, a);} if (b == 0) {return a;} return gcd(b, a % b);}
// creating prime numbers from 1 to 1000 
void createSieve(){
    for(int i=2;i<=maxN;i++){
        sieve[i]=true;
    }

    for(int i=2;i*i<=maxN;i++){
        if(sieve[i]==true){
            for(int j=i*i;j<=maxN;j+=i){
                sieve[j]=false;
            }
        }
    }
    for(int i = 2; i<=maxN;i++){
        if(sieve[i] == true) primes.insert(i);
    }
}
// picking random prime number
int randomPrime(){
    int ind = rand() % primes.size();
    auto it = primes.begin();
    while(ind--) it++;
    int ans = *it;
    primes.erase(it);
    return ans;
}
// assigning public key and private key 
void assignKey(){
    int p = randomPrime();
    int q = randomPrime();
    n = p*q;
    int phi = (p-1) * (q-1);
    int e = 2;
    while(true){
        if(gcd(e,phi) == 1) break;
        e++;
    }
    public_key = e;
    int d = 2;
    while(true){
        if((d*e) % phi== 1)
            break;
        d++;
    }
    private_key = d;
}
// encrypting a single character 
long long int encrypt(double message){
    int e = public_key;
    long long int encrpyted_text = 1;
    while (e--) {
        encrpyted_text *= message;
        encrpyted_text %= n;
    }
    return encrpyted_text;
}
// decrypting a single character 
long long int decrypt(int encrpyted_text)
{
    int d = private_key;
    long long int decrypted = 1;
    while (d--) {
        decrypted *= encrpyted_text;
        decrypted %= n;
    }
    return decrypted;
}
// encoding whole string 
vector<int> encoder(string message){
    vector<int> ans;
    for(auto it:message){
        ans.push_back(encrypt((int)it));
    }
    return ans;
}
// decoding whole string
string decoder(vector<int> encoded){
    string s;
    for(auto it:encoded){
        s += decrypt(it);
    }
    return s;
}

int32_t main()
{
    createSieve();
    assignKey();

    // string message;
    // cin>>message;
    string message = "Test Message";
    
    vector<int> coded = encoder(message);
    cout<<"Initial Message : "<<message<<endl;
    cout<<"Encoded Message : ";
    for(auto it:coded) cout<<it;
    cout<<endl;
    coded[coded.size() - 2] = 9;
    cout<<"Decoded Message : "<<decoder(coded);
    return 0;
}
