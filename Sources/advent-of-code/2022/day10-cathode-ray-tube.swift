import Foundation
import Algorithms

typealias Step = (cycle: Int, value: Int)
typealias Row = (sprite: String, value: Int)

struct Day10Answer: DayAnswer {
  var result = [Step(cycle: 0, value: 1)]

  init(_ input: String) {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }

    self.result = inputStream.map { line in
      let splited = line.split(separator: " ")
      let op = OpCode(rawValue: String(splited[0]), value: Int(splited.last ?? "0") ?? 0)
      return op
    }
    .reduce(into: [Step(cycle: 0, value: 1)]) { acc, cur in
      guard let last = acc.last else { return }
      switch cur {
      case .noop:
        let current = Step(cycle: last.0 + 1, value: last.1)
        acc.append(current)
      case let .addx(value):
        let current = Step(cycle: last.0 + 2, value: last.1 + value)
        acc.append(current)
      default: break
      }
    }
  }

  func partOne() -> String {
    let signals = [20, 60, 100, 140, 180, 220]
    let t1 = signals.map { signal in
      result.last(where: { (cycle, value) in
        cycle < signal
      })
    }
    .compactMap { $0 }
    .map { $0.value }

    let answer = Array(zip(signals, t1)).map { ele in
      let s = ele.0
      let t = ele.1
      return s * t
    }.reduce(into: 0) { acc, cur in acc += cur }

    return String(answer)
  }

  func partTwo() -> String {
    let cycleValues = getValues(result)
    let screen = cycleValues.reduce(into: [""]) { acc, cur in
      guard var lastSprite = acc.last else { return }
      if [41, 81, 121, 161,201].contains(cur.cycle) {
        acc.append(lastSprite)
        acc.append("")
        lastSprite = ""
      } else {
        lastSprite += isBright(cycle: cur.cycle - 1, value: cur.value)
        var newAcc = acc
        newAcc[newAcc.count-1] = lastSprite
        acc = newAcc
      }
    }
    screen.forEach { print("\($0)") }

    return ""
  }
}

func getValues(_ steps: [Step]) -> [Step] {
	var result = [Step]()

	for i in (1...240) { 
		let value = steps.last(where: { (cycle, value) in
			cycle < i
		})
		let step = Step(cycle: i, value: value?.value ?? 0)
		result.append(step)
	}
	return result
}

func isBright(cycle: Int, value: Int) -> String {
	let c = cycle%40
	if c == (value - 1) || c == value || c == (value + 1) { 
		return "#"
	} else { return "." }
}

func moveSprite(distance: Int, amount: Int) -> Row {
	var output = ""
	if distance >= 0 {
		for i in 0 ..< distance { output += "." }
		if distance + 3 <= 40 {
			output += "###" 
			for i in 0..<(40 - distance - 3) { output += "." }
		} else {
			for i in 0..<(40 - distance) { output += "#" } 
		}
	} else {
		let absDis = -distance
		for i in 0..<absDis { output += "#" }
		for i in 0..<(40 - absDis) { output += "." }
	}

	return Row(sprite: output, value: amount)
}

enum OpCode {
	case noop
	case addx(Int)
	case unknown

	init?(rawValue: String, value: Int) {
		switch rawValue.lowercased() {
		case "noop": self = .noop
		case "addx": self = .addx(value)
		default: self = .unknown
		}
	}
}
