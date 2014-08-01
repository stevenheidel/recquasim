#include "main.h"
#include "initial_hamiltonian.h"
#include "random_ising.h"

int main() {
  int n = 20;

  //CompressedMatrix<complex<double> > H_i = initial_hamiltonian(n);
  Matrix H_f = random_ising(n);

  cout << H_f.nonZeros() << endl;

  cout << random_ising(3) << endl;

  return 0;
}