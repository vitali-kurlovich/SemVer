//
//  Created by Vitali Kurlovich on 16.03.26.
//

import SwiftUI

struct TextAttributesPicker: View {
    @Binding
    var textAttributes: TextAttributes

    @State
    var intentEditorExpanded = true

    init(_ textAttributes: Binding<TextAttributes>) {
        _textAttributes = textAttributes
    }

    var body: some View {
        Group {
            ColorPicker(selection: $textAttributes.forgroud.color) {
                Toggle("Text Color", isOn: $textAttributes.forgroud.isEnabled)
            }

            ColorPicker(selection: $textAttributes.backgroud.color) {
                Toggle("Background Color", isOn: $textAttributes.backgroud.isEnabled)
            }

            //  Toggle("InlinePresentation", isOn: $textAttributes.inlinePresentation.isEnabled.animation())

            //  intentEditorExpanded

            //  if textAttributes.inlinePresentation.isEnabled {
            // InlinePresentationIntentEditor($textAttributes.inlinePresentation.intent).padding(.leading)
            // }

            DisclosureGroup(isExpanded: $intentEditorExpanded) {
                InlinePresentationIntentEditor($textAttributes.inlinePresentation.intent).padding(.leading)
                    .disabled(!textAttributes.inlinePresentation.isEnabled)
            } label: {
                Toggle("InlinePresentation", isOn: $textAttributes.inlinePresentation.isEnabled)
            }

        }.disabled(!textAttributes.isEnabled)
    }
}

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
#Preview {
    @Previewable @State var textAttributes = TextAttributes()
    Form {
        Section {
            TextAttributesPicker($textAttributes)
        } header: {
            Toggle("isEnabled", isOn: $textAttributes.isEnabled)
        }
    }
}
