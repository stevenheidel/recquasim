import specificlinalg._
import scala.annotation.tailrec

object ZeroHamiltonian {
  def construct(n: Int): SpecialMatrix = {
    SpecialMatrix.noDiagonal(Size(n), -1, n)
    /*FactorMatrix.initializeWithFunction(Size(n), -1) { (size: Size, coordinate: Coordinate) =>
      recurse(size.dim, coordinate.x, coordinate.y)
    }*/
  }

  // Is there an element in the initial Hamiltonian that is n wide at (i, j)
  @tailrec
  def recurse(n: Int, i: Int, j: Int): Boolean = {
    if (n == 2) {
      // Pauli(1) Matrix
      !(i == j)
    }
    else {
      val half = n / 2

      val upper = i >= 0 && i < half
      val left  = j >= 0 && j < half

      if (upper && left) {
        recurse(half, i, j)
      }
      else if (!upper && !left) {
        recurse(half, i - half, j - half)
      }
      else {
        // On the diagonal
        (i - half == j || i == j - half)
      }
    }
  }
}