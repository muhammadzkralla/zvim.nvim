/**
     /$$$$$$$$
    |_____ $$
         /$$/
        /$$/
       /$$/
      /$$/
     /$$$$$$$$
    |________/
 **/

#include <bits/stdc++.h>

#define ll long long
using namespace std;

void fast() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}

typedef pair<ll, ll> pii;

vector<vector<pair<ll, ll>>> adj;
vector<ll> cost;
vector<ll> parent;

void dijkstra_pq(const ll& src) {

    priority_queue<pii, vector<pii>, greater<>> pq;
    cost[src] = 0;
    pq.emplace(cost[src], src);

    while (!pq.empty()) {
        ll u = pq.top().second;
        pq.pop();

        for (auto& edge : adj[u]) {
            ll v = edge.first;
            ll weight = edge.second;

            if (cost[u] + weight < cost[v]) {
                cost[v] = cost[u] + weight;
                pq.emplace(cost[v], v);
                parent[v] = u;
            }
        }
    }
}

void dijkstra(const ll& src) {

    set<pii> nodes;
    cost[src] = 0;
    nodes.insert({cost[src], src});

    while (!nodes.empty()) {
        auto p = *nodes.begin();

        ll u = p.second;
        nodes.erase(nodes.begin());

        for (auto& edge : adj[u]) {
            ll v = edge.first;
            ll weight = edge.second;

            if (cost[u] + weight < cost[v]) {
                nodes.erase({cost[v], v});
                cost[v] = cost[u] + weight;
                nodes.insert({cost[v], v});
                parent[v] = u;
            }
        }
    }
}

void print_shortest_path(const ll& start, const ll& target) {
    string path;
    ll curr = target;
    while (curr != start) {
        path = to_string(curr) + (path.empty() ? "" : "->") + path;
        curr = parent[curr];
    }
    path = to_string(start) + (path.empty() ? "" : "->") + path;
    cout << "Shortest path from " << start << " to " << target << ":\n";
    cout << path << endl;
    cout << "The cost: " << cost[target] << endl;
    cout << "********************" << endl;
}

void solve() {
    adj.resize(6);
    cost.resize(6);
    parent.resize(6);
    adj[0].emplace_back(1, 5);
    adj[0].emplace_back(2, 0);
    adj[1].emplace_back(3, 15);
    adj[1].emplace_back(4, 20);
    adj[2].emplace_back(3, 30);
    adj[2].emplace_back(4, 35);
    adj[3].emplace_back(5, 20);
    adj[4].emplace_back(5, 10);

    // set all costs to infinity as a start
    for (int i = 1; i <= 5; ++i) {
        cost[i] = LLONG_MAX;
    }

    dijkstra_pq(0);

    for (int i = 1; i <= 5; ++i) print_shortest_path(0, i);

}

int main() {
    fast();
    int t = 1;
//    cin >> t;
    while (t--) {
        solve();
    }
}
