import breeze.linalg._
import breeze.numerics._
import scala.annotation.tailrec

case class ZeroHamiltonian(dims: Int) {
  val size: Int = math.pow(2, dims).toInt

  lazy val matrix = DenseMatrix.tabulate(size, size){case (i, j) => apply(i, j)}

  lazy val sparseMatrix: CSCMatrix[Int] = {
    val builder = new CSCMatrix.Builder[Int](rows=size, cols=size)

    for (i <- 0 until size; j <- 0 until size) {
      if (recurse(size, i, j)) builder.add(i, j, -1)
    }

    builder.result()
  }

  override def toString = matrix.toString

  def apply(i: Int, j: Int): Int = {
    if (i >= size || j >= size) ???
    else if (recurse(size, i, j)) -1 else 0
  }

  @tailrec
  final def recurse(n: Int, i: Int, j: Int): Boolean = {
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

  lazy val onesCount: Int = -sum(matrix)
}

/*
import breeze.linalg._
import breeze.numerics._

object ZeroHamiltonian {
  def apply(n: Int): CSCMatrix[Int] = {
    -recurse(n)
  }

  def recurse(n: Int): CSCMatrix[Int] = {
    if (n == 1) Pauli(1)
    else {
      val upperLeft = recurse(n-1)
      val upperRight = CSCMatrix.eye[Int](math.pow(2, n-1).toInt)
      val lowerLeft = upperRight
      val lowerRight = upperLeft

      CSCMatrix.vertcat(
        CSCMatrix.horzcat(upperLeft, upperRight),
        CSCMatrix.horzcat(lowerLeft, lowerRight)
      )
    }
  }
}
*/