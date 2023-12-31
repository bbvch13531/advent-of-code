import Foundation
import RegexBuilder

enum Land: Int {
  case air = 0
  case rock = 1
  case sand = 2
}

final class Y2022Day14Answer: DayAnswer {
  var N = 0
  var minM = Int.max
  var maxM = 0
  var map = Array(repeating: Array(repeating: Land.air, count: 800), count: 300)

  init(_ input: String) {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }

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
        drawLine(s, e)
      }
    }
  }

  func partOne() -> String {
    while true {
      let next = fallenSandPosition(map, N)
      if next.x == N {
        break
      }
      map[next.x][next.y] = .sand

      printMap(map, 0...N+1, minM-1...maxM)
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

  func partTwo() -> String {
    let floor = N + 2
    map = Array(map[0...floor])
    map[floor] = Array(repeating: Land.rock, count: map[0].count)

    while true {
      let next = fallenSandPosition(map, floor)
      map[next.x][next.y] = .sand
      if next == Point(0, 500) {
        break
      }
    }
//    printMap(map, 0...floor, 0..<800)
    var count = 0
    for i in 0...floor {
      for j in 0..<800 {
        if map[i][j] == .sand {
          count += 1
        }
      }
    }
    return "\(count)"
  }

  private func fallenSandPosition(_ map: [[Land]], _ maxN: Int) -> Point {
    var cur = Point(0, 500)
    var i = 0

    while i < maxN {
      let prev = cur
      if map[i+1][cur.y] == .air {
        cur = cur.moveTo(.south)
      } else if map[i+1][cur.y - 1] == .air  {
        cur = cur.moveTo(.southWest)
      } else if map[i+1][cur.y + 1] == .air  {
        cur = cur.moveTo(.southEast)
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

  private func drawLine(_ s: Point, _ e: Point) {
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
