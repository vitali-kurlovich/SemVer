//
//  Created by Vitali Kurlovich on 14.03.26.
//

import Foundation

public extension Version {
    func formatted<S>(_ style: S) -> S.FormatOutput where Self == S.FormatInput, S: FormatStyle {
        style.format(self)
    }
}

public extension Version {
    func formatted() -> String {
        formatted(.medium)
    }
}

public struct VersionFormatStyle: FormatStyle, Sendable {
    public typealias FormatInput = Version

    public typealias FormatOutput = String

    public let options: Options

    public init(options: Options) {
        self.options = options
    }

    public func format(_ version: Version) -> String {
        let converter = VersionString()
        return converter.string(core: options.contains(.coreVersion) ? version.core : nil,
                                prerelease: options.contains(.preRelease) ? version.prerelease : nil,
                                metadata: options.contains(.metadata) ? version.metadata : nil)
    }
}

public extension FormatStyle where FormatInput == Version, FormatOutput == String, Self == VersionFormatStyle {
    static var full: VersionFormatStyle {
        VersionFormatStyle(options: .full)
    }

    static var medium: VersionFormatStyle {
        VersionFormatStyle(options: .medium)
    }

    static var short: VersionFormatStyle {
        VersionFormatStyle(options: .short)
    }
}

public extension VersionFormatStyle {
    struct Options: OptionSet, Decodable, Encodable, Hashable, Sendable {
        public let rawValue: UInt8

        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
    }
}

public extension VersionFormatStyle.Options {
    static var coreVersion: Self { VersionFormatStyle.Options(rawValue: 1 << 0) }
    static var preRelease: Self { VersionFormatStyle.Options(rawValue: 1 << 1) }
    static var metadata: Self { VersionFormatStyle.Options(rawValue: 1 << 2) }

    static var full: Self { [.coreVersion, .preRelease, .metadata] }
    static var medium: Self { [.coreVersion, .preRelease] }
    static var short: Self { [.coreVersion] }
}
