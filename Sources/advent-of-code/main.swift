import Foundation
import ArgumentParser

struct AdventOfCode: ParsableCommand {
  @Option(name: [.short, .customLong("day")], help: "Day to solve problem")
  var day: Int

  mutating func run() throws {
    if day == 1 {
      let stringPath = Bundle.module.url(forResource: "day1_input", withExtension: "txt")!
      let url = stringPath
      print(day1Answer(path: url))
    } else if day == 2 {
      print(day2Answer())
    } 
  }
}

AdventOfCode.main()
