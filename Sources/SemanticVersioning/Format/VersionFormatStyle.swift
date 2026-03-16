//
//  Created by Vitali Kurlovich on 14.03.26.
//

import Foundation

public extension Version {
    /// Format ``Version`` using style
    func formatted<S>(_ style: S) -> S.FormatOutput where Self == S.FormatInput, S: FormatStyle {
        style.format(self)
    }
}

public extension Version {
    /// Format ``Version`` using  ``Foundation/FormatStyle/medium`` style
    func formatted() -> String {
        formatted(.medium)
    }
}

/// ``Foundation/FormatStyle`` for formatting ``Version`` into the `String`
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
    /**
     ``VersionFormatStyle`` for displaying core-version, pre-release, and metadata

     ```swift
     let version = try Version("1.2.3-alpha.1+meta")
     version.formatted(.full)
     // "1.2.3-alpha.1+meta"
     ```
     */
    static var full: VersionFormatStyle {
        VersionFormatStyle(options: .full)
    }

    /**
     ``VersionFormatStyle`` for displaying core-version, and  pre-release

     ```swift
     let version = try Version("1.2.3-alpha.1+meta")
     version.formatted(.medium)
     // "1.2.3-alpha.1"
     ```
     */
    static var medium: VersionFormatStyle {
        VersionFormatStyle(options: .medium)
    }

    /**
     ``VersionFormatStyle`` for displaying core-version only

     ```swift
     let version = try Version("1.2.3-alpha.1+meta")
     version.formatted(.medium)
     // "1.2.3"
     ```
     */
    static var short: VersionFormatStyle {
        VersionFormatStyle(options: .short)
    }
}

public extension VersionFormatStyle {
    /// Define which part of the version string is displayed at formatting
    struct Options: OptionSet, Codable, Hashable, Sendable {
        public let rawValue: UInt8

        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
    }
}

public extension VersionFormatStyle.Options {
    /// Display core-version
    static var coreVersion: Self { VersionFormatStyle.Options(rawValue: 1 << 0) }
    /// Display pre-release
    static var preRelease: Self { VersionFormatStyle.Options(rawValue: 1 << 1) }
    /// Display metadata
    static var metadata: Self { VersionFormatStyle.Options(rawValue: 1 << 2) }

    /// Display core-version, pre-release, and metadata
    static var full: Self { [.coreVersion, .preRelease, .metadata] }

    /// Display core-version, and  pre-release
    static var medium: Self { [.coreVersion, .preRelease] }
    /// Display core-version only
    static var short: Self { [.coreVersion] }
}
