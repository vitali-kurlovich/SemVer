//
//  Created by Vitali Kurlovich on 18.03.26.
//

import SemanticVersioning
import SwiftUI

typealias FormatOptions = VersionFormatStyle.Options

enum FormatType: Sendable, Hashable {
    case full
    case medium
    case short
    case custom(FormatOptions)
}

struct VersionFormatPicker: View {
    @Binding
    var type: FormatType

    @State
    private var formatOptions: FormatOptions = [.coreVersion]

    var body: some View {
        VStack {
            Picker("Format", selection: .init(get: {
                InternalFormatType(type)
            }, set: { type in
                self.type = convert(type)
            })) {
                Text("Full").tag(InternalFormatType.full)
                Text("Medium").tag(InternalFormatType.medium)
                Text("Short").tag(InternalFormatType.short)
                Text("Custom").tag(InternalFormatType.custom)
            }
            .pickerStyle(.segmented)

            if displayCustomVersionPicker {
                CustomVersionFormatPicker(formatOptions: $formatOptions)
            }
        }
    }
}

private extension VersionFormatPicker {
    enum InternalFormatType {
        case full
        case medium
        case short
        case custom

        init(_ type: FormatType) {
            switch type {
            case .full:
                self = .full
            case .medium:
                self = .medium
            case .short:
                self = .short
            case .custom:
                self = .custom
            }
        }
    }

    func convert(_ type: InternalFormatType) -> FormatType {
        switch type {
        case .full:
            return .full
        case .medium:
            return .medium
        case .short:
            return .short
        case .custom:
            return .custom(formatOptions)
        }
    }
}

extension VersionFormatPicker {
    var displayCustomVersionPicker: Bool {
        switch type {
        case .full, .medium, .short:
            return false

        case .custom:
            return true
        }
    }
}

#Preview {
    @Previewable @State var formatType: FormatType = .full
    VersionFormatPicker(type: $formatType)
}
