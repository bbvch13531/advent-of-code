import Foundation

struct Day9Answer: DayAnswer {
  func partOne(_ input: String) -> String {
    return ""
  }
  func partTwo(_ input: String) -> String {
    return ""
  }
  func answer(path: URL, part: Int) -> Int {
    let fileContent = try? String(contentsOf: path, encoding: .utf8)
    guard let input = fileContent else { return 0 }
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }

    var head = Point(0, 0)
    var tail = Point(0, 0)
    var track = [Point]()

    inputStream.forEach { line in
      let splited = line.split(separator: " ")
      let direction = splited[0]
      let amount = Int(splited[1])!

      (0..<amount).forEach { _ in
        if direction == "U" {
          head.y = head.y + 1
        } else if direction == "D" {
          head.y = head.y - 1
        } else if direction == "R" {
          head.x = head.x + 1
        } else {
          head.x = head.x - 1
        }
//        printMap(head, tail)
        if shouldMove(from: head, to: tail) {
          tail = nextPosition(head: head, tail: tail)
        }
        track.append(tail)
//        printMap(head, tail)
      }
    }

    let answer = Array(Set(track))
    print(answer.count)

    return 0
  }

  func shouldMove(from: Point, to: Point) -> Bool {
    if from.x == to.x || from.y == to.y {
      return distance(from: from, to: to) > 1
    }
    return distance(from: from, to: to) > 2
  }

  func distance(from: Point, to: Point) -> Int {
    return abs(from.x - to.x) + abs(from.y - to.y)
  }

  func nextPosition(head: Point, tail: Point) -> Point {
    var nx = 0
    var ny = 0

    if abs(head.x - tail.x) == 1 {
      nx = head.x
      ny = (head.y + tail.y) / 2
    } else if abs(head.y - tail.y) == 1 {
      nx = (head.x + tail.x) / 2
      ny = head.y
    } else {
      nx = (head.x + tail.x) / 2
      ny = (head.y + tail.y) / 2
    }
    return Point(nx, ny)
  }

  func trackString(_ track: [Point]) -> [[Character]] {
    var trackString: [[Character]] = Array<[Character]>.init(repeating: [Character](repeatElement(".", count: 6)), count: 5)

    track.forEach { p in
      trackString[p.x][p.y] = "#"
    }
    return trackString
  }

  func printMap(_ head: Point, _ tail: Point) {
    for i in 0..<5 {
      for j in 0..<6 {
        if head.x == i && head.y == j {
          print("H", terminator: "")
        } else if tail.x == i && tail.y == j {
          print("T", terminator: "")
        } else {
          print("O", terminator: "")
        }
      }
      print("")
    }
    print("")
  }

  struct Point: Hashable {
    var x: Int
    var y: Int

    init(_ x: Int, _ y: Int) {
      self.x = x
      self.y = y
    }
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
  }
}
