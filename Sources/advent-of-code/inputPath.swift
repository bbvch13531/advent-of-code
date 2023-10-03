import Foundation

public func inputPath(_ day: Int, _ small: Bool) -> String {
  let path = small
  ? Bundle.module.path(forResource: "day\(day)_input_small", ofType: "txt")!
  : Bundle.module.path(forResource: "day\(day)_input", ofType: "txt")!
  return path
}
