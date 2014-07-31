import breeze.linalg._
import breeze.numerics._
import breeze.math._

/*
object PSuccessDWaveTest {
  def apply(h_i_int: CSCMatrix[Int], h_f_int: DenseVector[Int], t: Double, iter: Int): Double = {
    val m = h_f_int.length

    val psi_0 = Vector.fill(m)(Complex(1.0 / math.sqrt(m), 0))

    val h_i: CSCMatrix[Complex] = h_i_int.mapValues(Complex(_, 0))
    val h_f: CSCMatrix[Complex] = RandomIsing.toSparseMatrix(h_f_int).mapValues(Complex(_, 0))

    val a: CSCMatrix[Complex] = h_i.mapValues(_ * Complex(0, -t))
    val b: CSCMatrix[Complex] = (h_f - h_i).mapValues(_ * Complex(0, -t))

    var psi_n_min_2 = psi_0
    var psi_n_min_1 = a * psi_0
    val psi = psi_n_min_1 + psi_n_min_2

    for (n <- 2 to iter) {
      val psi_n = (a * psi_n_min_1 + b * psi_n_min_2).mapValues(_ * Complex(1.0/n, 0))
      psi += psi_n

      psi_n_min_2 = psi_n_min_1
      psi_n_min_1 = psi_n
    }

    val minf = min(h_f_int)
    val ind = for {
      i <- 0 until m
      if h_f_int(i) == minf
    } yield {
      psi(i)
    }

    math.pow(norm(DenseVector(ind.toArray)), 2)
  }
}
*/

/*
% initialize recurrence

psi_n_min_2 =  psi_0;
psi_n_min_1 = A*psi_0;
psi = psi_n_min_1 + psi_n_min_2;
%psi_n = zeros(size(psi_n_min_1));

% recurrence

for n = 2:iter
    psi_n = (1/n)*(A*psi_n_min_1 + B*psi_n_min_2);
    psi = psi + psi_n;
    %norm(psi) % norm converges to 1 for iter large, which is amazing 
    psi_n_min_2 = psi_n_min_1;
    psi_n_min_1 = psi_n;
end
*/