import Foundation
import RegexBuilder

//protocol Value { }
//extension Packet: Value { }
//extension Array: Value where Element == Int { }
struct Packet {
  var value: [Any]
}

struct Day13Answer: DayAnswer {
  func partOne(_ input: String) -> String {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    let pairs = inputStream.chunks(ofCount: 2)
//    pairs.forEach { pair in
//      if let left = pair.first, let right = pair.first {
//        print("left", left)
//        print("right", right)
//        
//        let order = compare(left, right)
//      }
//    }
    let str = "[1,[2,3]]"
    let p = parse(str, 0, packet: Packet(value: []))
    print(p)
    return ""
  }

  func partTwo(_ input: String) -> String {
    return ""
  }

  func parse( _ str: String, _ idx: Int, packet: Packet) -> Packet {
    var result = packet
    var i = idx
    let strArray = Array(str)

    while i != str.count {
      let ch = strArray[i]
      if ch == "]" {
        return result
      } else if ch == "[" {
        let p = parse(str, i + 1, packet: result)
        result.value.append(p)
      } else if ch != "," { // number
        result.value.append(ch)
      }
      i += 1
    }
//    guard idx != str.count else {
//    }
    return result
  }

  func compare(_ lhs: String, _ rhs: String) -> Int {
    var idx = 0
    var len = min(lhs.count, rhs.count)

    while idx < len {
      let lch = Array(lhs)[idx]
      let rch = Array(rhs)[idx]

      let lValue = Int(lch.asciiValue ?? 0)
      let rValue = Int(rch.asciiValue ?? 0)

      if isNumeric(value: lValue) && isNumeric(value: rValue) {
        if lValue > rValue {
          // wrong order
          return -1
        } else if lValue < rValue {
          return 1
        }
        idx += 1
        continue
      }

      if lValue == 91 { // [
        
      } else if lValue == 93 { // ]

      } else if lValue == 44 { // ,

      } else {

      }
      idx += 1
    }

    return 0
  }

  func isNumeric(value: Int) -> Bool {
    if 48 <= value && value <= 57 {
      return true
    }
    return false
  }
}
