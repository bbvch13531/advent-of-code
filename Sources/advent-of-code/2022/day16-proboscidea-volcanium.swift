import Foundation
import RegexBuilder

struct Day16Answer: DayAnswer {
  init(_ input: String) {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    let res = inputStream.map { parseInput($0) }
		
		var map = [String:[Path]]()
		var flowRate = [String:Int]()

		for (id, value, next) in res {
//			print(id, value, next)
			flowRate[id] = value
			for n in next {
				let p = Path(d: n, distance: 0)

				if var m = map[id] {
					m.append(p)
					map[id] = m
				} else {
					map[id] = [p]
				}
			}
		}

		for p in map {
			if flowRate[p.key] == 0 && p.key != "AA" {
				print(p.key, p.value)
			}
		}
  }

  func partOne() -> String {
 		   
    return ""
  }

  func partTwo() -> String {
    return ""
  }

  func parseInput(_ line: String) -> (String, Int, [String]) {
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
    let id = String(match.1)
    let pressure = match.2
    let leads = match.3.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
//    print(id, pressure, leads)
    return (id, pressure, leads)
  }
}
