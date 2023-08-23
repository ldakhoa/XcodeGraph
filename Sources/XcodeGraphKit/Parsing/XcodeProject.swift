import Foundation

struct XcodeProject {
    let name: String
    let nativeTargets: [ProjectNativeTarget]
}

struct ProjectNativeTarget {
    let name: String
    let dependencies: [DependencyManager]
}

struct DependencyManager: Hashable {
    let name: String
    let type: DependencyManagerType
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
