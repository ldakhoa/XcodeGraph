import Foundation

struct XcodeProject {
    let name: String
    let nativeTargets: [ProjectNativeTarget]
}

struct ProjectNativeTarget {
    let name: String
    let dependencies: [DependencyManager]
}

struct DependencyManager: Hashable, Identifiable {
    let name: String
    let type: DependencyManagerType

    init(name: String, type: DependencyManagerType) {
        self.name = name
        self.type = type
    }
    
    var id: String {
        name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: DependencyManager, rhs: DependencyManager) -> Bool {
        return lhs.id == rhs.id
    }
}

extension DependencyManager {
    enum DependencyManagerType {
        /// Apple platform SDK.
        ///
        /// For instances: Foundation, AVFoundation, UIKit...
        case nativeSDK

        /// Swift Package Manager.
        case swiftPackage

        /// CocoaPods.
        case pods

        /// Carthage.
        case carthage

        /// External vendor.
        case vendor
    }
}
