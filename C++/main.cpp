#include "main.h"
#include "initial_hamiltonian.h"
#include "random_ising.h"

Complex I(0, 1);

Vector taylor_installment(Matrix a, Matrix b, int iter, Vector psi_in, double step) {
  Vector psi_n_min_2 = psi_in;
  Vector psi_n_min_1 = a * psi_in;
  Vector psi = psi_n_min_1 * step + psi_n_min_2;

  for (int n = 2; n <= iter; n++) {
    Vector psi_n = (1.0 / n) * (a * psi_n_min_1 + b * psi_n_min_2);

    psi = psi + pow(step, n) * psi_n;
    psi_n_min_2 = psi_n_min_1;
    psi_n_min_1 = psi_n;
  }

  return psi;
}


double with_installments(Matrix H_i, Matrix H_f, double t, int iter, int ninstal) {
  int m = H_i.rows();
  Vector psi(m, 1.0 / sqrt(m));

  double step = 1.0 / ninstal;
  Matrix a = H_i * t * -1 * I;
  Matrix b = (H_f - H_i) * t * -1 * I;

  for (int k = 1; k <= ninstal; k++) {
    psi = taylor_installment(a, b, iter, psi, step);
    a += b * step;
  }

  Complex c;
  double d;

  c = H_f(0, 0); d = c.real();
  double minimum = d;
  for (int i = 1; i < m; i++) {
    c = H_f(i, i); d = c.real();
    
    if (d < minimum)
      minimum = d;
  }

  double sum = 0;
  for (int i = 0; i < m; i++) {
    c = H_f(i, i); d = c.real();

    if (d == minimum) {
      sum += norm(psi[i]);
    }
  }

  return pow(sqrt(sum), 2);
}

void print_time(clock_t start) {
  cout << "Elapsed time is " << (clock() - start) / (double)(CLOCKS_PER_SEC) << " seconds." << endl;
}

int main(int argc, char **argv) {
  srand(time(0));

  int n = atoi(argv[1]);

  double t = 3.0;
  int iter = 1000;
  int ninstal = 3;

  clock_t start;

  start = clock();
  Matrix H_i(initial_hamiltonian(n));
  print_time(start);

  start = clock();
  Matrix H_f(random_ising(n));
  print_time(start);

  start = clock();
  double result = with_installments(H_i, H_f, t, iter, ninstal);
  print_time(start);

  cout << result << endl;

  return 0;
}