//
//  Created by Vitali Kurlovich on 18.03.26.
//

import SwiftUI

struct VersionFormatPicker: View {
    typealias FormatType = VersionFormat.FormatType

    @Binding
    var format: VersionFormat

    var body: some View {
        VStack {
            Picker("Format Style", selection: $format.type) {
                Text("Full").tag(FormatType.full)
                Text("Medium").tag(FormatType.medium)
                Text("Short").tag(FormatType.short)
                Text("Custom").tag(FormatType.custom)
            }
            .pickerStyle(.segmented)

            if displayCustomVersionPicker {
                CustomVersionFormatPicker(options: $format.options)
            }
        }
    }
}

extension VersionFormatPicker {
    var displayCustomVersionPicker: Bool {
        switch format.type {
        case .full, .medium, .short:
            return false

        case .custom:
            return true
        }
    }
}

#Preview {
    @Previewable @State var formatType = VersionFormat()
    VersionFormatPicker(format: $formatType)
}
