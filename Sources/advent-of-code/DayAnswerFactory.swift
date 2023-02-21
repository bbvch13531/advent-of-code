import Foundation

class DayAnswerFactory {
  func generate(day: Int) -> DayAnswer? {
    switch day {
    case 1:
      return Day1Answer()
    case 2:
      return Day2Answer()
    case 3:
      return Day3Answer()
    case 4:
      return Day4Answer()
    case 5:
      return Day5Answer()
    case 6:
      return Day6Answer()
    case 7:
      return Day7Answer()
    case 8:
      return Day8Answer()
    case 9:
      return Day9Answer()
    case 11:
      return Day11Answer()
    case 12:
      return Day12Answer()
    default:
      return nil
    }
  }
}
