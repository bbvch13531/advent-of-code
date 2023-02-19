import Foundation
import Algorithms

struct Day6Answer: DayAnswer {
  func partOne(_ input: String) -> String {
    return ""
  }
  func partTwo(_ input: String) -> String {
    return ""
  }
  func answer(path: URL, part: Int) -> Int {
    let fileContent = try? String(contentsOf: path, encoding: .utf8)

    guard let input = fileContent else { return 0 }

    let inputStream = input.components(separatedBy: .newlines)
    let inputString = inputStream.first ?? ""
    let res = (0...inputString.count - 4)
    .map {
      inputString
        .chunk(ofCount: 4, $0)
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
      ele.count == 4
    }

    return (res.first?.0 ?? 0) + 4
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
