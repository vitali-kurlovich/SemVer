//
//  Created by Vitali Kurlovich on 15.03.26.
//

import Foundation

struct VersionAttributedString {
    init() {}

    typealias VersionCore = Version.VersionCore
    typealias PreRelease = Version.PreRelease
}

extension VersionAttributedString {
    typealias SemanticVersionAttribute = AttributeScopes.SemanticVersioningAttributes.SemanticVersionAttribute

    typealias CoreVersionPartAttribute = AttributeScopes.SemanticVersioningAttributes.CoreVersionPartAttribute

    typealias PreReleasePartAttribute = AttributeScopes.SemanticVersioningAttributes.PreReleasePartAttribute
    typealias MetadataPartAttribute = AttributeScopes.SemanticVersioningAttributes.MetadataPartAttribute
}

extension VersionAttributedString {
    func string(from version: Version) -> AttributedString {
        string(core: version.core, prerelease: version.prerelease, metadata: version.metadata)
    }

    func string(core: VersionCore?, prerelease: PreRelease?, metadata: Metadata?) -> AttributedString {
        var string = AttributedString("")
        var isEmpty = true
        if let core {
            string = self.string(from: core)
            isEmpty = false
        }

        if let prerelease {
            string.append(self.string(from: prerelease, includeSeparator: !isEmpty))
            isEmpty = false
        }

        if let metadata {
            string.append(self.string(from: metadata, includeSeparator: !isEmpty))
            isEmpty = false
        }

        var attributes = AttributeContainer()

        attributes[SemanticVersionAttribute.self] = .semanticVersion
        string.mergeAttributes(attributes)

        return string
    }
}

extension VersionAttributedString {
    func string(from version: VersionCore) -> AttributedString {
        let separator = coreGroupSeparator

        return major(from: version) + separator +
            minor(from: version) + separator +
            patch(from: version)
    }
}

private extension VersionAttributedString {
    var coreGroupSeparator: AttributedString {
        var attributes = AttributeContainer()
        attributes[CoreVersionPartAttribute.self] = .groupSeparator
        return AttributedString(".", attributes: attributes)
    }

    var preReleaseSeparator: AttributedString {
        var attributes = AttributeContainer()
        attributes[PreReleasePartAttribute.self] = .groupSeparator
        return AttributedString("-", attributes: attributes)
    }

    var metadataSeparator: AttributedString {
        var attributes = AttributeContainer()
        attributes[MetadataPartAttribute.self] = .groupSeparator
        return AttributedString("+", attributes: attributes)
    }
}

private extension VersionAttributedString {
    func major(from version: VersionCore) -> AttributedString {
        var attributes = AttributeContainer()
        attributes[CoreVersionPartAttribute.self] = .major

        return AttributedString("\(version.major)",
                                attributes: attributes)
    }

    func minor(from version: VersionCore) -> AttributedString {
        var attributes = AttributeContainer()
        attributes[CoreVersionPartAttribute.self] = .minor

        return AttributedString("\(version.minor)",
                                attributes: attributes)
    }

    func patch(from version: VersionCore) -> AttributedString {
        var attributes = AttributeContainer()
        attributes[CoreVersionPartAttribute.self] = .patch

        return AttributedString("\(version.patch)",
                                attributes: attributes)
    }
}

extension VersionAttributedString {
    func string(from release: PreRelease, includeSeparator: Bool) -> AttributedString {
        var attributes = AttributeContainer()
        attributes[PreReleasePartAttribute.self] = .preRelease

        let string = AttributedString(release.value, attributes: attributes)

        if includeSeparator {
            return preReleaseSeparator + string
        }

        return string
    }
}

extension VersionAttributedString {
    func string(from meta: Metadata, includeSeparator: Bool) -> AttributedString {
        var attributes = AttributeContainer()
        attributes[MetadataPartAttribute.self] = .metadata

        let string = AttributedString(meta.value, attributes: attributes)

        if includeSeparator {
            return metadataSeparator + string
        }

        return string
    }
}
