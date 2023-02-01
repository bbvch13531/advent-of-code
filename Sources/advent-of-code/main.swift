import Foundation
import ArgumentParser

struct AdventOfCode: ParsableCommand {
  @Option(name: [.short, .customLong("day")], help: "Day to solve problem")
  var day: Int

	@Flag(name: [.short, .customLong("small")], help: "Small input")
	var small: Bool = false
	
	@Option(name: [.short, .customLong("part")], help: "Part")
	var part: Int 

  mutating func run() throws {
		switch day {
			case 1: print(day1Answer(path: inputPath(day, small), part: part))
		case 2: print(day2Answer(path: inputPath(day, small), part: part))
		case 3: print(day3Answer(path: inputPath(day, small), part: part))
		case 4: print(day4Answer(path: inputPath(day, small), part: part))
		case 6: print(day6Answer(path: inputPath(day, small), part: part))
		case 10: print(day10Answer(path: inputPath(day, small), part: part))
		case 11: print(day11Answer(path: inputPath(day, small), part: part))
		default: break
		}
	}
}

AdventOfCode.main()
