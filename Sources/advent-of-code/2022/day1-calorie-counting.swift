import Foundation
import Algorithms

struct Day1Answer: DayAnswer {
  func partOne(_ input: String) -> String {
    let inputarr = input.components(separatedBy: .newlines)
    let inputstream = readInt2dArr(input: inputarr)
    let result = inputstream.map { s in
      s.reduce(0) { a, b in a+b }
    }
    .max(count: 1)

    return String(result.first!)
  }

  func partTwo(_ input: String) -> String {
    return ""
  }
}
