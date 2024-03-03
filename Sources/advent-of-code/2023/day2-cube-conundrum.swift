import Foundation
import RegexBuilder

final class Y2023Day2Answer: DayAnswer {
  let games: [CubeSet]

  init(_ input: String) {
    let lines =  input.components(separatedBy: .newlines).filter { $0.count != 0 }
    self.games = Y2023Day2Answer.parseInput(lines)
  }
  
  func partOne() -> String {
    var numberSum = 0
    for game in games {
      var isPossible = true
      for cube in game.cubes {
        if !isPossibleSet(set: cube) {
          isPossible = false
        }
      }
      if isPossible {
        numberSum += game.gameNum
      }
    }
    return "\(numberSum)"
  }
  
  func partTwo() -> String {
    return ""
  }
  
  func fillEmptyColor(set: [Cube]) -> [Cube] {
    var colorSet = Set(CubeColor.allCases)
    colorSet.remove(.unknown)
    let targetSet = Set(set.map { $0.color })

    let emptyColors = colorSet.subtracting(targetSet)

    let arr = Array(emptyColors).map { Cube(color: $0, number: -1) }

    let result = set + arr
    return result
  }

  func isPossibleSet(set: [Cube]) -> Bool {
    let maxSet = [
      Cube(color: .red, number: 12),
      Cube(color: .green, number: 13),
      Cube(color: .blue, number: 14),
    ]
    
    // append empty color bag
    let filledSet = fillEmptyColor(set: set)

    let sortedSet = filledSet.sorted { lhs, rhs in
      lhs.color > rhs.color
    }
//    print(sortedSet)
    let res = zip(maxSet, sortedSet).map { maxBag, bag in
      bag <= maxBag
    }
//    print(res)
    return res.contains(false)
  }

  static func parseInput(_ lines: [String]) -> [CubeSet] {
    let gameNumRegex = Regex {
      "Game "
      TryCapture {
        OneOrMore(.digit)
      } transform : { match in
        Int(match)
      }
      One(":")
    }

    var cubeSet = [CubeSet]()

    for line in lines {
      guard let match = line.firstMatch(of: gameNumRegex) else {
        print("parse failed: \(line)")
        return []
      }
      let gameNum = match.output.1

      let subStrings = String(line.split(separator: ":").last ?? "")
        .split(separator: ";")
        .map { $0.trimmingCharacters(in: .whitespaces) }

      let cubes = subStrings
        .reduce(into: [[Cube]]()) { acc, cur in
          let sets = cur.split(separator: ",")
          let cubeSet = sets.map { cube in
            let splited = cube.split(separator: " ")
            let color = CubeColor(fromRawValue: String(splited[1]))
            let number = String(splited[0])
            return Cube(color: color, number: Int(number) ?? -1)
          }
          acc.append(cubeSet)
        }
      cubeSet.append(CubeSet(gameNum: gameNum, cubes: cubes))
    }
    return cubeSet
  }

  struct CubeSet: CustomStringConvertible {
    let gameNum: Int
    let cubes: [[Cube]]

    init(gameNum: Int, cubes: [[Cube]]) {
      self.gameNum = gameNum
      self.cubes = cubes
    }

    var description: String {
      "game\(gameNum): \(cubes)"
    }
  }

  struct Cube: CustomStringConvertible {
    let color: CubeColor
    let number: Int

    init(color: CubeColor, number: Int) {
      self.color = color
      self.number = number
    }

    var description: String {
      "\(self.color): \(number)"
    }
  }

  enum CubeColor: String, CustomStringConvertible {
    case red
    case green
    case blue
    case unknown

    init(fromRawValue value: String) {
      self = CubeColor.init(rawValue: value) ?? .unknown
    }

    var description: String {
      self.rawValue
    }
  }
}

extension Y2023Day2Answer.Cube: Comparable, Equatable {
  static func < (lhs: Y2023Day2Answer.Cube, rhs: Y2023Day2Answer.Cube) -> Bool {
    return lhs.number < rhs.number
  }

  static func == (lhs: Y2023Day2Answer.Cube, rhs: Y2023Day2Answer.Cube) -> Bool {
    return lhs.color == rhs.color
  }
}

extension Y2023Day2Answer.CubeColor: Comparable, CaseIterable {
  static func < (lhs: Y2023Day2Answer.CubeColor, rhs: Y2023Day2Answer.CubeColor) -> Bool {
    switch (lhs, rhs) {
    case (.green, .red): return true
    case (.blue, .red): return true
    case (.blue, .green): return true
    default: return false
    }
  }
}
