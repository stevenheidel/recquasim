object Main extends App {
  val n = 3

  val h_i = ZeroHamiltonian.construct(n)
  val h_f = RandomIsing.construct(n)
  val t = 3.0
  val iter = 3
  val ninstal = 1

  val result = Algorithm.withInstallments(h_i, h_f, t, iter, ninstal)

  println(result)
}