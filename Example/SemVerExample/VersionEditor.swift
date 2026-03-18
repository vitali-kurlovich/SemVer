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
    var preReleaseExpanded = false

    @State
    var metadataExpanded = false

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

            SettingFormSheet(titleKey: "Core Version", isExpanded: $coreVersionExpanded) {
                CoreVersionEditor(model: $model)
            }

            SettingFormSheet(titleKey: "Pre-Release", isExpanded: $preReleaseExpanded) {
                PreReleaseEditor(model: $model)
            }

            SettingFormSheet(titleKey: "Metadata", isExpanded: $metadataExpanded) {
                MetadataEditor(model: $model)
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
