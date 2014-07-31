package specificlinalg

import spire.implicits._
import spire.math._

case class SpecialVector(
  seq: Seq[Complex[Double]]
) {
  val length = seq.length

  def isEmpty = seq.isEmpty

  def *(b: Complex[Double]) = copy(seq.map(_ * b))

  def element_*(b: SpecialVector) = copy((seq, b.seq).zipped.map(_ * _))

  def +(b: SpecialVector) = {
    if (seq.length != b.seq.length)
      throw new RuntimeException("Both special vectors are not the same length!")

    copy((seq, b.seq).zipped.map(_ + _))
  }

  def -(b: SpecialVector) = {
    this.+(b * -1)
  }
}

object SpecialVector {
  import breeze.linalg._

  def empty = SpecialVector(Seq.empty)

  def fromDenseVector(denseVector: DenseVector[Int]) = {
    SpecialVector(denseVector.toArray.map(x => Complex(x.toDouble, 0)))
  }
}