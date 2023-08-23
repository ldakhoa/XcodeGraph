import Foundation
import XcodeProj
import PathKit

public struct Runner {
    private let projectPath: String
    private let targets: [String]

    public init(
        projectPath: String,
        targets: [String]
    ) {
        self.projectPath = projectPath
        self.targets = targets
    }

    public func run() {
        logger.info("Scanning...")
        do {
            let generator = ProjectGenerator()

            let xcodeProj = try XcodeProj(path: Path(projectPath))

            try generator.generate(from: xcodeProj)
        } catch {
            logger.error(error.localizedDescription)
        }
    }
}
