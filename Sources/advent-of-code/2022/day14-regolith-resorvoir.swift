import Foundation
import RegexBuilder

private struct Point {
  let x: Int
  let y: Int

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  func nextDownLeft() -> Point {
    return Point(self.x + 1, self.y - 1)
  }

  func nextDownRight() -> Point {
    return Point(self.x + 1, self.y + 1)
  }
}

extension Point: Hashable {
  static func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}

private enum Land: Int {
  case air = 0
  case rock = 1
  case sand = 2
}

struct Day14Answer: DayAnswer {
  func partOne(_ input: String) -> String {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    var map = Array(repeating: Array(repeating: Land.air, count: 800), count: 300)

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
      let next = fallenSandPosition(map, N)
      if next.x == N {
        break
      }
      map[next.x][next.y] = .sand

//      printMap(map, 0...N+1, minM-1...maxM)
    }

    var count = 0
    for i in 0...N+1 {
      for j in minM-1...maxM {
        if map[i][j] == .sand {
          count += 1
        }
      }
    }
    return "\(count)"
  }

  func partTwo(_ input: String) -> String {
    return ""
  }

  private func fallenSandPosition(_ map: [[Land]], _ maxN: Int) -> Point {
    var cur = Point(0, 500)

    var i = 0

    while i <= maxN {
      var prev = cur
      if map[i][cur.y] == .air {
        cur = Point(i, cur.y)
      } else if map[i][cur.y - 1] == .air  {
        cur = Point(i, cur.y - 1)
      } else if map[i][cur.y + 1] == .air  {
        cur = Point(i, cur.y + 1)
      }

      if i != 0 && cur == prev {
        return cur
      }
      i += 1
    }
    return cur
  }

  private func printMap(_ map: [[Land]], _ xRange: ClosedRange<Int>, _ yRange: ClosedRange<Int>) {
    for i in xRange {
      for j in yRange {
        if map[i][j] == .air {
          print(".", terminator: "")
        } else if map[i][j] == .rock {
          print("#", terminator: "")
        }  else if map[i][j] == .sand {
          print("o", terminator: "")
        }
      }
      print("")
    }

    print("--------")
  }

  private func drawLine(_ map: inout [[Land]], _ s: Point, _ e: Point) {
    if s.x == e.x {
      if s.y > e.y {
        for i in e.y...s.y {
          map[s.x][i] = .rock
        }
      } else {
        for i in s.y...e.y {
          map[s.x][i] = .rock
        }
      }
    } else if s.y == e.y {
      if s.x > e.x {
        for i in e.x...s.x {
          map[i][s.y] = .rock
        }
      } else {
        for i in s.x...e.x {
          map[i][s.y] = .rock
        }
      }
    }
  }

  private func parseInput(_ input: String) -> [Point] {
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
}
