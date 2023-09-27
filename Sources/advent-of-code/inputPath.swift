import Foundation

func inputPath(_ day: Int, _ small: Bool) -> URL {
  let url = small
  ? Bundle.module.url(forResource: "day\(day)_input_small", withExtension: "txt", subdirectory: "Resources")!
  : Bundle.module.url(forResource: "day\(day)_input", withExtension: "txt", subdirectory: "Resources")!
  return url
//  return URL(string: "")!
}
