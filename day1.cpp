#include <bits/stdc++.h>

using namespace std;

int main() {
  // input
  vector<int> a, b;

  ifstream input; input.open("inputs/1", ios::in);
  int nextA, nextB;
  while (input >> nextA >> nextB) {
     a.push_back(nextA); b.push_back(nextB);
  }

  input.close();

  // part 1
  sort(a.begin(), a.end()); sort(b.begin(), b.end());

  long long int sum = 0;
  for (unsigned int i = 0; i < a.size(); i++) {
    sum += abs(a[i] - b[i]);
  }

  cout << sum << endl;

  // part 2
  long long int score = 0;
  for (unsigned int i = 0; i < a.size(); i++) {
    score += a[i] * count(b.begin(), b.end(), a[i]);
  }
  
  cout << score << endl;
}
