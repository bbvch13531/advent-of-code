import Algorithms
import Foundation
import RegexBuilder

typealias Procedure = (n: Int, from: Int, to: Int)

final class Day5Answer: DayAnswer {
  var stacks: [Stack<Character>]
  let procedures: [Procedure]

  init(_ input: String) {
    let inputArr = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    let (stacks, procedures) = parseInput(inputArr)
    self.stacks = stacks
    self.procedures = procedures
  }

  func partOne() -> String {
    procedures.forEach { procedure in
      for _ in 0..<procedure.n {
        if let s = stacks[procedure.from - 1].pop() {
          stacks[procedure.to - 1].push(s)
        }
      }
    }

    let answer = stacks
      .compactMap { stack in
        stack.top()
      }
      .map { String($0) }
      .joined()

    return String(answer)
  }

  func partTwo() -> String {
    procedures.forEach { procedure in
      var tempStack = Stack<Character>()
      for _ in 0..<procedure.n {
        if let s = stacks[procedure.from - 1].pop() {
          tempStack.push(s)
        }
      }

      while !tempStack.isEmpty() {
        if let t = tempStack.pop() {
          stacks[procedure.to - 1].push(t)
        }
      }
    }
    let answer = stacks
      .compactMap { stack in
        stack.top()
      }
      .map { String($0) }
      .joined()

    return String(answer)
  }
}

struct Stack<T> {
  var items = [T]()

  init() { }

  init(items: [T]) {
    self.items = items
  }

  mutating func push(_ element: T) {
    self.items.append(element)
  }

  mutating func pop() -> T? {
    return self.items.removeLast()
  }

  func top() -> T? {
    return items.last
  }

  func isEmpty() -> Bool {
    return self.items.isEmpty
  }

  func reverse() -> Self {
    return Stack<T>(items: self.items.reversed())
  }

  func describe() {
    print("---Stack---")
    items.forEach { print($0) }
    print("-----------")
  }
}

private func parseInput(_ inputArr: [String]) -> ([Stack<Character>], [Procedure]) {
  let partitions = inputArr.chunked(on: { $0.contains("move") })
  let stacks = parseStack(Array(partitions[0].1))
  let procedures = parseProcedure(Array(partitions[1].1))

  return (stacks, procedures)
}

private func parseStack(_ rawInput: [String]) -> [Stack<Character>] {
  var inputStacks = [Stack<Character>]()
  rawInput.forEach { line in
    line.enumerated()
      .filter { ch in
        ch.offset % 4 == 1
      }
      .filter { ch in
        "A" <= ch.element && ch.element <= "Z"
      }
      .forEach { ch in
        let order = ch.offset / 4
        while inputStacks.count < order + 1 {
          inputStacks.append(Stack<Character>())
        }
        inputStacks[order].push(ch.element)
      }
  }
  let stacks = inputStacks.map { stack in
    stack.reverse()
  }
  return stacks
}

private func parseProcedure(_ rawInput: [String]) -> [Procedure] {
  let regex = Regex {
    "move"
    OneOrMore(.whitespace)

    TryCapture {
      OneOrMore(.digit)
    } transform: { match in
      Int(match)
    }
    OneOrMore(.whitespace)
    "from"
    OneOrMore(.whitespace)

    TryCapture {
      OneOrMore(.digit)
    } transform: { match in
      Int(match)
    }
    OneOrMore(.whitespace)
    "to"
    OneOrMore(.whitespace)

    TryCapture {
      OneOrMore(.digit)
    } transform: { match in
      Int(match)
    }
  }

  return rawInput.map { line in
    guard let match = line.wholeMatch(of: regex) else { return Procedure(-1, -1, -1) }
    return Procedure(n: match.1, from: match.2, to: match.3)
  }
}
