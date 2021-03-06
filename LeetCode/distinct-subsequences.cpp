class Solution {
public:
    int numDistinct(string S, string T) {
        int n = S.length();
        int m = T.length();
        vector<vector<int>> dp(n + 1, vector<int>(m + 1));
        for (int i = 0; i <= n; ++i) {
            dp[i][0] = 1;
        }
        for (int j = 1; j <= m; ++j) {
            dp[0][j] = 0;
        }
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                dp[i][j] = dp[i - 1][j];
                if (S[i - 1] == T[j - 1]) {
                    dp[i][j] += dp[i - 1][j - 1];
                }
            }
        }
        return dp[n][m];
    }
};
