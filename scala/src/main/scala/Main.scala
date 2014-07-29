object Main extends App {
  val n = args(0).toInt

  println(RandomIsing(n))
  //val result = PSuccessDWaveTest(ZeroHamiltonian(n).sparseMatrix, RandomIsing(n), 3, 1000)

  //println(result)
}

/*
15 -    0:41.76 - 1555244
16 -    1:57.60 - 1655864
17 -    5:06.52 - 1907628
18 -   15:29.75 - 2291812
19 -   51:46.16 - 3732264
20 - 2:53:02    - 7681388
*/