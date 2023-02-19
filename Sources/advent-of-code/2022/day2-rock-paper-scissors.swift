import Foundation
import Algorithms
import Collections

struct Day2Answer: DayAnswer {
  func partOne(_ input: String) -> String {
    let inputArr = input.components(separatedBy: .newlines)
    let game = inputArr.reduce(into: [(Opporck, Myrck)]()) { acc, cur in
      let choices = cur.split(separator: " ")
      guard let opponent = choices.first,
        let my = choices.last else { return }
      let opponentChoice = Opporck(rawValue: String(opponent)) ?? .unknown
      let myChoice = Myrck(rawValue: String(my)) ?? .unknown
      acc.append((opponentChoice, myChoice))
    }

    let result = game.reduce(into: 0) { acc, cur in
      let (oppo, my) = cur
      acc += scoringGame(oppo: oppo, my: my)
    }
    return String(result)
  }

  func partTwo(_ input: String) -> String {
    return ""
  }

  func scoringGame(oppo: Opporck, my: Myrck) -> Int {
    var score = 0
    switch my {
    case .X: score += 1
    case .Y: score += 2
    case .Z: score += 3
    default: break
    }

    switch oppo {
    case .A:
      if my == .X { score += 3 }
      else if my == .Y { score += 6 }

    case .B:
      if my == .Y { score += 3 }
      else if my == .Z { score += 6 }

    case .C:
      if my == .Z { score += 3 }
      else if my == .X { score += 6 }

    default: break
    }

    return score
  }

  enum Opporck: String {
    case A // rock
    case B // paper
    case C // scissors
    case unknown
  }

  enum Myrck: String {
    case X // rock
    case Y // paper
    case Z // scissors
    case unknown
  }
}
