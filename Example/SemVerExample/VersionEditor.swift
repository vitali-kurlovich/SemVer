//
//  Created by Vitali Kurlovich on 18.03.26.
//

import SemanticVersioning
import SwiftUI

struct VersionEditor: View {
    @Binding
    var model: VersionModel

    typealias FormatOptions = VersionFormatStyle.Options

    @State var formatOptions: FormatOptions = [.coreVersion]

    @State
    var formatType: FormatType = .full

    @State
    var coreVersionExpanded = false

    @State
    var preReleaseExpanded = false

    @State
    var metadataExpanded = false

    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    if let version = model.version {
                        Text(version, format: formatStyle)

                        let attributed = model.transform(version.formatted(formatStyle.attributed)
                        )
                        Text(attributed)
                    }
                }.padding()
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle)
                    .background {
                        RoundedRectangle(cornerRadius: 12).fill(.thinMaterial)
                    }

                Section {
                    TextField(text: $model.inputText,
                              prompt: Text("Required"))
                    {
                        Text("Version")
                    }
                }
                Section("Format") {
                    VersionFormatPicker(type: $formatType)
                }
                Section {
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
            }
        }
    }
}

private extension VersionEditor {
    var formatStyle: VersionFormatStyle {
        debugPrint(formatType)

        switch formatType {
        case .full:
            return .full
        case .medium:
            return .medium
        case .short:
            return .short
        case let .custom(options):
            return VersionFormatStyle(options: options)
        }
    }
}

#Preview {
    @Previewable @State var model = VersionModel()
    VersionEditor(model: $model)
}
