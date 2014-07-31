package specificlinalg

import spire.implicits._
import spire.math._

case class Size(n: Int) {
  lazy val dim: Int = 2 ** n
}

case class Coordinate(x: Int, y: Int)