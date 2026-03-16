//
//  Created by Vitali Kurlovich on 15.03.26.
//

import Foundation

public extension VersionFormatStyle {
    /// An attributed format style based on the ``VersionFormatStyle``
    ///
    /// Use this modifier to create a ``VersionFormatStyle/Attributed`` instance, which formats values as AttributedString instances. These attributed strings contain attributes from the ``Foundation/AttributeScopes/SemanticVersioningAttributes`` attribute scope. Use these attributes to determine which runs of the attributed string represent different parts of the formatted value.
    ///
    /// The following example finds runs of the attributed string that represent different parts of a formatted ``Version``, and adds additional attributes like foregroundColor and inlinePresentationIntent.
    ///
    /**
     ```swift
     func attributedVersion(_ version: Version) -> AttributedString {
         var string = version.formatted(.full.attributed)

         for run in string.runs {
             if let part = run.semanticVersioning.versionPart {
                 string[run.range].inlinePresentationIntent = .stronglyEmphasized

                 switch part {
                 case .major:
                     string[run.range].foregroundColor = Color.red
                 case .minor:
                     string[run.range].foregroundColor = Color.green
                 case .patch:
                     string[run.range].foregroundColor = Color.blue
                 case .groupSeparator:
                     string[run.range].foregroundColor = Color.indigo
                 }
             }

             if let part = run.semanticVersioning.preReleasePart {
                 switch part {
                 case .preRelease:
                     string[run.range].foregroundColor = Color.purple
                 case .groupSeparator:
                     string[run.range].foregroundColor = Color.purple.opacity(0.5)
                 }
             }

             if let part = run.semanticVersioning.metadataPart {
                 switch part {
                 case .metadata:
                     string[run.range].foregroundColor = Color.indigo
                 case .groupSeparator:
                     string[run.range].foregroundColor = Color.indigo.opacity(0.5)
                 }
             }
         }

         return string
     }
     ```
     */

    var attributed: Attributed {
        Attributed(options: options)
    }

    /// FormatStyle for formatting ``Version`` into the  AttributedString
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
