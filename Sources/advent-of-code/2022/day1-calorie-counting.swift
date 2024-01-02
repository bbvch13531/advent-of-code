import Foundation
import Algorithms

final class Y2022Day1Answer: DayAnswer {
  let inputStream: [[Int]]

  init(_ input: String) {
    let inputarr = input.components(separatedBy: .newlines)
    self.inputStream = readInt2dArr(input: inputarr)
  }

  func partOne() -> String {
    let result = inputStream.map { s in
      s.reduce(0) { a, b in a+b }
    }
    .max(count: 1)
    return String(result.first!)
  }

  func partTwo() -> String {
    let result = inputStream.map { s in
      s.reduce(0) { a, b in a+b }
    }
    .max(count: 3)
    .reduce(into: 0) { acc, cur in
      acc += cur
    }
    return String(result)
  }
}
