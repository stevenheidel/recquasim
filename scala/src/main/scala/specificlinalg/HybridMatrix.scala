package specificlinalg

import spire.implicits._
import spire.math._

case class Size(n: Int) {
  lazy val dim: Int = 2 ** n
}

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

  // Scalar multiplication
  def *(b: Complex[Double]) = {
    copy(
      diagonal = b *: diagonal,
      factor = b * factor
    )
  }

  // Vector multiplication
  def *(b: IndexedSeq[Complex[Double]]): Vector[Complex[Double]] = {
    if (length != b.length)
      throw new RuntimeException("Matrix and vector lengths must match")
    
    // Multiply the factors with the respective positions in the multiplying vector
    val withFactors = positions.map { x =>
      x.map(y => b(y)).qsum * factor
    }.toVector

    // Then add on the diagonal
    if (diagonal.isEmpty) withFactors
    else withFactors + (b, diagonal).zipped.map(_ * _).toVector
  }

  def +(b: HybridMatrix) = {
    // This check is not performed for speed reasons, it's up to you to make sure
    // you're responsibly adding hybrid matrices
    // if (factor != 0 && b.factor != 0 && positions != b.positions)
    //   throw new RuntimeException("Both matrices have elements off the diagonal in different places")

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

  def withPositions(size: Size, factor: Complex[Double], positions: IndexedSeq[Seq[Int]]) = {
    HybridMatrix(size, Vector.empty, factor, positions)
  }
}