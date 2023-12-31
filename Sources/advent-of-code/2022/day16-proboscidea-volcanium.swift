import Foundation
import RegexBuilder

struct Y2022Day16Answer: DayAnswer {
  init(_ input: String) {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    let res = inputStream.map { parseInput($0) }
    let N = res.count
    var map = [String: [Path]]()
		var flowRate = [String: Int]()

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

    var visited = Array<Bool>.init(repeating: false, count: N)
    
    var queue = ["AA"]

    while !queue.isEmpty {
      let cur = queue.removeFirst()
      
      // if cur to X and X to Y, X is 0
      // connect cur to Y distance 2
      
      map[cur]?.forEach { p in 
        if p.distance == 0 {
          queue.append(p.d)
        }
      }
    }

    var test = [String: Int]()
    test["asd", default: 3]


    
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

    return (id, pressure, leads)
  }
}
