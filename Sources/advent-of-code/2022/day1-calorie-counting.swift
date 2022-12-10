import Foundation
import Algorithms

func day1Answer(path: URL, part: Int) -> Int {
  let filecontent = try? String(contentsOf: path, encoding: .utf8)

  guard let input = filecontent else { return 0 }

  let inputarr = input.components(separatedBy: .newlines)
  let inputstream = readInt2dArr(input: inputarr)
  let result = inputstream.map { s in
    s.reduce(0) { a, b in a+b }
  }
  .max(count: 1)
 
  return result.first ?? 0
}

