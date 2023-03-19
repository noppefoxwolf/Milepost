import Foundation

enum CommandError: LocalizedError {
    case invalidArguments
}

func run() throws {
    print(#function, #line)
    let arguments = ProcessInfo().arguments
    print(#function, #line)
    guard arguments.count == 3 else {
        throw CommandError.invalidArguments
    }
    print(#function, #line)
    let repositoryPath: URL = .init(fileURLWithPath: arguments[1])
    let gitExecutable: URL = .init(fileURLWithPath: "/usr/bin/git")
    let fetcher = Fetcher(repositoryPath: repositoryPath, gitExecutablePath: gitExecutable)
    let revision = try fetcher.parse()
    print(#function, #line)
    let outputPath = URL(fileURLWithPath: arguments[2])
    let generator = PlistGenerator(outputPath: outputPath)
    try generator.generate(revision)
    print(#function, #line)
}

do {
    try run()
    exit(0)
} catch {
    exit(1)
}
