//
//  Created by Vitali Kurlovich on 18.03.26.
//

import SemanticVersioning
import SwiftUI

struct CustomVersionFormatPicker: View {
    typealias Options = VersionFormatStyle.Options

    @Binding
    var options: Options

    var body: some View {
        HStack {
            Toggle("Version", isOn: .init(get: {
                options.contains(.coreVersion)
            }, set: { flag in
                if flag {
                    options.insert(.coreVersion)
                } else {
                    options.remove(.coreVersion)
                }
            }))

            Toggle("Pre-Release", isOn: .init(get: {
                options.contains(.preRelease)
            }, set: { flag in
                if flag {
                    options.insert(.preRelease)
                } else {
                    options.remove(.preRelease)
                }
            }))

            Toggle("Metadata", isOn: .init(get: {
                options.contains(.metadata)
            }, set: { flag in
                if flag {
                    options.insert(.metadata)
                } else {
                    options.remove(.metadata)
                }
            }))

        }.toggleStyle(.button)
    }
}

#Preview {
    @Previewable @State var options: VersionFormatStyle.Options = [.coreVersion]
    CustomVersionFormatPicker(options: $options)
}
