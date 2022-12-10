import Foundation
import Algorithms
import RegexBuilder

func day4Answer(path: URL, part: Int) -> Int {
  guard let input = try? String(contentsOf: path, encoding: .utf8) else { return 0 }

	let regex = Regex {
		Capture {
			OneOrMore(.digit)
		}
		"-"
		Capture {
			OneOrMore(.digit)
		}
		","
		Capture {
			OneOrMore(.digit)
		}
		"-"
		Capture {
			OneOrMore(.digit)
		}
	}
  let inputarr = input.components(separatedBy: .newlines).filter { $0.count != 0 }

	var count = 0
	inputarr.forEach { line in
		guard let match = line.wholeMatch(of: regex) else { return }
		let (s1, e1) = (Int(match.1)!, Int(match.2)!)
		let (s2, e2) = (Int(match.3)!, Int(match.4)!)
	
		if part == 1 {
			if s1 <= s2 && e2 <= e1 {
				count += 1
			} else if s2 <= s1 && e1 <= e2 {
				count += 1
			}
		} else {
			if (s1...e1).overlaps((s2...e2)) {
				count += 1
			}
		}
	}
	return count
}
