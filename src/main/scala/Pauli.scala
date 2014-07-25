import breeze.linalg._
import breeze.numerics._

object Pauli {
  def apply(n: Int): DenseMatrix[Int] = n match {
    case 0 => DenseMatrix((1, 0), (0, 1))
    case 1 => DenseMatrix((0, 1), (1, 0))
    //case 2 => DenseMatrix((0, -1*i), (1*i, 0))
    case 3 => DenseMatrix((1, 0), (0, -1))
  }
}