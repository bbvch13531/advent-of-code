import Foundation
import Algorithms

struct Day3Answer: DayAnswer {
  func partOne(_ input: String) -> String {
    let inputStream = input.components(separatedBy: .newlines)

    let commonChars = inputStream
      .filter { $0.count != 0 }
      .map { word in
        let test = word.chunks(ofCount: word.count/2)

        let s = test.startIndex
        let e = test.index(s, offsetBy: 1)

        let first = test[s]
        let second = test[e]
        let char = first.map { c1 in
          second.filter { c2 in
            c1 == c2
          }
        }
        .filter { $0 != "" }
        let commonChar = char.first ?? ""
        return Array(Set(commonChar))
      }
      .map { $0.first }
      .compactMap { $0 }
      .map { (char: Character) -> Int in
        let lowercase = Character("a").asciiValue! ... Character("z").asciiValue!
        let uppercase = Character("A").asciiValue! ... Character("Z").asciiValue!
        if lowercase.contains(char.asciiValue!) {
          return Int(char.asciiValue! - Character("a").asciiValue! + 1)
        } else if uppercase.contains(char.asciiValue!) {
          return Int(char.asciiValue! - Character("A").asciiValue! + 27)
        }
        return 0
      }
    let res = commonChars.reduce(into: 0) { acc, cur in
      acc += cur
    }
    return String(res)
  }

  func partTwo(_ input: String) -> String {
    let inputArr = input.components(separatedBy: .newlines).filter { $0.count != 0 }

    let answer = inputArr.chunks(ofCount: 3)
      .reduce(into: 0) { acc, words in
        let commonChar = words.reduce(into: Set<Character>()) { acc, cur in
          let arr = Array<Character>.init(cur)
          let set = Set(arr)
          if acc.count == 0 {
            acc.formUnion(set)
          } else {
            acc.formIntersection(set)
          }
        }.map { (char: Character) -> Int in
          let lowercase = Character("a").asciiValue! ... Character("z").asciiValue!
          let uppercase = Character("A").asciiValue! ... Character("Z").asciiValue!
          if lowercase.contains(char.asciiValue!) {
            return Int(char.asciiValue! - Character("a").asciiValue! + 1)
          } else if uppercase.contains(char.asciiValue!) {
            return Int(char.asciiValue! - Character("A").asciiValue! + 27)
          }
          return 0
        }
        let score = commonChar.reduce(0, +)
        acc += score
      }
    return String(answer)
  }
}
