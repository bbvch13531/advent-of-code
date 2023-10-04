import Foundation

public struct Point {
  public let x: Int
  public let y: Int

  public init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  public func moveTo(_ dir: Direction) -> Point {
    switch dir {
    case .southEast:
      return Point(x+1, y+1)
    case .south:
      return Point(x+1, y)
    case .southWest:
      return Point(x+1, y-1)
    }
  }
}

extension Point: Hashable {
  public static func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}

public enum Direction {
  case southEast
  case south
  case southWest
}
