import Foundation
import Algorithms
import RegexBuilder

struct Day4Answer: DayAnswer {
  let regex = Regex {
    TryCapture {
      OneOrMore(.digit)
    } transform: { match in
      Int(match)
    }
    "-"
    TryCapture {
      OneOrMore(.digit)
    } transform: { match in
      Int(match)
    }
    ","
    TryCapture {
      OneOrMore(.digit)
    } transform: { match in
      Int(match)
    }
    "-"
    TryCapture {
      OneOrMore(.digit)
    } transform: { match in
      Int(match)
    }
  }

  func partOne(_ input: String) -> String {
    let inputarr = input.components(separatedBy: .newlines).filter { $0.count != 0 }

    var count = 0
    inputarr.forEach { line in
      guard let match = line.wholeMatch(of: regex) else { return }
      let (s1, e1) = (match.1, match.2)
      let (s2, e2) = (match.3, match.4)
        if s1 <= s2 && e2 <= e1 {
          count += 1
        } else if s2 <= s1 && e1 <= e2 {
          count += 1
        }
    }
    return String(count)
  }

  func partTwo(_ input: String) -> String {
    let inputarr = input.components(separatedBy: .newlines).filter { $0.count != 0 }

    var count = 0
    inputarr.forEach { line in
      guard let match = line.wholeMatch(of: regex) else { return }
      let (s1, e1) = (match.1, match.2)
      let (s2, e2) = (match.3, match.4)
      if (s1...e1).overlaps((s2...e2)) {
        count += 1
      }
    }
    return String(count)
  }
}
