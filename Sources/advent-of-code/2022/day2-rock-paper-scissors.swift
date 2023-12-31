import Foundation
import Algorithms
import Collections

class Y2022Day2Answer: DayAnswer {
  let game: [(Opporcp, Myrcp)]

  required init(_ input: String) {
    let inputArr = input.components(separatedBy: .newlines)
    self.game = inputArr.reduce(into: [(Opporcp, Myrcp)]()) { acc, cur in
      let choices = cur.split(separator: " ")
      guard let opponent = choices.first,
        let my = choices.last else { return }
      let opponentChoice = Opporcp(rawValue: String(opponent)) ?? .unknown
      let myChoice = Myrcp(rawValue: String(my)) ?? .unknown
      acc.append((opponentChoice, myChoice))
    }
  }
  func partOne() -> String {
    let result = self.game.reduce(into: 0) { acc, cur in
      let (oppo, my) = cur
      acc += scoringGame(oppo: oppo, my: my)
    }
    return String(result)
  }

  func partTwo() -> String {
    let result = self.game.reduce(into: 0) { acc, cur in
      let (oppo, my) = cur
      acc += scoringLosingGame(oppo: oppo, my: my)
    }
    return String(result)
  }

  func scoringGame(oppo: Opporcp, my: Myrcp) -> Int {
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

  func scoringLosingGame(oppo: Opporcp, my: Myrcp) -> Int {
    var score = 0

    switch my {
    case .X: score += 0
    case .Y: score += 3
    case .Z: score += 6
    default: break
    }

    switch my {
    case .X: // lose
      switch oppo {
      case .A: score += 3
      case .B: score += 1
      case .C: score += 2
      default: break
      }

    case .Y: // draw
      switch oppo {
      case .A: score += 1
      case .B: score += 2
      case .C: score += 3
      default: break
      }

    case .Z: // win
      switch oppo {
      case .A: score += 2
      case .B: score += 3
      case .C: score += 1
      default: break
      }

    default: break
    }

    return score
  }

  enum Opporcp: String {
    case A // rock
    case B // paper
    case C // scissors
    case unknown
  }

  enum Myrcp: String {
    case X // rock / lose
    case Y // paper / draw
    case Z // scissors / win
    case unknown
  }
}
