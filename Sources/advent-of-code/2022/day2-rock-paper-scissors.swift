import Foundation
import Algorithms
import Collections

func day2Answer(path: URL) -> Int {
  let fileContent = try? String(contentsOf: path, encoding: .utf8)
  guard let input = fileContent else { return 0 }

  let inputArr = input.components(separatedBy: .newlines)
	print(inputArr[0], inputArr[2])
 // let inputStream = readStringArr()
 // let test1 = inputStream.map { (game: String) -> Substring in
 //   let opponent = game.split(separator: " ")
 //   return opponent[0]
 // }
 // print(test1)
  return 0
}
