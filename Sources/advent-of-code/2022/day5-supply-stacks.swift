import Foundation
import Algorithms
import RegexBuilder

func day5Answer(path: URL, part: Int) -> Int {
  guard let input = try? String(contentsOf: path, encoding: .utf8) else { return 0 }
  let inputArr = input.components(separatedBy: .newlines).filter { $0.count != 0 }

	let regex = Regex {
		
	}
	inputArr.forEach { line in
		
	}
	return 0
}
