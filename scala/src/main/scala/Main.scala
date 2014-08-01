object Main extends App {
  def time[R](block: => R): R = {
    val t0 = System.nanoTime()
    val result = block    // call-by-name
    val t1 = System.nanoTime()
    println("Elapsed time: " + (t1 - t0) / 1E9 + "s")
    result
  }

  val n = 10//args(0).toInt

  val h_i = ZeroHamiltonian.construct(n)
  val h_f = RandomIsing.construct(n)
  val t = 3.0
  val iter = 1000
  val ninstal = 3

  val result = time { Algorithm.withInstallments(h_i, h_f, t, iter, ninstal) }

  println(result)
}