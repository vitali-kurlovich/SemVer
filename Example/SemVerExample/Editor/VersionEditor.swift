//
//  Created by Vitali Kurlovich on 18.03.26.
//

import SwiftUI

struct VersionEditor: View {
    @Binding
    var model: VersionModel

    @State var format = VersionFormat()

    #if os(macOS)
        @State var isInspectorPresented: Bool = true
    #endif
    var body: some View {
        NavigationStack {
            VStack {
                VersionPreview(model: $model, format: format)

                Form {
                    Section {
                        TextField(text: $model.inputText,
                                  prompt: Text("Text in the Semantic Versioning format"))
                        {
                            Text("Version")
                        }
                    }
                    Section {
                        VersionFormatPicker(format: $format)
                    }
                    #if os(iOS)
                        Section {
                            VersionSettings(model: $model)
                        }
                    #endif
                }
                Spacer()
            }
        }
        #if os(macOS)
        .inspector(isPresented: $isInspectorPresented) {
            NavigationStack {
                Form {
                    VersionSettings(model: $model)
                }
            }
        }
        #endif
    }
}

#Preview {
    @Previewable @State var model = VersionModel()
    VersionEditor(model: $model)
}
