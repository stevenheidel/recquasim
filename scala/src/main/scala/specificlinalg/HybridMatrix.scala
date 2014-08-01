package specificlinalg

import spire.implicits._
import spire.math._

case class Size(n: Int) {
  lazy val dim: Int = 2 ** n
}

case class Coordinate(x: Int, y: Int)

/*
Hybrid Matrix Requirements:
- All elements off of the diagonal are the same element or zero
- You need only to store the positions of the elements off the middle
- Matrix needs to be symmetrical, row/column ordering is the same
- Only ever multiplied with a vector
*/

case class HybridMatrix(
  size: Size, // Size of the matrix
  diagonal: Vector[Complex[Double]],
  factor: Complex[Double],
  positions: IndexedSeq[Seq[Int]] // The positions of the factor in each row
) {
  val length = size.dim

  def *(b: Complex[Double]) = {
    copy(
      diagonal = b *: diagonal,
      factor = b * factor
    )
  }

  def *(b: Vector[Complex[Double]]): Vector[Complex[Double]] = {
    if (length != b.length)
      throw new RuntimeException("Special matrix and special vector lengths must match")
    
    // Multiply the factors with the respective positions in the multiplying vector
    val withFactors = positions.map { x =>
      x.map(y => b(y)).qsum * factor
    }.toVector

    // Then add on the diagonal
    if (diagonal.isEmpty) withFactors
    else withFactors + (b, diagonal).zipped.map(_ * _)
  }

  // TODO: Rewrite to include positions
  def +(b: HybridMatrix) = {
    // This is unnecessary now
    if (factor != 0 && b.factor != 0) 
      throw new RuntimeException("Both special matrices have elements off the diagonal!")

    val newDiagonal = {
      if      (diagonal.isEmpty)   b.diagonal
      else if (b.diagonal.isEmpty) diagonal
      else                         diagonal + b.diagonal
    }

    val newPositions = {
      if (positions.isEmpty) b.positions
      else                   positions
    }

    copy(
      diagonal = newDiagonal, 
      factor = factor + b.factor, 
      positions = newPositions
    )
  }

  def -(b: HybridMatrix) = {
    this.+(b * -1)
  }
}

object HybridMatrix {
  def withDiagonal(size: Size, diagonal: Seq[Complex[Double]]) = {
    HybridMatrix(size, diagonal.toVector, 0, Vector.empty)
  }

  def initializeWithFunction(size: Size, factor: Complex[Double])(f: (Size, Coordinate) => Boolean) = {
    val positions = IndexedSeq.tabulate(size.dim) { x =>
      for (y <- (0 until size.dim); if f(size, Coordinate(x, y))) yield y
    }

    HybridMatrix(size, Vector.empty, factor, positions)
  }
}