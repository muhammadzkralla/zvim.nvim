return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    dependencies = { "rafamadriz/friendly-snippets" },

    config = function()
        local ls = require("luasnip")
        ls.filetype_extend("javascript", { "jsdoc" })
        ls.filetype_extend("java", { "javadoc" })
        local s = ls.snippet
        local i = ls.insert_node
        local t = ls.text_node

        -- these are my custom snippets for cpp problem solving
        ls.add_snippets("cpp", {
            -- GCD Function
            s("gcd", {
                t("long long gcd(long long a, long long b) { // NOLINT(misc-no-recursion)"), t({ "", "\t" }),
                t("if (b == 0) return a;"), t({ "", "\t" }),
                t("return gcd(b, a % b);"), t({ "", "}" }),
            }),

            -- LCM Function
            s("lcm", {
                t("long long lcm(long long a, long long b) {"), t({ "", "\t" }),
                t("return (a * b) / gcd(a, b);"), t({ "", "}" }),
            }),

            -- isPrime Function
            s("isPrime", {
                t("bool isPrime(long long number) {"), t({ "", "\t" }),
                t("if (number <= 1) return false;"), t({ "", "\t" }),
                t("for (int i = 2; i * i <= number; ++i) {"), t({ "", "\t\t" }),
                t("if (number % i == 0) return false;"), t({ "", "\t" }),
                t("}"), t({ "", "\t" }),
                t("return true;"), t({ "", "}" }),
            }),

            -- for loop
            s("fori", {
                t("for (int i = "), i(1), t("; i < "), i(2), t("; ++i) {"),
                t({ "", "\t" }), i(0),
                t({ "", "}" })
            }),

            -- for each
            s("forin", {
                t("for ("), i(1), t(" : "), i(2), t(" ){"),
                t({ "", "\t" }), i(0),
                t({ "", "}" })
            }),

            -- convertToBinaryString Function
            s("convertToBinaryString", {
                t("string convertToBinaryString(long long k) {"), t({ "", "\t" }),
                t("string binaryString;"), t({ "", "" }),
                t("\tif (k == 0) {"), t({ "", "\t\t" }),
                t('binaryString = "0";'), t({ "", "\t" }),
                t("} else {"), t({ "", "\t\t" }),
                t("while (k > 0) {"), t({ "", "\t\t\t" }),
                t("long long bit = k & 1;"), t({ "", "\t\t\t" }),
                t('binaryString.insert(0, std::to_string(bit));'), t({ "", "\t\t\t" }),
                t("k >>= 1;"), t({ "", "\t\t" }),
                t("}"), t({ "", "\t" }),
                t("}"), t({ "", "\t" }),
                t("return binaryString;"), t({ "", "}" })
            }),

            -- nCr Function
            s("nCr", {
                t("long long nCr(long long n, long long r) {"), t({ "", "\t" }),
                t("long long ans = 1;"), t({ "", "\t" }),
                t("long long div = 1;"), t({ "", "\t" }),
                t("for (long long i = r + 1; i <= n; i++) {"), t({ "", "\t\t" }),
                t("ans = ans * i;"), t({ "", "\t\t" }),
                t("ans /= div;"), t({ "", "\t\t" }),
                t("div++;"), t({ "", "\t" }),
                t("}"), t({ "", "\t" }),
                t("return ans;"), t({ "", "}" })
            }),

            -- nPr Function
            s("nPr", {
                t("long long nPr(long long n, long long r) {"), t({ "", "\t" }),
                t("long long ans = 1;"), t({ "", "\t" }),
                t("for (long long i = (n - r) + 1; i <= n; i++) {"), t({ "", "\t\t" }),
                t("ans *= i;"), t({ "", "\t\t" }),
                t("ans %= mod;"), t({ "", "\t" }),
                t("}"), t({ "", "\t" }),
                t("return ans;"), t({ "", "}" })
            }),

            -- fact Function
            s("fact", {
                t("long long fact(long long n) { // NOLINT(misc-no-recursion)"), t({ "", "\t" }),
                t("if (n <= 1) return 1;"), t({ "", "\t" }),
                t("return (n % mod * fact(n - 1) % mod) % mod;"), t({ "", "}" })
            }),

            -- convertToBaseK Function
            s("convertToBaseK", {
                t("string convertToBaseK(long long n, int k) {"), t({ "", "\t" }),
                t("string result;"), t({ "", "\t" }),
                t("while (n > 0) {"), t({ "", "\t\t" }),
                t("long long remainder = n % k;"), t({ "", "\t\t" }),
                t("result.insert(0, to_string(remainder));"), t({ "", "\t\t" }),
                t("n /= k;"), t({ "", "\t" }),
                t("}"), t({ "", "\t" }),
                t("return result;"), t({ "", "}" })
            }),

            -- sieve function
            s("sieve", {
                t({
                    "void sieve(ll n) {",
                    "    low.assign(n + 1, 0);",
                    "",
                    "    for (int i = 2; i <= n; ++i) {",
                    "        if (!low[i]) {",
                    "            low[i] = i;",
                    "            pr.push_back(i);",
                    "        }",
                    "",
                    "        for (int &j: pr) {",
                    "            if (j > low[i] || i * j > n) break;",
                    "            low[j * i] = j;",
                    "        }",
                    "    }",
                    "}",
                }),
            }),
        })

        ls.add_snippets("c", {
            s("get_current_time_ms", {
                t({
                    "long long get_current_time_ms() {",
                    "  struct timeval tv;",
                    "  gettimeofday(&tv, NULL);",
                    "  return (tv.tv_sec * 1000) + (tv.tv_usec / 1000);",
                    "}",
                }),
            }),
        })
    end,
}
