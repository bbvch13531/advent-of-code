import Foundation

public struct PointValue: Hashable {
  public let x: Int
  public let y: Int
  public let val: Int

  public init(_ x: Int, _ y: Int, _ val: Int) {
    self.x = x
    self.y = y
    self.val = val
  }

  public static func == (lhs: PointValue, rhs: PointValue) -> Bool {
    return lhs.x == rhs.x
    && lhs.y == rhs.y
    && lhs.val == rhs.val
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
    hasher.combine(val)
  }

  public static let none = PointValue(0, 0, 0)
}
