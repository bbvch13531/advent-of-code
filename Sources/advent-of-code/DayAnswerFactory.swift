import Foundation

public class DayAnswerFactory {
  public init() { }
  private let answers: [DayAnswer.Type] = [
    Y2022Day1Answer.self, 
    Y2022Day2Answer.self,
    Y2022Day3Answer.self,
    Y2022Day4Answer.self,
    Y2022Day5Answer.self,
    Y2022Day6Answer.self,
    Y2022Day7Answer.self,
    Y2022Day8Answer.self,
    Y2022Day9Answer.self,
    Y2022Day10Answer.self,
    Y2022Day11Answer.self,
    Y2022Day12Answer.self,
    Y2022Day13Answer.self,
    Y2022Day14Answer.self,
    Y2022Day15Answer.self,
    Y2022Day16Answer.self,
    Y2022Day25Answer.self,
    Y2022Day25Answer.self,
    Y2022Day25Answer.self,
    Y2022Day25Answer.self,
    Y2022Day25Answer.self,
    Y2022Day25Answer.self,
    Y2022Day25Answer.self,
    Y2022Day25Answer.self,
    Y2022Day25Answer.self,
  ]

  public func generate(year: Int, day: Int, input: String) -> DayAnswer? {
    if let c = "Y\(year)Day\(day)Answer".toClass() as? DayAnswer.Type {
      return c.init(input)
    }
    return nil
  }
}
