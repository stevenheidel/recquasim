import specificlinalg._
import breeze.linalg._
import scala.util.Random

object RandomIsing {
  def construct(n: Int): SpecialMatrix = {
    SpecialMatrix.withDiagonal(Size(n), SpecialVector.fromDenseVector(denseVector(n)))
  }

  def denseVector(n: Int): DenseVector[Int] = {
    val size = math.pow(2, n).toInt
    val result = DenseVector.zeros[Int](size)

    for (i <- 2 to n; j <- 1 until i) {
      val j_kl = 1//if (Random.nextBoolean) 1 else -1
      
      result -= h_kl(n, i, j) :* j_kl
    }

    result
  }

  def h_kl(n: Int, l: Int, k: Int): DenseVector[Int] = {
    val half = recurse(n, l, k)

    DenseVector.vertcat(half, reverse(half))
  }

  def recurse(n: Int, l: Int, k: Int): DenseVector[Int] = {
    if (l == 2 && k == 1) {
      val quarter = math.pow(2, n-2).toInt

      DenseVector.vertcat(
        DenseVector.ones[Int](quarter),
        -DenseVector.ones[Int](quarter)
      )
    }
    else if (k == 1) {
      val sub = recurse(n-1, l-1, k)

      DenseVector.vertcat(sub, sub)
    }
    else {
      val sub = recurse(n-1, l-1, k-1)

      DenseVector.vertcat(sub, reverse(sub))
    }
  }
}