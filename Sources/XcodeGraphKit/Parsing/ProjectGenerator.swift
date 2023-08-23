import Foundation
import XcodeProj

struct ProjectGenerator {
    enum Error: Swift.Error {
        case missingProjectName
    }

    func generate(from xcodeProject: XcodeProj) throws -> XcodeProject {
        guard let name = xcodeProject.pbxproj.rootObject?.name else {
            throw Error.missingProjectName
        }
        return XcodeProject(name: name, nativeTargets: [])
    }
}
