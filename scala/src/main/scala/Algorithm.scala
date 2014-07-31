import specificlinalg._
import spire.implicits._
import spire.math._

case class Probability(p: Complex[Double])

object Algorithm {
  def withInstallments(h_i: SpecialMatrix, h_f: SpecialMatrix, t: Double, iter: Int, ninstal: Int): Probability = {
    // Imaginary number
    val i = Complex.i[Double]

    val m: Int = h_i.length
    val psi_0: IndexedSeq[Complex[Double]] = IndexedSeq.fill(m)(1.0 / sqrt(m))

    val step = 1.0 / ninstal
    var a = h_i * t * -1 * i
    val b = (h_f - h_i) * t * -1 * i
    var psi_in = SpecialVector(psi_0)

    println(m)
    println(step)
    println(a)
    println(b)
    println(psi_in)

    //for (k <- 1 to ninstal) {
      psi_in = taylorInstallment(a, b, iter, psi_in, step);
      //a = a + b * step
    //}

    val psi = psi_in

    // Positions where h_f is minimized
    val h_f_min = h_f.diagonal.seq.map(_.real).min
    val psi_ind = for {
      (x, y) <- (h_f.diagonal.seq, psi.seq).zipped
      if (x.real == h_f_min)
    } yield y

    val theNorm = sqrt(psi_ind.map(_ ** 2).toVector.qsum)
    Probability(theNorm ** 2)
  }

  def taylorInstallment(a: SpecialMatrix, b: SpecialMatrix, iter: Int, psi_in: SpecialVector, step: Double): SpecialVector = {
    var psi_n_min_2 = psi_in
    var psi_n_min_1 = a * psi_in
    var psi = psi_n_min_1 * step + psi_n_min_2

    for (n <- 2 to iter) {
      val psi_n = (a * psi_n_min_1 + b * psi_n_min_2) * (1.0 / n)

      psi = psi + psi_n * (step ** n)
      psi_n_min_2 = psi_n_min_1
      psi_n_min_1 = psi_n
    }

    psi
  }
}