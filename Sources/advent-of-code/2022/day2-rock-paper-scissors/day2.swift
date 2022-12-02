import Foundation
import Algorithms
import Collections

func day2Answer() -> Int {
  let inputStream = readStringArr()
  let test1 = inputStream.map { (game: String) -> Substring in
    let opponent = game.split(separator: " ")
    return opponent[0]
  }
  print(test1)
  return 0
}
