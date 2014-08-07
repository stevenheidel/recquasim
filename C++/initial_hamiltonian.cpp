#include "initial_hamiltonian.h"

void add(Matrix* H, int x, int y) {
  (*H).append(x , y, -1);

  return;
}

void recurse(Matrix* H, int global_row, int row, int col_offset, int n) {
    bool up = row % 2 == 0;
    int dim = 1 << n;
    
    if (n == 1) {
        if (up) add(H, global_row, col_offset + 1);
        else add(H, global_row, col_offset);
    }
    else {
        int half = dim / 2;
        int ident_col = row % half;
        // Top half
        if (row < half) {
            recurse(H, global_row, row, col_offset, n-1);
            add(H, global_row, col_offset + ident_col + half);
        }
        // Bottom half
        else {
            add(H, global_row, col_offset + ident_col);
            recurse(H, global_row, row % half, col_offset + half, n-1);
        }
    }
    
    return;
}

Matrix initial_hamiltonian(int n) {
  int dim = pow(2, n);
  int n_non_zero = n * dim;

  Matrix H(dim, dim);

  H.reserve(n_non_zero);

  for (int i = 0; i < dim; i++) {
    //H.reserve(n, i);
    recurse(&H, i, i, 0, n);
    H.finalize(i);
  }

  return H;
}