//
//  Created by Vitali Kurlovich on 15.03.26.
//

import Foundation

public extension VersionFormatStyle {
    var attributed: Attributed {
        Attributed(options: options)
    }

    struct Attributed: FormatStyle, Sendable {
        public typealias Options = VersionFormatStyle.Options

        public typealias FormatInput = Version

        public typealias FormatOutput = AttributedString

        public let options: Options

        public init(options: Options) {
            self.options = options
        }

        public func format(_ version: Version) -> AttributedString {
            let converter = VersionAttributedString()
            return converter.string(core: options.contains(.coreVersion) ? version.core : nil,
                                    prerelease: options.contains(.preRelease) ? version.prerelease : nil,
                                    metadata: options.contains(.metadata) ? version.metadata : nil)
        }
    }
}
