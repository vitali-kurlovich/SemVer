//
//  InlinePresentationIntentEditor.swift
//  swift-semver
//
//  Created by Vitali Kurlovich on 17.03.26.
//

import SwiftUI

struct InlinePresentationIntentEditor: View {
    @Binding
    var intent: InlinePresentationIntent

    init(_ intent: Binding<InlinePresentationIntent>) {
        _intent = intent
    }

    var body: some View {
        Toggle("Emphasized", isOn: .init(get: {
            intent.contains(.emphasized)
        }, set: { flag in
            if flag {
                intent.insert(.emphasized)
            } else {
                intent.remove(.emphasized)
            }
        }))

        Toggle("Strongly Emphasized", isOn: .init(get: {
            intent.contains(.stronglyEmphasized)
        }, set: { flag in
            if flag {
                intent.insert(.stronglyEmphasized)
            } else {
                intent.remove(.stronglyEmphasized)
            }
        }))

        Toggle("Code", isOn: .init(get: {
            intent.contains(.code)
        }, set: { flag in
            if flag {
                intent.insert(.code)
            } else {
                intent.remove(.code)
            }
        }))

        Toggle("Strikethrough", isOn: .init(get: {
            intent.contains(.strikethrough)
        }, set: { flag in
            if flag {
                intent.insert(.strikethrough)
            } else {
                intent.remove(.strikethrough)
            }
        }))

        Toggle("SoftBreak", isOn: .init(get: {
            intent.contains(.softBreak)
        }, set: { flag in
            if flag {
                intent.insert(.softBreak)
            } else {
                intent.remove(.softBreak)
            }
        }))

        Toggle("LineBreak", isOn: .init(get: {
            intent.contains(.lineBreak)
        }, set: { flag in
            if flag {
                intent.insert(.lineBreak)
            } else {
                intent.remove(.lineBreak)
            }
        }))

        Toggle("InlineHTML", isOn: .init(get: {
            intent.contains(.inlineHTML)
        }, set: { flag in
            if flag {
                intent.insert(.inlineHTML)
            } else {
                intent.remove(.inlineHTML)
            }
        }))

        Toggle("BlockHTML", isOn: .init(get: {
            intent.contains(.blockHTML)
        }, set: { flag in
            if flag {
                intent.insert(.blockHTML)
            } else {
                intent.remove(.blockHTML)
            }
        }))
    }
}

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
#Preview {
    @Previewable @State
    var intent: InlinePresentationIntent = []

    InlinePresentationIntentEditor($intent)
}
