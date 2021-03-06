#include <cstdio>
#include <cstring>
#include <iostream>
#include <algorithm>
using namespace std;
const int MAXN = 65536;
const int MAXM = 100000 + 10;

bool isPrime[MAXM];
long long prime[MAXN], primeNum;

void init()
{
    for (long long i = 3; i < MAXN; i += 2)
    {
        isPrime[i] = true;
    }
    for (long long i = 3; i < MAXN; i += 2)
    {
        if (isPrime[i])
        {
            for (long long j = i + i; j < MAXN; j += i)
            {
                isPrime[j] = false;
            }
        }
    }
    primeNum = 1;
    prime[0] = 2;
    for (long long i = 3; i < MAXN; i += 2)
    {
        if (isPrime[i])
        {
            prime[primeNum++] = i;
        }
    }
}

int main()
{
    long long T, L, U;
    init();
    cin >> T;
    for (int t = 0; t < T; ++t)
    {
        cin >> L >> U;
        for (long long i = 0; i <= U - L; ++i)
        {
            isPrime[i] = true;
        }
        if (L == 1)
        {
            isPrime[0] = false;
        }
        for (long long i = 0; i < primeNum && prime[i] * prime[i] <= U; ++i)
        {
            long long t = L / prime[i];
            for (long long j = prime[i] * (t <= 1 ? 2 : t); j <= U; j += prime[i])
            {
                if (j >= L)
                {
                    isPrime[j - L] = false;
                }
            }
        }
        if (t)
        {
            cout << endl;
        }
        for (long long i = 0; i <= U - L; ++i)
        {
            if (isPrime[i])
            {
                cout << i + L << endl;
            }
        }
    }
    return 0;
}
