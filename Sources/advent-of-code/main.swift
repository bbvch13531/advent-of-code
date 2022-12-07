import Foundation
import ArgumentParser

struct AdventOfCode: ParsableCommand {
  @Option(name: [.short, .customLong("day")], help: "Day to solve problem")
  var day: Int

	@Flag(name: [.short, .customLong("small")], help: "Small input")
	var small: Bool = false

  mutating func run() throws {
    if day == 1 {
      let stringPath = Bundle.module.url(forResource: "day1_input", withExtension: "txt")!
      let url = stringPath
      print(day1Answer(path: url))
    } else if day == 2 {
      print(day2Answer())
		} else if day == 6 {
			let stringPath = small 
				? Bundle.module.url(forResource: "day6_input_small", withExtension: "txt")!
				: Bundle.module.url(forResource: "day6_input", withExtension: "txt")!
      let url = stringPath
			print(day6Answer(path: url))
		}
	}
}

AdventOfCode.main()
