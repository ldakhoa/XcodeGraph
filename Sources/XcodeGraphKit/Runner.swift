import Foundation

public struct Runner {
    private let projectPath: String

    public init(projectPath: String) {
        self.projectPath = projectPath
    }

    public func run() {
        logger.info("Scanning...")
    }
}
