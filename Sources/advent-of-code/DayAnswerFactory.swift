import Foundation

public class DayAnswerFactory {
  public init() { }
  private let answers: [DayAnswer.Type] = [
    Day1Answer.self, 
    Day2Answer.self,
    Day3Answer.self,
    Day4Answer.self,
    Day5Answer.self,
    Day6Answer.self,
    Day7Answer.self,
    Day8Answer.self,
    Day9Answer.self,
    Day10Answer.self,
    Day11Answer.self,
    Day12Answer.self,
    Day13Answer.self,
    Day14Answer.self,
    Day15Answer.self
  ]

  public func generate(day: Int, input: String) -> DayAnswer? {
    return answers[day-1].init(input)
  }
}
