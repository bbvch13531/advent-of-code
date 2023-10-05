import Foundation
import RegexBuilder

struct Day15Answer: DayAnswer {
  struct Signal {
    let sensor: Point
    let beacon: Point
    let distance: Int
  }

  var signals = [Signal]()

  var distances = [Int]()
  var maxCol = 0
  let targetRow = 2000000

  init(_ input: String) {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }
    let signals = inputStream.map {
      let signal = parseInput($0)
      if signal.sensor.y > maxCol {
        maxCol = signal.sensor.y
      }
      if signal.beacon.y > maxCol {
        maxCol = signal.beacon.y
      }
      return signal
    }
    self.signals = signals
  }

  func partOne() -> String {
    let ranges = signals.compactMap { signal in
      signal.sensor.range(for: signal.distance, at: targetRow)
    }

    let combinedRanges = combineRanges(ranges)
    let count = combinedRanges.reduce(into: 0) { acc, cur in
      acc = cur.upperBound - cur.lowerBound - 1
    }
    let occupied =
    signals.map { $0.sensor }.filter { $0.x == targetRow } +
    signals.map { $0.beacon }.filter { $0.x == targetRow }

    return "\(count + Set(occupied).count)"
  }

  func partTwo() -> String {
    return ""
  }

  private func parseInput(_ input: String) -> Signal {
    let coordinateRegex = Regex {
      Capture {
        ZeroOrMore("-")
        OneOrMore(.digit)
      } transform: { Int($0)! }
    }

    let matches = input.matches(of: coordinateRegex)
    let arr = matches.map { $0.output.1 }

    let sensor = Point(arr[1], arr[0])
    let beacon = Point(arr[3], arr[2])
    let distance = sensor.manhattanDistance(to: beacon)
    return Signal(sensor: sensor, beacon: beacon, distance: distance)
  }


  private func combineRanges(_ ranges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
    var combined = [ClosedRange<Int>]()
    var accumulator = (0...0)

    for range in ranges.sorted(by: { $0.lowerBound  < $1.lowerBound  } ) {
      if accumulator == (0...0) {
        accumulator = range
      }

      if accumulator.upperBound >= range.upperBound {
        // already inside
        continue
      } else if accumulator.upperBound >= range.lowerBound  {
        // extend end
        accumulator = (accumulator.lowerBound...range.upperBound)
      } else if accumulator.upperBound <= range.lowerBound  {
        // no overlap
        combined.append(accumulator)
        accumulator = range
      }
    }

    if accumulator != (0...0) {
      combined.append(accumulator)
    }

    return combined
  }
}
