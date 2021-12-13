#include <bits/stdc++.h>
using namespace std;
#define ll long long int
#define ld long long double

#define endl '\n'
#define fo(i, m, n) for (int i = m; i < n; i++)
#define foe(i, m, n) for (int i = m; i <= n; i++)
template <typename... T>
void read(T &...args)
{
    ((cin >> args), ...);
}
template <typename... T>
void print(T... args) { ((cout << args << " "), ...); }
template <typename... T>
void printl(T... args) { ((cout << args << endl), ...); }
#define mod 1000000007
#define mod2 998244353
#define F first
#define S second
#define pb push_back
#define MP make_pair
#define vt vector
#define sz(x) (int)x.size()
#define all(v) v.begin(), v.end()
#define deb(x) cerr << #x << '=' << (x) << endl;
#define debp(x) cerr << #x << "= {" << (x.first) << ", " << (x.second) << "}" << endl;
#define deb2(x, y) cerr << "{" << #x << ", " << #y << "} = {" << (x) << ", " << (y) << "}" << endl;
#define debv(v)               \
    {                         \
        cerr << #v << " : ";  \
        for (auto x : v)      \
            cerr << x << ' '; \
        cerr << endl;         \
    }
#define maxheap priority_queue<ll>
#define minheap priority_queue<ll, vector<ll>, greater<ll>>
#define SpeedForce                \
    ios_base::sync_with_stdio(0); \
    cin.tie(0);                   \
    cout.tie(0);

const ll INF = 1e18L;
const double PI = 4 * atan(1);
const double eps = 1e-8;
int dx[] = {-1, 0, 1, 0, -1, 1, 1, -1};
int dy[] = {0, 1, 0, -1, 1, 1, -1, -1};

int solve(int n, string s)
{
    int dp[n][26];
    memset(dp, 0, sizeof(dp));
    dp[0][s[0] - 'a'] = 1;

    int last = 1;
    for (int i = 1; i < n; i++)
    {
        int sum = 0;
        if (s[i] == '?')
        {
            for (int j = 0; j < 26; j++)
            {
                dp[i][j] = ((last - dp[i - 1][j]) % mod + 2*mod) % mod;
                sum = (sum + dp[i][j]) % mod;
            }
        }
        else
        {
            dp[i][s[i] - 'a'] = ((last - dp[i - 1][s[i] - 'a']) % mod + 2*mod) % mod;
            sum = (sum + dp[i][s[i] - 'a']) % mod;
        }
        last = sum;
    }
    return last;
}

void solve()
{
    string s;
    cin >> s;
    int n = s.length();
    int ans = 0;
    if (s[0] == s[n - 1] && s[n - 1] != '?')
    {
        ans = solve(n, s);
    }
    else if (s[0] == s[n - 1] && s[n - 1] == '?')
    {
        for (int i = 0; i < 26; i++)
        {
            s[0] = char('a' + i);
            s[n - 1] = char('a' + i);
            ans += solve(n, s) % mod;
        }
    }
    else if (s[0] == '?' && s[n - 1] != s[0])
    {
        s[0] = s[n - 1];
        ans = solve(n, s);
    }
    else if (s[0] != '?' && s[n - 1] == '?')
    {
        s[n - 1] = s[0];
        ans = solve(n, s);
    }
    else{
        // Not possible ans = 0
    }
    cout << ans << endl;
}

int32_t main()
{
    SpeedForce int t;
    t = 1;
    cin >> t;
    int cnt = 1;
    while (t--)
    {
        // cout << "Case #" << cnt << ": ";
        // cout << fixed << setprecision(6);
        solve();
        cnt++;
    }
    // cerr << "Time : " << 1000*((double)clock())/ (double)CLOCKS_PER_SEC << "ms" << endl;
}
