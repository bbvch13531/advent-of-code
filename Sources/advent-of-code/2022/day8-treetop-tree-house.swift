import Foundation

struct Y2022Day8Answer: DayAnswer {
  let treeMap: [[Int]]
  let rowCount: Int
  let colCount: Int

  init(_ input: String) {
    let inputStream = input.components(separatedBy: .newlines).filter { $0.count != 0 }

    self.treeMap = buildTreeMap(input: inputStream)
    self.rowCount = treeMap.count
    self.colCount = treeMap[0].count
  }

  func partOne() -> String {
    var answer = 0
    treeMap.enumerated().forEach { row in
      row.element.enumerated().forEach { col in
        if isEdge(row: row.offset, col: col.offset, rowCnt: rowCount, colCnt: colCount) {
          answer += 1
        } else {
          if isVisible(row: row.offset, col: col.offset, treeMap: treeMap) {
            answer += 1
          }
        }
      }
    }
    return String(answer)
  }

  func partTwo() -> String {
    var max = -1
    treeMap.enumerated().forEach { row in
      row.element.enumerated().forEach { col in
        if !isEdge(row: row.offset, col: col.offset, rowCnt: rowCount, colCnt: colCount) {
          let score = scenicScore(row: row.offset, col: col.offset, treeMap: treeMap)
          if score > max {
            max = score
          }
        }
      }
    }

    return String(max)
  }

  func upTrees(_ row: Int, _ col: Int, _ treeMap: [[Int]]) -> [Int] {
    return treeMap[0..<row].map { row in
      row[col]
    }
  }
  
  func downTrees(_ row: Int, _ col: Int, _ treeMap: [[Int]]) -> [Int] {
    let rowCnt = treeMap.count
    return treeMap[row+1..<rowCnt].map { row in
      row[col]
    }
  }

  func rightTrees(_ row: Int, _ col: Int, _ treeMap: [[Int]]) -> [Int] {
    let colCnt = treeMap[0].count
    return Array(treeMap[row][col+1..<colCnt])
  }

  func leftTrees(_ row: Int, _ col: Int, _ treeMap: [[Int]]) -> [Int] {
    return Array(treeMap[row][0..<col])
  }

  func scenicScore(row: Int, col: Int, treeMap: [[Int]]) -> Int {
    let cur = treeMap[row][col]
    let res = [
      upTrees(row, col, treeMap).reversed(),
        downTrees(row, col, treeMap),
        rightTrees(row, col, treeMap),
        leftTrees(row, col, treeMap).reversed(),
      ].map { trees in
        if let offset = trees.firstIndex(where: { $0 >= cur }) {
          return offset + 1
        } else {
          return trees.count
        }
      }
      .reduce(into: 1, { acc, cur in
        acc *= cur
      })
    return res
  }

  func isVisible(row: Int, col: Int, treeMap: [[Int]]) -> Bool {
    let rowCnt = treeMap.count
    let colCnt = treeMap[0].count

    let cur = treeMap[row][col]
    let upTrees = treeMap[0..<row].map { row in
      row[col]
    }
    let downTrees = treeMap[row+1..<rowCnt].map { row in
      row[col]
    }
    let rightTrees = treeMap[row][col+1..<colCnt]
    let leftTrees = treeMap[row][0..<col]

    if let up = upTrees.max(),
       let down = downTrees.max(),
       let right = rightTrees.max(),
       let left = leftTrees.max() {
      if up < cur ||
          down < cur ||
          right < cur ||
          left < cur {
        return true
      }
    }
    return false
  }

  func isEdge(row: Int, col: Int, rowCnt: Int, colCnt: Int) -> Bool {
    if row == 0 || row == rowCnt - 1 || col == 0 || col == colCnt - 1 {
      return true
    }
    return false
  }
}

func buildTreeMap(input: [String]) -> [[Int]] {
  var treeMap = [[Int]]()

  input.forEach { line in
    var row = [Int]()
    line.forEach { tree in
      row.append(Int(String(tree)) ?? 0)
    }
    treeMap.append(row)
  }

  return treeMap
}
