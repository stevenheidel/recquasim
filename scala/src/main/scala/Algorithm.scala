import specificlinalg._
import spire.implicits._
import spire.math._

case class Probability(p: Double)

object Algorithm {
  def withInstallments(h_i: SpecialMatrix, h_f: SpecialMatrix, t: Double, iter: Int, ninstal: Int): Probability = {
    // Imaginary number
    val i = Complex.i[Double]

    val m: Int = h_i.length
    val psi_0: IndexedSeq[Complex[Double]] = IndexedSeq.fill(m)(1.0 / sqrt(m))

    val step = 1.0 / ninstal
    val A = h_i * t * -1 * i
    val B = (h_f - h_i) * t * -1 * i

    ???
  }
}