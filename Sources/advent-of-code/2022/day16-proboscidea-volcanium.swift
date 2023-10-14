import Foundation
import RegexBuilder

struct Day16Answer: DayAnswer {
  init(_ input: String) {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    let res = inputStream.map { parseInput($0) }
  }

  func partOne() -> String {
    
    return ""
  }

  func partTwo() -> String {
    return ""
  }

  func parseInput(_ line: String) -> String {
    let regex = Regex {
      "Valve "
      Capture {
        OneOrMore(.word)
      }
      " has flow rate="
      Capture(OneOrMore(.digit)) { Int($0)! }

      ChoiceOf {
        "; tunnels lead to valves "
        "; tunnel leads to valve "
      }
      Capture(ZeroOrMore(.any)) { String($0) }
    }

    let match = try! regex.wholeMatch(in: line)!.output
    let id = match.1
    let pressure = match.2
    let leads = match.3.components(separatedBy: ",")
    print(id, pressure, leads)
    return ""
  }
}
