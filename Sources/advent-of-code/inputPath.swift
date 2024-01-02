import Foundation

public func inputPath(_ year: Int, _ day: Int, _ small: Bool) -> String {
  let path = small
  ? Bundle.module.path(forResource: "\(year)_\(day)_input_small", ofType: "txt")!
  : Bundle.module.path(forResource: "\(year)_\(day)_input", ofType: "txt")!
  return path
}
