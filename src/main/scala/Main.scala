object Main extends App {
  for (i <- 1 to 4) {
    val h = ZeroHamiltonian(i)

    println(h.sparseMatrix.size)
  }
}