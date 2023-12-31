import Foundation

public extension String {
  func toClass() -> AnyClass? {
    struct Namespace {
      static let moduleName = String(reflecting: DayAnswer.self).prefix{$0 != "."}
    }
    return NSClassFromString("\(Namespace.moduleName).\(self)")
  }
}
