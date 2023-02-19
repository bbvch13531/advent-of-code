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
    let factory = DayAnswerFactory()
    guard let dayAnswer = factory.generate(day: day) else {
      print("Day\(day) is not found")
      return
    }
//    print(dayAnswer.answer(path: inputPath(day, small), part: part))
    let path = inputPath(day, small)
    guard let input = try? String(contentsOf: path, encoding: .utf8) else {
      print("Resource file does not exist")
      return
    }
    if part == 1 {
      print(dayAnswer.partOne(input))
    } else {
      print(dayAnswer.partTwo(input))
    }
//    let url = inputPath(9, false)
//    let fileContent = try! String(contentsOf: url, encoding: .utf8)
//    let solution = Day9(input: fileContent)
//    print(solution.partOne())
  }
}

AdventOfCode.main()
