//
//  Created by Vitali Kurlovich on 18.03.26.
//

import SemanticVersioning
import SwiftUI

struct CustomVersionFormatPicker: View {
    @Binding
    var formatOptions: FormatOptions

    var body: some View {
        HStack {
            Toggle("Version", isOn: .init(get: {
                formatOptions.contains(.coreVersion)
            }, set: { flag in
                if flag {
                    formatOptions.insert(.coreVersion)
                } else {
                    formatOptions.remove(.coreVersion)
                }
            }))

            Toggle("Pre-Release", isOn: .init(get: {
                formatOptions.contains(.preRelease)
            }, set: { flag in
                if flag {
                    formatOptions.insert(.preRelease)
                } else {
                    formatOptions.remove(.preRelease)
                }
            }))

            Toggle("Metadata", isOn: .init(get: {
                formatOptions.contains(.metadata)
            }, set: { flag in
                if flag {
                    formatOptions.insert(.metadata)
                } else {
                    formatOptions.remove(.metadata)
                }
            }))

        }.toggleStyle(.button)
    }
}

#Preview {
    @Previewable @State var formatOptions: FormatOptions = [.coreVersion]
    CustomVersionFormatPicker(formatOptions: $formatOptions)
}
