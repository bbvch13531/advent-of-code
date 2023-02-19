import Foundation
import Algorithms
import RegexBuilder

struct Day11Answer: DayAnswer {
  func partOne(_ input: String) -> String {
    return ""
  }
  func partTwo(_ input: String) -> String {
    return ""
  }
}

func day11Answer(path: URL, part: Int) -> Int {
  guard let fileContent = try? String(contentsOf: path, encoding: .utf8) else { return 0 }
  let inputArr = fileContent.components(separatedBy: .newlines)

//	let monkeyRegex = Regex {
//	"Monkey "
//		
//		TryCapture {
//			OneOrMore(.digit)
//		} transform: { match in
//			Int(match)
//		}
//		":"
//	}
//	let regex = Regex {
//		"Starting Items: "
//
//		Capture {
//			One(
//		}
//	}
//	inputArr.forEach { line in 
//		guard let monkeyMatch = line.wholeMatch(of: monkeyRegex) else { return }
//		print("monkey num = \(monkeyMatch.1)")
//
//		guard let itemMatch = line.wholeMatch(of: regex) else { return }
//		print(itemMatch)
//	}
	return 0
}
