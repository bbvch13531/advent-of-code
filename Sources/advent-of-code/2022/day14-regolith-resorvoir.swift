import Foundation
import RegexBuilder

struct Day14Answer: DayAnswer {

  func partOne(_ input: String) -> String {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    var map = Array(repeating: Array(repeating: 0, count: 800), count: 300)

    var N = 0
    var minM = Int.max
    var maxM = 0

    inputStream.forEach {
      let points = parseInput($0)
      points.forEach { p in
        N = max(N, p.x)
        maxM = max(maxM, p.y)
        minM = min(minM, p.y)
      }

      let p1 = Array(points.dropLast())
      let p2 = Array(points.dropFirst())

      zip(p1,p2).forEach { (s, e) in
        drawLine(&map, s, e)
      }
    }

    while true {
      let next = fallenSandPosition(map)
      map[next.x][next.y] = 2

      printMap(map, 0...N+1, minM-1...maxM)
    }
    return ""
  }

  func partTwo(_ input: String) -> String {
    return ""
  }

  func isFallingIntoAbyss() -> Bool {
    return true
  }

  func fallenSandPosition(_ map: [[Int]]) -> Point {
    let start = Point(0, 500)

    var i = 0
    while map[i+1][start.y] == 0 {
      i += 1
    }

    var sand = Point(i, start.y)
    var j = 0
    if map[i+1][sand.y] == 2 {
      j += 1
      i += 1
      while map[i+1][sand.y - j - 1] == 2 {
        j += 1
      }
      print(i, sand.y - j)
    }

    return Point(i, sand.y - j)
  }

  func printMap(_ map: [[Int]], _ xRange: ClosedRange<Int>, _ yRange: ClosedRange<Int>) {
    for i in xRange {
      for j in yRange {
        if map[i][j] == 0 {
          print(".", terminator: "")
        } else if map[i][j] == 1 {
          print("#", terminator: "")
        }  else if map[i][j] == 2 {
          print("o", terminator: "")
        }
      }
      print("")
    }

    print("--------")
  }

  func drawLine(_ map: inout [[Int]], _ s: Point, _ e: Point) {
    if s.x == e.x {
      if s.y > e.y {
        for i in e.y...s.y {
          map[s.x][i] = 1
        }
      } else {
        for i in s.y...e.y {
          map[s.x][i] = 1
        }
      }
    } else if s.y == e.y {
      if s.x > e.x {
        for i in e.x...s.x {
          map[i][s.y] = 1
        }
      } else {
        for i in s.x...e.x {
          map[i][s.y] = 1
        }
      }
    }
  }

  func parseInput(_ input: String) -> [Point] {
    let coordinateRegex = Regex {
      TryCapture {
        OneOrMore(.digit)
      } transform: { match in
        Int(match)
      }
      ","
      TryCapture {
        OneOrMore(.digit)
      } transform: { match in
        Int(match)
      }
    }

    let matches = input.matches(of: coordinateRegex)
    return matches.map {
      Point($0.2, $0.1)
    }
  }

  struct Point: Hashable {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
      self.x = x
      self.y = y
    }

    static func == (lhs: Point, rhs: Point) -> Bool {
      return lhs.x == rhs.x
      && lhs.y == rhs.y
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(x)
      hasher.combine(y)
    }
  }
}
