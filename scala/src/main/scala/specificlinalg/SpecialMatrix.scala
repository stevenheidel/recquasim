package specificlinalg

import spire.implicits._
import spire.math._

/*
Specialized Matrix Requirements:
- All elements off of the diagonal are the same element or zero
- Ever row contains the same number of non-zero elements (excluding diagonal)
- Matrix needs to be symmetrical, row/column ordering is the same
- Only ever multiplied with a vector, so just need a count of elements per row
*/

case class SpecialMatrix(
  size: Size, // Size of the matrix
  diagonal: SpecialVector,
  factor: Complex[Double],
  factorsPerRow: Int
) {
  val length = size.dim

  def *(b: Complex[Double]) = {
    copy(
      diagonal = diagonal * b,
      factor = factor * b
    )
  }

  def *(b: SpecialVector): SpecialVector = {
    if (length != b.length)
      throw new RuntimeException("Special matrix and special vector lengths must match")

    val newVector = b * factor * factorsPerRow
    
    if (diagonal.isEmpty) newVector
    else newVector element_* diagonal
  }

  def +(b: SpecialMatrix) = {
    if (factor != 0 && b.factor != 0) 
      throw new RuntimeException("Both special matrices have elements off the diagonal!")

    val newDiagonal = {
      if      (diagonal.isEmpty)   b.diagonal
      else if (b.diagonal.isEmpty) diagonal
      else                         diagonal + b.diagonal
    }

    copy(
      diagonal = newDiagonal, 
      factor = factor + b.factor, 
      factorsPerRow = max(factorsPerRow, b.factorsPerRow)
    )
  }

  def -(b: SpecialMatrix) = {
    this.+(b * -1)
  }
}

object SpecialMatrix {
  def withDiagonal(size: Size, diagonal: SpecialVector) = {
    SpecialMatrix(size, diagonal, 0, 0)
  }

  def noDiagonal(size: Size, factor: Complex[Double], factorsPerRow: Int) = {
    SpecialMatrix(size, SpecialVector.empty, factor, factorsPerRow)
  }
}