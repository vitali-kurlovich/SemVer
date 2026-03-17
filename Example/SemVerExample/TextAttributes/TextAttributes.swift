//
//  TextAttributes.swift
//  swift-semver
//
//  Created by Vitali Kurlovich on 16.03.26.
//

import SwiftUI

struct TextAttributes: Equatable {
    var forgroud = ColorAttribute(color: .primary)
    var backgroud = ColorAttribute(color: .white, isEnabled: false)
    var inlinePresentation = InlinePresentationIntentAttribute(intent: [], isEnabled: false)
    var isEnabled: Bool = true
}

struct ColorAttribute: Hashable {
    var color: Color = .primary
    var isEnabled: Bool = true
}

struct InlinePresentationIntentAttribute: Equatable {
    var intent: InlinePresentationIntent = []

    var isEnabled = false
}
