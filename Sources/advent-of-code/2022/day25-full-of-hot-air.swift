import Foundation

final class Y2022Day25Answer: DayAnswer {
  let digits: [String]
  enum Numbers: String {
    case one = "1"
    case two = "2"
    case zero = "0"
    case minusOne = "-"
    case minusTwo = "="
  }

  init(_ input: String) {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    self.digits = inputStream
  }

  func partOne() -> String {
    var number = 0
    for digit in digits {
      var mul = 1
      var value = 0
      let reverseDigit = Array(digit.reversed())

      for i in 0..<reverseDigit.count {
        let d = String(reverseDigit[i])
        let num = Numbers(rawValue: d)
        
        switch num {
        case .one:
          value += mul
        case .two:
          value += 2 * mul
        case .minusOne:
          value += -1 * mul
        case .minusTwo:
          value += -2 * mul
        case .zero, nil:
          break
        }
        mul *= 5
      }
      number += value
    }

    var rems = [Int]()
    while number != 0 {
      let rem = number % 5
      rems.append(rem)
      number /= 5
    }
    var answer = ""

    for i in 0..<rems.count {
      let rem = rems[i]
      if rem == 3 {
        rems[i+1] += 1
        answer.append("=")
      } else if rem == 4 {
        rems[i+1] += 1
        answer.append("-")
      } else if rem == 5 {
        rems[i+1] += 1
        answer.append("0")
      } else {
        answer.append("\(rem)")
      }
    }

    return "\(String(answer.reversed()))"
  }

  func partTwo() -> String {
    ""
  }
}
