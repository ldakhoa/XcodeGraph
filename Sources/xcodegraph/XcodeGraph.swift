import Foundation
import ArgumentParser
import XcodeGraphKit
import Logging

@main
struct XcodeGraph: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "xcodegraph",
        abstract: "Dependencies Graph for the Xcode project",
        version: "1.0.0", 
        shouldDisplay: true,
        helpNames: [.long, .short]
    )

    @Option(help: "Xcode Project path.")
    var project: String

    mutating func run() throws {
        LoggingSystem.bootstrap()

        let runner = Runner(projectPath: project)
        runner.run()
    }
}
