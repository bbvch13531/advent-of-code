import Algorithms
import Collections
import Foundation

struct Day12Answer: DayAnswer {
  func partOne(_ input: String) -> String {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }

    let map = parseInput(inputStream)

    let N = map.count
    let M = map[0].count

    var check = Array(repeating: Array(repeating: Int.max, count: M), count: N)

    var start = Point.none
    var end = Point.none

    map.forEach { row in
      row.forEach { p in
        if p.val == -1 {
          start = p
        } else if p.val == 9999 {
          end = p
        }
      }
    }
    var answer = 0

    let dx = [-1, 0, 1, 0]
    let dy = [0, 1, 0, -1]

    var queue = [Point]()
    queue.append(start)

    check[start.x][start.y] = 0

    while !queue.isEmpty {
      let current = queue.removeFirst()

      let x = current.x
      let y = current.y


      if current.val == 9999 {
        answer = check[x][y]
      }

      for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]

        if 0 <= nx && nx < N && 0 <= ny && ny < M {
          if check[nx][ny] > check[x][y] + 1 {
            let np = map[nx][ny]
            if np.val <= current.val + 1 || np == end {
              check[nx][ny] = check[x][y] + 1
              queue.append(np)
            }
          }
        }
      }
    }
    return String(answer)
  }

  func partTwo(_ input: String) -> String {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }

    let map = parseInput(inputStream)

    let N = map.count
    let M = map[0].count

    var check = Array(repeating: Array(repeating: Int.max, count: M), count: N)

    var start = Point.none
    var end = Point.none

    var startingPoints = [Point]()

    map.forEach { row in
      row.forEach { p in
        if p.val == -1 {
          start = p
        } else if p.val == 9999 {
          end = p
        } else if p.val == 0 {
          startingPoints.append(p)
          check[p.x][p.y] = 0
        }
      }
    }
    var answer = 0

    let dx = [-1, 0, 1, 0]
    let dy = [0, 1, 0, -1]

    var queue = [Point]()
    queue.append(contentsOf: startingPoints)

    while !queue.isEmpty {
      let current = queue.removeFirst()

      let x = current.x
      let y = current.y


      if current.val == 9999 {
        answer = check[x][y]
      }

      for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]

        if 0 <= nx && nx < N && 0 <= ny && ny < M {
          if check[nx][ny] > check[x][y] + 1 {
            let np = map[nx][ny]
            if np.val <= current.val + 1 || np == end {
              check[nx][ny] = check[x][y] + 1
              queue.append(np)
            }
          }
        }
      }
    }
    return String(answer)
  }

  func printMap(_ check: [[Int]]) {
    print("------------------------")
    check.forEach { row in
      row.forEach { value in
        if value == Int.max {
          print(String(format: "%3d", 0), terminator: "")
        } else {
          print(String(format: "%3d", value), terminator: "")
        }
      }
      print("")
    }
    print("------------------------")
  }

  func parseInput(_ input: [String]) -> [[Point]] {
    input.enumerated().map { row in
      row.element.enumerated().map { (idx, ch) in
        if ch == "S" {
          return Point(row.offset, idx, -1)
        } else if ch == "E" {
          return Point(row.offset, idx, 9999)
        } else {
          let val = Int(ch.asciiValue! - Character("a").asciiValue!)
          return Point(row.offset, idx, val)
        }
      }
    }
  }

  struct Point: Hashable {
    let x: Int
    let y: Int
    let val: Int

    init(_ x: Int, _ y: Int, _ val: Int) {
      self.x = x
      self.y = y
      self.val = val
    }

    static func == (lhs: Point, rhs: Point) -> Bool {
      return lhs.x == rhs.x
      && lhs.y == rhs.y
      && lhs.val == rhs.val
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(x)
      hasher.combine(y)
      hasher.combine(val)
    }

    static let none = Point(0, 0, 0)
  }
}
