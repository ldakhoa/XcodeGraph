import Foundation
import XcodeProj
import PathKit

struct ProjectGenerator {
    enum Error: Swift.Error {
        case missingProjectName
    }

    func generate(from xcodeProject: XcodeProj) throws -> XcodeProject {
        guard let name = xcodeProject.pbxproj.rootObject?.name else {
            throw Error.missingProjectName
        }
        let nativeTargets = xcodeProject.pbxproj.nativeTargets
        nativeTargets.forEach {
            print("Scanning target: \($0.name)")
            let deps = self.dependencies(from: $0.buildPhases)
            print(deps)
        }
        return XcodeProject(name: name, nativeTargets: [])
    }
}

extension ProjectGenerator {
    func dependencies(from buildPhases: [PBXBuildPhase]) -> [DependencyManager] {
        let dependencies: [DependencyManager] = buildPhases
            .first {
                guard let files = $0.files else { return false }
                return $0.buildPhase == .frameworks && !files.isEmpty
            }?.files?.compactMap { buildFile in
                guard
                    let file = buildFile.file,
                    let fileName = file.name,
                    let path = file.path
                else {
                    return nil
                }

                if file.sourceTree == .sdkRoot && path.hasPrefix("System/Library/") ||
                    file.sourceTree == .developerDir && path.hasPrefix("Platforms/") {
                    return DependencyManager(name: fileName, type: .nativeSDK)
                } else if path.hasPrefix("Carthage/") {
                    return DependencyManager(name: fileName, type: .carthage)
                } else if file.sourceTree != .sdkRoot {
                    return DependencyManager(name: fileName, type: .vendor)
                }

                return nil
            } ?? []
        return dependencies + podDependencies(from: buildPhases)
    }

    func podDependencies(from buildPhases: [PBXBuildPhase]) -> [DependencyManager] {
        let buildPhases: PBXShellScriptBuildPhase? = buildPhases.first {
            if let phase = $0 as? PBXShellScriptBuildPhase,
               let shellScript = phase.shellScript,
               shellScript.contains("PODS_ROOT"),
               !shellScript.contains("Manifest.lock") {
                return true
            }

            return false
        } as? PBXShellScriptBuildPhase

        guard let buildPhases else {
            return []
        }

        // ${TRAGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}/Name.framework
        let dependencies: [DependencyManager] = buildPhases.outputPaths.map {
            DependencyManager(
                name: Path($0).lastComponent,
                type: .pods
            )
        }
        return dependencies
    }
}
