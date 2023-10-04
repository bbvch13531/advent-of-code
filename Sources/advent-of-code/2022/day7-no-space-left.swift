import Algorithms
import Foundation
import RegexBuilder

class Day7Answer: DayAnswer {
  let root: Directory
  var queue: [Directory]
  var dirSizes = [Int]()

  required init(_ input: String) {
    let inputStream = input.components(separatedBy: .newlines)

    self.root = Day7Answer.buildDirectory(input: inputStream)
    self.queue = [Directory](arrayLiteral: root)
  }

  func partOne() -> String {
    while(!queue.isEmpty) {
      let cur = queue.removeFirst()
      dirSizes.append(cur.totalSize())
      queue.append(contentsOf: cur.subDirectories)
    }

    let answer = dirSizes
      .filter { size in
        size < 100_000
      }
      .reduce(into: 0, { acc, cur in acc += cur })

    return String(answer)
  }

  func partTwo() -> String {
    while(!queue.isEmpty) {
      let cur = queue.removeFirst()
      dirSizes.append(cur.totalSize())
      queue.append(contentsOf: cur.subDirectories)
    }
    let diskLimit = 70_000_000
    let minimumFreeSpace = 30_000_000
    let threshold = minimumFreeSpace - (diskLimit - root.totalSize())

    let answer = dirSizes
      .reduce(0) {
        if $0 > threshold && $1 > threshold {
          return min($0, $1)
        } else {
          return max($0, $1)
        }
      }
    return String(answer)
  }

  static func buildDirectory(input: [String]) -> Directory {
    let cmdRegex = Regex {
      "$"
      One(.whitespace)
      TryCapture {
        OneOrMore(.word)
      } transform: { match in
        String(match)
      }
      ZeroOrMore(.whitespace)
      TryCapture {
        ZeroOrMore(.any)
      } transform: { match in
        String(match)
      }
    }
    let dirRegex = Regex {
      "dir"
      One(.whitespace)
      TryCapture {
        OneOrMore(.anyNonNewline)
      } transform: { match in
        String(match)
      }
    }
    let fileRegex = Regex {
      TryCapture {
        OneOrMore(.digit)
      } transform: { match in
        Int(match)
      }
      One(.whitespace)
      TryCapture {
        OneOrMore(.anyNonNewline)
      } transform: { match in
        String(match)
      }
    }
    
    var dirHistory = [Directory]()
    let root = Directory(name: "/")
    var currentDir = root

    dirHistory.append(currentDir)

    input.forEach { line in
      if let cmdMatch = line.wholeMatch(of: cmdRegex) {
        let cmd = cmdMatch.1

        // change current dir
        if cmd == "cd" {
          let dir = cmdMatch.2
          if dir == ".." {
            dirHistory.removeLast()
            currentDir = dirHistory.last ?? Directory(name: "none")
          } else {
            if dir != "/" {
              currentDir = currentDir.subDirectories.first(where: { $0.name == dir }) ?? Directory(name: "none")
              dirHistory.append(currentDir)
            }
          }
        } else if cmd == "ls" {
        }
      } else if let dirMatch = line.wholeMatch(of: dirRegex) {
        let dir = dirMatch.1
        currentDir.addDir(dir: Directory(name: dir))
      } else if let fileMatch = line.wholeMatch(of: fileRegex) {
        currentDir.addFile(file: File(name: fileMatch.2, size: fileMatch.1))
      }
    }
    return root
  }
}

class File {
  let name: String
  let size: Int

  public init(name: String, size: Int) {
    self.name = name
    self.size = size
  }
}

class Directory {
  var name: String
  var subDirectories = [Directory]()
  var files = [File]()

  public init(name: String, subDirectories: [Directory] = [Directory](), files: [File] = [File]()) {
    self.name = name
    self.subDirectories = subDirectories
    self.files = files
  }

  func addDir(dir: Directory) {
    subDirectories.append(dir)
  }

  func addFile(file: File) {
    files.append(file)
  }

  func fileSize() -> Int {
    return files.reduce(into: 0, { acc, cur in
      acc += cur.size
    })
  }

  func totalSize() -> Int {
    let subDirSizes = self.subDirectories.reduce(into: 0, { acc, cur in acc += cur.totalSize() })
    return self.fileSize() + subDirSizes
  }
}
