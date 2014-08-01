import specificlinalg._

object ZeroHamiltonian {
  def construct(n: Int): HybridMatrix = {
    val size = Size(n)
    val positions = IndexedSeq.fill[collection.mutable.Buffer[Int]](size.dim)(collection.mutable.Buffer.empty)

    recurse(size.dim, 0, 0) { (x, y, xOff, yOff) =>
      positions(x + xOff) += y + yOff
    }
    
    HybridMatrix.withPositions(size, -1, positions)
  }

  def recurse(dim: Int, xOff: Int, yOff: Int)(add: (Int, Int, Int, Int) => Unit): Unit = {
    if (dim == 2) {
      // Pauli(1) matrix
      add(0, 1, xOff, yOff)
      add(1, 0, xOff, yOff)
    }
    else {
      val half = dim / 2

      // Upper left
      recurse(half, xOff, yOff)(add)

      // Upper right
      (0 until half) map { i =>
        add(i, i, xOff + half, yOff)
      }

      // Lower left
      (0 until half) map { i =>
        add(i, i, xOff, yOff + half)
      }

      // Lower right
      recurse(half, xOff + half, yOff + half)(add)
    }
  }
}