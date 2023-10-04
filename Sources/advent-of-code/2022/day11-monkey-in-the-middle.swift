import Foundation
import Algorithms
import RegexBuilder

final class Day11Answer: DayAnswer {
  struct Monkey {
    let id: Int
    var items: [Int]
    let operationUsingOld: Bool
    let operatorIsAdd: Bool
    let operand: Int
    let testDivisor: Int
    let testTrue: Int
    let testFalse: Int
  }

  var monkeys: [Monkey]

  init(_ input: String) {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    self.monkeys = Day11Answer.parseInput(inputStream)
  }

  func partOne() -> String {
    var inspectCount = Array(repeating: 0, count: monkeys.count)
    let transform = { x in x / 3 }

    for _ in 0..<20 {
      monkeys = monkeys.reduce(into: monkeys) { (accMonkey: inout [Monkey], curMonkey: Monkey) in
        let newItems = applyOperation(
          items: accMonkey[curMonkey.id].items,
          curMonkey.operatorIsAdd,
          curMonkey.operationUsingOld,
          curMonkey.operand
        ).reduce(into: ([Int](), [Int]())) { ( acc: inout ([Int], [Int]), cur: Int) in
          let newLevel = transform(cur)

          if isDivideTestTrue(item: newLevel, divisor: curMonkey.testDivisor) {
            acc.0.append(newLevel) // true
          } else{
            acc.1.append(newLevel) // false
          }
        }

        accMonkey[curMonkey.testTrue].items.append(contentsOf: newItems.0)
        accMonkey[curMonkey.testFalse].items.append(contentsOf: newItems.1)
        accMonkey[curMonkey.id].items = []

        inspectCount[curMonkey.id] += newItems.0.count + newItems.1.count
      }
    }

    return String(inspectCount.max(count: 2).reduce(1, *))
  }

  func partTwo() -> String {
    var inspectCount = Array(repeating: 0, count: monkeys.count)
    let leastCommonMultiplier = monkeys.reduce(into: 1) { acc, cur in
      acc = lcm(acc, cur.testDivisor)
    }

    let transform = { x in x % leastCommonMultiplier }

    for _ in 0..<10_000 {
      monkeys = monkeys.reduce(into: monkeys) { (accMonkey: inout [Monkey], curMonkey: Monkey) in

        let newItems = applyOperation(
          items: accMonkey[curMonkey.id].items,
          curMonkey.operatorIsAdd,
          curMonkey.operationUsingOld,
          curMonkey.operand
        ).reduce(into: ([Int](), [Int]())) { ( acc: inout ([Int], [Int]), cur: Int) in
          let newLevel = transform(cur)

          if isDivideTestTrue(item: newLevel, divisor: curMonkey.testDivisor) {
            acc.0.append(newLevel) // true
          } else{
            acc.1.append(newLevel) // false
          }
        }

        accMonkey[curMonkey.testTrue].items.append(contentsOf: newItems.0)
        accMonkey[curMonkey.testFalse].items.append(contentsOf: newItems.1)
        accMonkey[curMonkey.id].items = []

        inspectCount[curMonkey.id] += newItems.0.count + newItems.1.count
      }
    }

    return String(inspectCount.max(count: 2).reduce(1, *))
  }

  func isDivideTestTrue(item: Int, divisor: Int) -> Bool {
    return item % divisor == 0
  }

  func applyOperation(items: [Int], _ isAdd: Bool, _ isUsingOld: Bool, _ operand: Int) -> [Int] {
    items.map { item in
      let literal = isUsingOld ? item : operand
      return isAdd ? item + literal : item * literal
    }
  }

  func gcd(_ x: Int, _ y: Int) -> Int {
    var a = 0
    var b = max(x, y)
    var r = min(x, y)

    while r != 0 {
      a = b
      b = r
      r = a % b
    }
    return b
  }

  func lcm(_ x: Int, _ y: Int) -> Int {
    return x / gcd(x, y) * y
  }

  static func parseInput(_ inputStream: [String]) -> [Monkey] {
    let digitRegex = Regex {
      TryCapture {
        OneOrMore(.digit)
      } transform: { match in
        Int(match)
      }
    }

    let opRegex = Regex {
      "Operation: new = old"
      One(.whitespace)
      Capture {
        ChoiceOf {
          "+"
          "*"
        }
      }
      One(.whitespace)
      Capture {
        ChoiceOf {
          "old"
          OneOrMore(.digit)
        }
      }
    }

    return inputStream.chunks(ofCount: 6)
      .map { Array($0) }
      .map { description in
        guard let id = description[0].firstMatch(of: digitRegex),
              let operation = description[2].firstMatch(of: opRegex),
              let divisor = description[3].firstMatch(of: digitRegex),
              let trueMonkey = description[4].firstMatch(of: digitRegex),
              let falseMonkey = description[5].firstMatch(of: digitRegex) else { return nil }

        let items = description[1].matches(of: digitRegex)
        let `operator` = String(operation.1)
        let operand =  String(operation.2)

        let monkey = Monkey(
          id: id.1,
          items: items.map{ $0.1 },
          operationUsingOld: operand == "old",
          operatorIsAdd: `operator` == "+",
          operand: (operand == "old" ? 0 : Int(operand))!,
          testDivisor: divisor.1,
          testTrue: trueMonkey.1,
          testFalse: falseMonkey.1
        )
        return monkey
      }
      .compactMap { $0 }
  }
}
