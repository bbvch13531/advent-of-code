import Foundation

func readInt2dArr(input: [String]) -> [[Int]] {
  var result = [[Int]]()
  var array = [Int]()

  input.forEach { num in
    if num == "" {
     result.append(array) 
     array = []
    } else {
      array.append(Int(num) ?? 0)
    }
  }
  return result
}

func readStringArr() -> [String] {
  var input = [String]()

  while let line = readLine() {
    input.append(line)
  }

  return input
}

