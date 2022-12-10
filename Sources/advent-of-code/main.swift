import Foundation
import ArgumentParser

struct AdventOfCode: ParsableCommand {
  @Option(name: [.short, .customLong("day")], help: "Day to solve problem")
  var day: Int

	@Flag(name: [.short, .customLong("small")], help: "Small input")
	var small: Bool = false

  mutating func run() throws {
		switch day {
		case 1: print(day1Answer(path: inputPath(day: day, small: small)))
		case 2: print(day2Answer(path: inputPath(day: day, small: small)))
		case 3: print(day3Answer(path: inputPath(day: day, small: small)))
		case 6: print(day6Answer(path: inputPath(day: day, small: small)))
		default: break
		}
    if day == 1 {
      
    } else if day == 2 {
      print(day2Answer(path: inputPath(day: day, small: small)))
		} else if day == 6 {
      print(day6Answer(path: inputPath(day: day, small: small)))
		}
	}
}

AdventOfCode.main()
