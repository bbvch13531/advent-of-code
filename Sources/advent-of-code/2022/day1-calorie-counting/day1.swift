import Foundation
import Algorithms

func day1Answer(path: URL) -> Int {
  let fileContent = = try? String(contentsOf: path, encoding: .utf8)

  guard let input = fileContent else { return 0 }

  let inputArr = input.components(separatedBy: .newlines)
  let inputStream = readInt2dArr(input: inputArr)
  let result = inputStream.map { s in
    s.reduce(0) { a, b in a+b }
  }
  .max(count: 1)
 
  return result.first ?? 0
}

