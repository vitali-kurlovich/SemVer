//
//  Created by Vitali Kurlovich on 15.03.26.
//

struct VersionString {
    init() {}

    typealias VersionCore = Version.VersionCore
}

extension VersionString {
    func string(from version: Version) -> String {
        string(core: version.core, prerelease: version.prerelease, metadata: version.metadata)
    }

    func string(core: VersionCore?, prerelease: PreRelease?, metadata: Metadata?) -> String {
        var string = ""
        if let core {
            string = self.string(from: core)
        }

        if let prerelease {
            if string.isEmpty {
                string.append("\(prerelease.value)")
            } else {
                string.append("-\(prerelease.value)")
            }
        }

        if let metadata {
            if string.isEmpty {
                string.append("\(metadata.value)")
            } else {
                string.append("+\(metadata.value)")
            }
        }

        return string
    }
}

extension VersionString {
    func string(from version: VersionCore) -> String {
        "\(version.major).\(version.minor).\(version.patch)"
    }
}

extension VersionString {
    func string(from release: PreRelease) -> String {
        String(release.value)
    }
}

extension VersionString {
    func string(from meta: Metadata) -> String {
        String(meta.value)
    }
}
