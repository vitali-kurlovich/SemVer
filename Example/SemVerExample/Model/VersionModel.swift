//
//  Created by Vitali Kurlovich on 16.03.26.
//

import SemanticVersioning
import SwiftUI

@Observable
final class VersionModel {
    var inputText: String = "Version: 1.2.3-rc.1+demo"

    var coreVersion = TextAttributes(backgroud: ColorAttribute(color: .indigo, isEnabled: false))

    var major = TextAttributes(forgroud: ColorAttribute(color: .red))
    var minor = TextAttributes(forgroud: ColorAttribute(color: .green))
    var patch = TextAttributes(forgroud: ColorAttribute(color: .blue))
    var coreVersionSeparator = TextAttributes(forgroud: ColorAttribute(color: .accentColor))

    var preRelease = TextAttributes(forgroud: ColorAttribute(color: .pink))
    var preReleaseText = TextAttributes(isEnabled: false)
    var preReleaseSeparator = TextAttributes(isEnabled: false)

    var metadata = TextAttributes(forgroud: ColorAttribute(color: .purple))
    var metadataText = TextAttributes(isEnabled: false)
    var metadataSeparator = TextAttributes(isEnabled: false)
}

extension VersionModel {
    func formatted(format: VersionFormat) -> (String, AttributedString) {
        let detector = VersionDetector()

        let string = inputText

        var startIndex = string.startIndex
        let endIndex = string.endIndex

        var result = ""

        var attrResult = AttributedString()

        let matches = detector.matches(in: string)

        for match in matches {
            let range = startIndex ..< match.range.lowerBound
            result.append(String(string[range]))
            attrResult.append(AttributedString(string[range]))

            result.append(match.version.formatted(format.style))
            attrResult.append(match.version.formatted(format.style.attributed))

            startIndex = match.range.upperBound
        }

        let range = startIndex ..< endIndex

        result.append(String(string[range]))
        attrResult.append(AttributedString(string[range]))

        return (result, transform(attrResult))
    }
}

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
