#include "initial_hamiltonian.h"

void add(Matrix* H, int x, int y, int xOff, int yOff) {
  (*H).insert(x + xOff, y + yOff, -1);

  return;
}

void recurse(Matrix* H, int dim, int xOff, int yOff) {
  if (dim == 2) {
    // Pauli(1) matrix
    add(H, 0, 1, xOff, yOff);
    add(H, 1, 0, xOff, yOff);
  }
  else {
    int half = dim / 2;

    // Upper left
    recurse(H, half, xOff, yOff);

    // Upper right
    for (int i = 0; i < half; i++) {
      add(H, i, i, xOff + half, yOff);
    }

    // Lower left
    for (int i = 0; i < half; i++) {
      add(H, i, i, xOff, yOff + half);
    }

    // Lower right
    recurse(H, half, xOff + half, yOff + half);
  }

  return;
}

Matrix initial_hamiltonian(int n) {
  int dim = pow(2, n);
  int n_non_zero = n * dim;

  Matrix H(dim, dim);

  H.reserve(n_non_zero);

  recurse(&H, dim, 0, 0);

  return H;
}