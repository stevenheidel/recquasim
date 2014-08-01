#include "initial_hamiltonian.h"

int _initial_hamiltonian_global_count;

void add(umat* locations, int x, int y, int xOff, int yOff) {
  (*locations)(0, _initial_hamiltonian_global_count) = x + xOff;
  (*locations)(1, _initial_hamiltonian_global_count) = y + yOff;

  _initial_hamiltonian_global_count++;

  return;
}

void recurse(umat* locations, int dim, int xOff, int yOff) {
  if (dim == 2) {
    // Pauli(1) matrix
    add(locations, 0, 1, xOff, yOff);
    add(locations, 1, 0, xOff, yOff);
  }
  else {
    int half = dim / 2;

    // Upper left
    recurse(locations, half, xOff, yOff);

    // Upper right
    for (int i = 0; i < half; i++) {
      add(locations, i, i, xOff + half, yOff);
    }

    // Lower left
    for (int i = 0; i < half; i++) {
      add(locations, i, i, xOff, yOff + half);
    }

    // Lower right
    recurse(locations, half, xOff + half, yOff + half);
  }

  return;
}

sp_cx_mat initial_hamiltonian(int n) {
  int dim = pow(2, n);
  int n_non_zero = n * dim;

  umat locations(2, n_non_zero);
  cx_colvec values = ones<cx_colvec>(n_non_zero) * -1;

  _initial_hamiltonian_global_count = 0;
  recurse(&locations, dim, 0, 0);

  return sp_cx_mat(locations, values, dim, dim);
}