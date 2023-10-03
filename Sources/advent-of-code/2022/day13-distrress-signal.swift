import Foundation
import Algorithms

private enum Packet {
  case int(Int)
  case list([Packet])

  init(_ value: Any) {
    if let intValue = value as? Int {
      self = .int(intValue)
    } else if let listValue = value as? [Packet] {
      self = .list(listValue)
    }
    self = .int(-1)
  }
}

extension Packet: Comparable {
  static func < (lhs: Packet, rhs: Packet) -> Bool {
    switch (lhs, rhs) {
    case let (.int(lValue), .int(rValue)):
      return lValue < rValue

    case let (.list(lList), .list(rList)):
      for zipped in zip(lList, rList) {
        if zipped.0 < zipped.1 { return true }
        if zipped.0 > zipped.1 { return false }
      }
      return lList.count < rList.count

    case (.int, .list):
      return .list([lhs]) < rhs

    case (.list, .int):
      return lhs < .list([rhs])
    }
  }
}

extension Packet: Decodable {
  init(from decoder: Decoder) throws {
    do {
      let c = try decoder.singleValueContainer()
      self = .int(try c.decode(Int.self))
    } catch {
      self = .list(try [Packet](from: decoder))
    }
  }
}

struct Day13Answer: DayAnswer {
  func partOne(_ input: String) -> String {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    let pairs = inputStream.chunks(ofCount: 2)
    let decoder = JSONDecoder()
    let res = pairs.enumerated().map { idx, pair in
      if let left = pair.first, let right = pair.last {
        let leftPacket = try! decoder.decode(Packet.self, from: left.data(using: .utf8)!)
        let rightPacket = try! decoder.decode(Packet.self, from: right.data(using: .utf8)!)
//        print(leftPacket)
//        print(rightPacket)

        if leftPacket < rightPacket {
          return idx + 1
        }
      }
      return 0
    }.reduce(0, +)
    print(res)
    return ""
  }

  func partTwo(_ input: String) -> String {
    return ""
  }
}
