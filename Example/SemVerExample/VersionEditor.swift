//
//  Created by Vitali Kurlovich on 16.03.26.
//

import SemanticVersioning
import SwiftUI

struct VersionEditor: View {
    @Binding
    var model: VersionModel

    @State
    var coreVersionExpanded = false

    @State
    var majorExpanded = false
    @State
    var minorExpanded = false
    @State
    var patchExpanded = false
    @State
    var coreVersionSeparatorExpanded = false

    @State
    var preReleaseExpanded = false
    @State
    var preReleaseTextExpanded = false
    @State
    var preReleaseSeparatorExpanded = false

    @State
    var metadataExpanded = false
    @State
    var metadataTextExpanded = false
    @State
    var metadataSeparatorExpanded = false

    var body: some View {
        Form {
            Section {
                TextField("Version", text: $model.inputText)
            }

            if let version = model.version {
                Section("Format") {
                    LabeledContent(".full", value: version, format: .full)
                    LabeledContent(".medium", value: version, format: .medium)
                    LabeledContent(".short", value: version, format: .short)
                }

                Section("Attributed") {
                    LabeledContent(".full") {
                        Text(model.transform(version.formatted(.full.attributed)))
                    }

                    LabeledContent(".medium") {
                        Text(model.transform(version.formatted(.medium.attributed)))
                    }

                    LabeledContent(".short") {
                        Text(model.transform(version.formatted(.short.attributed)))
                    }
                }

            } else {
                Text("Incorrect format")
            }

            DisclosureGroup("Core Version", isExpanded: $coreVersionExpanded) {
                TextAttributesPicker($model.coreVersion)

                TextAttributesEditor("Major", $model.major, isExpanded: $majorExpanded)

                TextAttributesEditor("Minor", $model.minor, isExpanded: $minorExpanded)

                TextAttributesEditor("Patch", $model.patch, isExpanded: $patchExpanded)

                TextAttributesEditor("Group Separator",
                                     $model.coreVersionSeparator,
                                     isExpanded: $coreVersionSeparatorExpanded)
            }

            DisclosureGroup("Pre-Release", isExpanded: $preReleaseExpanded) {
                TextAttributesPicker($model.preRelease)

                TextAttributesEditor("Pre-Release",
                                     $model.preReleaseText,
                                     isExpanded: $preReleaseTextExpanded)

                TextAttributesEditor("Group Separator",
                                     $model.preReleaseSeparator,
                                     isExpanded: $preReleaseSeparatorExpanded)
            }

            DisclosureGroup("Metadata", isExpanded: $metadataExpanded) {
                TextAttributesPicker($model.metadata)

                TextAttributesEditor("Metadata",
                                     $model.metadataText,
                                     isExpanded: $metadataTextExpanded)

                TextAttributesEditor("Group Separator",
                                     $model.metadataSeparator,
                                     isExpanded: $metadataSeparatorExpanded)
            }
        }
        .labeledContentStyle(LabeledVersionStyle())
    }
}

struct LabeledVersionStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            configuration.content.font(.headline.bold())
        }
    }
}

#Preview {
    @Previewable @State var model = VersionModel()
    VersionEditor(model: $model)
}
