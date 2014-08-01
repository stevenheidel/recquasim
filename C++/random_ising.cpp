#include "random_ising.h"

// Return vector and then vector reversed
void vertcatreverse(Vector* a) {
  int size = a->size();
  a->resize(size * 2);

  for (int i = 0; i < size; i++)
    (*a)[size + i] = (*a)[size - i - 1];

  return;
}

void vertcat(Vector *a) {
  int size = a->size();
  a->resize(size * 2);

  subvector(*a, size, size) = subvector(*a, 0, size);

  return;
}

Vector recurse(int n, int l, int k) {
  if (l == 2 && k == 1) {
    int quarter = pow(2, n - 2);

    Vector result(quarter, 1);
    vertcat(&result);

    subvector(result, quarter, quarter) *= -1;

    return result;
  }
  else if (k == 1) {
    Vector result(recurse(n-1, l-1, k));
    vertcat(&result);

    return result;
  }
  else {
    Vector result(recurse(n-1, l-1, k-1));
    vertcatreverse(&result);

    return result;
  }
}

Vector h_kl(int n, int l, int k) {
  Vector result(recurse(n, l, k));

  vertcatreverse(&result);

  return result;
}

// TODO: Add random
int j_kl() {
  return 1;
}

Vector get_vector(int n, int dim) {
  Vector result(dim, 0);

  for (int i = 2; i <= n; i++) {
    for (int j = 1; j < i; j++) {
      result -= h_kl(n, i, j) * j_kl();
    }
  }

  return result;
}

Matrix random_ising(int n) {
  int dim = pow(2, n);

  Matrix H(dim, dim);
  H.reserve(dim);

  Vector diagonal = get_vector(n, dim);

  for (int i = 0; i < dim; i++) {
    H.append(i, i, diagonal[i]);
    H.finalize(i);
  }

  return H;
}