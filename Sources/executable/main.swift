import Foundation
import ArgumentParser
import advent_of_code

struct AdventOfCode: ParsableCommand {
  @Option(name: [.short, .customLong("year")], help: "Year to solve problem")
  var year: Int

  @Option(name: [.short, .customLong("day")], help: "Day to solve problem")
  var day: Int

  @Flag(name: [.short, .customLong("small")], help: "Small input")
  var small: Bool = false

  @Option(name: [.short, .customLong("part")], help: "Part")
  var part: Int = 1

  mutating func run() throws {
    let factory = DayAnswerFactory()

    let path = inputPath(day, small)
    guard let input = try? String(contentsOfFile: path, encoding: .utf8) else {
      print("Resource file does not exist")
      return
    }
    guard let dayAnswer = factory.generate(year: year, day: day, input: input) else {
      print("Day\(day) is not found")
      return
    }
    if part == 1 {
      print(dayAnswer.partOne())
    } else {
      print(dayAnswer.partTwo())
    }
  }
}

AdventOfCode.main()
