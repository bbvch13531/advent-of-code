import Foundation
import Algorithms

struct Day6Answer: DayAnswer {
  func numbersOfProcessMessageMarker(input: String, size: Int) -> Int {
    let res = (0...input.count - size)
    .map {
      input
        .chunk(ofCount: size, $0)
    }
    .enumerated()
    .map { (idx, ele) -> Pair in
      Pair(
        idx,
        ele.reduce(into: "") { acc, cur in
          if !acc.contains(cur) {
            acc.append(cur)
          }
        }
      )
    }
    .filter { (idx, ele) in
      ele.count == size
    }

    return (res.first?.0 ?? 0)
  }

  func partOne(_ input: String) -> String {
    let inputStream = input.components(separatedBy: .newlines)
    let inputString = inputStream.first ?? ""
    return String(numbersOfProcessMessageMarker(input: inputString, size: 4))
  }
  
  func partTwo(_ input: String) -> String {
    let inputStream = input.components(separatedBy: .newlines)
    let inputString = inputStream.first ?? ""

    return String(numbersOfProcessMessageMarker(input: inputString, size: 14))
  }
}

typealias Pair = (Int, String)

extension String {
  func chunk(ofCount: Int, _ index: Int) -> String {
    let s = self.index(self.startIndex, offsetBy: index)
    let e = self.index(s, offsetBy: ofCount)

    return String(self[s..<e])
  }
}
