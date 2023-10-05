import Foundation

extension ClosedRange {
  func merge(with range: ClosedRange) -> [ClosedRange] {
    if !self.overlaps(range) {
      return [self, range]
    } else if self.lowerBound < range.upperBound {
      return [range.lowerBound...self.upperBound]
    } else if range.lowerBound < self.upperBound {
      return [self.lowerBound...range.upperBound]
    } else {
      return []
    }
  }
}
