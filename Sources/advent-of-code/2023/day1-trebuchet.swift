import Foundation
import RegexBuilder

final class Y2023Day1Answer: DayAnswer {
  let strings: [String]

  init(_ input: String) {
    self.strings =  input.components(separatedBy: .newlines).filter { $0.count != 0 }
  }

  private func calibrate(string: String) -> Int {
    let numberString = string.components(separatedBy: .decimalDigits.inverted).joined(separator: "")
    let first = numberString.first?.lowercased() ?? ""
    let last = numberString.last?.lowercased() ?? ""
    return Int(first+last) ?? 0
  }

  func partOne() -> String {
    let answer = strings.reduce(into: 0) { acc, cur in
      acc += calibrate(string: cur)
    }
    return "\(answer)"
  }

  func partTwo() -> String {
    var answer = 0

    for string in strings {
      let converted = replaceSpellDigit(in: string)
      let num2 = calibrate(string: converted)
      answer += num2
    }

    return "\(answer)"
  }
  func replaceSpellDigit(in string: String) -> String {
    let spellingDigits = [
        "one": "one1one",
        "two": "two2two",
        "three": "three3three",
        "four": "four4four",
        "five": "five5five",
        "six": "six6six",
        "seven": "seven7seven",
        "eight": "eight8eight",
        "nine": "nine9nine"
    ]
    var str = string
    spellingDigits.keys.forEach { digit in
      str = str.replacingOccurrences(of: digit, with: spellingDigits[digit]!)
    }
    return str
  }
}
