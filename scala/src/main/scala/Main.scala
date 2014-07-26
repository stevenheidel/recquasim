object Main extends App {
  val n = args(0).toInt

  val result = PSuccessDWaveTest(ZeroHamiltonian(n).sparseMatrix, RandomIsing(n), 3, 1000)
  
  println(result)
}