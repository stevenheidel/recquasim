import breeze.linalg._
import breeze.numerics._
import scala.util.Random

object RandomIsing {
  def toSparseMatrix(vector: DenseVector[Int]): CSCMatrix[Int] = {
    val size = vector.length
    val builder = new CSCMatrix.Builder[Int](rows=size, cols=size)

    for (i <- 0 until size) {
      builder.add(i, i, vector(i))
    }

    builder.result()
  }

  def apply(n: Int): DenseVector[Int] = {
    val size = math.pow(2, n).toInt
    val result = DenseVector.zeros[Int](size)

    for (i <- 2 to n; j <- 1 until i) {
      val j_kl = if (Random.nextBoolean) 1 else -1
      
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

/*
for n=4
2 1 => 4 1s, 4 -1s
3 1 => 2 1 doubled
3 2 => 2 1 reversed
4 1 => 3 1 doubled
4 2 => 3 1 reversed
4 3 => 3 2 reversed

if (l == 2, k == 1)
  half 1s, half -1s
else
  if (k == 1)
    (i-1, j-1) doubled
  else
    (i-1, j-1) reversed
*/