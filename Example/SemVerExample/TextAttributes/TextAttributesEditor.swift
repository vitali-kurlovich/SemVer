//
//  TextAttributesEditor.swift
//  swift-semver
//
//  Created by Vitali Kurlovich on 17.03.26.
//

import SwiftUI

struct TextAttributesEditor: View {
    let titleKey: LocalizedStringKey

    @Binding
    var isExpanded: Bool

    @Binding
    var textAttributes: TextAttributes

    init(_ titleKey: LocalizedStringKey, _ textAttributes: Binding<TextAttributes>, isExpanded: Binding<Bool>) {
        self.titleKey = titleKey
        _isExpanded = isExpanded
        _textAttributes = textAttributes
    }

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            TextAttributesPicker($textAttributes)
        } label: {
            Toggle(titleKey, isOn: $textAttributes.isEnabled)
        }
    }
}
