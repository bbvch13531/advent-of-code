import Foundation

public class DayAnswerFactory {
  public init() { }
  public func generate(day: Int, input: String) -> DayAnswer? {
    switch day {
    case 1:
      return Day1Answer(input)
    case 2:
      return Day2Answer(input)
    case 3:
      return Day3Answer(input)
    case 4:
      return Day4Answer(input)
    case 5:
      return Day5Answer(input)
    case 6:
      return Day6Answer(input)
    case 7:
      return Day7Answer(input)
    case 8:
      return Day8Answer(input)
    case 9:
      return Day9Answer(input)
    case 11:
      return Day11Answer(input)
    case 12:
      return Day12Answer(input)
    case 13:
      return Day13Answer(input)
    case 14:
      return Day14Answer(input)
    default:
      return nil
    }
  }
}
