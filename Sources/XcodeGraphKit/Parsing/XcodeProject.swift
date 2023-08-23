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
    let type: DependencyModuleType

    init(name: String, type: DependencyModuleType) {
        self.name = name
        self.type = type
    }
    
    var id: String {
        name
    }
}

extension DependencyManager {
    enum DependencyModuleType {
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
