//
//  VersionModel.swift
//  swift-semver
//
//  Created by Vitali Kurlovich on 16.03.26.
//

import SemanticVersioning
import SwiftUI

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
@Observable
final class VersionModel {
    var inputText: String = "1.2.3-rc.1+demo"

    var coreVersion = TextAttributes(backgroud: ColorAttribute(color: .indigo))

    var major = TextAttributes(forgroud: ColorAttribute(color: .red))
    var minor = TextAttributes(forgroud: ColorAttribute(color: .green))
    var patch = TextAttributes(forgroud: ColorAttribute(color: .blue))
    var coreVersionSeparator = TextAttributes(forgroud: ColorAttribute(color: .accentColor))

    var preRelease = TextAttributes()
    var preReleaseText = TextAttributes()
    var preReleaseSeparator = TextAttributes()

    var metadata = TextAttributes()
    var metadataText = TextAttributes()
    var metadataSeparator = TextAttributes()
}

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
extension VersionModel {
    var version: Version? {
        try? Version(inputText)
    }
}

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
extension VersionModel {
    func apply(_ attr: TextAttributes, string: inout AttributedSubstring) {
        guard attr.isEnabled else { return }

        if attr.forgroud.isEnabled {
            string.foregroundColor = attr.forgroud.color
        }

        if attr.backgroud.isEnabled {
            string.backgroundColor = attr.backgroud.color
        }

        if attr.inlinePresentation.isEnabled {
            string.inlinePresentationIntent = attr.inlinePresentation.intent
        }
    }

    func transform(_ string: AttributedString) -> AttributedString {
        var string = string

        for run in string.runs {
            if let part = run.semanticVersioning.versionPart {
                apply(coreVersion, string: &string[run.range])

                switch part {
                case .major:
                    apply(major, string: &string[run.range])
                case .minor:
                    apply(minor, string: &string[run.range])
                case .patch:
                    apply(patch, string: &string[run.range])
                case .groupSeparator:
                    apply(coreVersionSeparator, string: &string[run.range])
                }
            }

            if let part = run.semanticVersioning.preReleasePart {
                apply(preRelease, string: &string[run.range])

                switch part {
                case .preRelease:
                    apply(preReleaseText, string: &string[run.range])
                case .groupSeparator:
                    apply(preReleaseSeparator, string: &string[run.range])
                }
            }

            if let part = run.semanticVersioning.metadataPart {
                apply(metadata, string: &string[run.range])

                switch part {
                case .metadata:
                    apply(metadataText, string: &string[run.range])
                case .groupSeparator:
                    apply(metadataSeparator, string: &string[run.range])
                }
            }
        }

        return string
    }
}
