//
//  Created by Vitali Kurlovich on 19.03.26.
//

import SemanticVersioning
import SwiftUI

struct VersionPreview: View {
    @Binding
    var model: VersionModel

    let format: VersionFormat

    var body: some View {
        VStack {
            if let version = model.version {
                Text(version, format: formatStyle)

                let attributed = model.transform(version.formatted(formatStyle.attributed)
                )
                Text(attributed)
            } else {
                Text("Invalid format")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .font(.largeTitle)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.thinMaterial)
        }
    }
}

private extension VersionPreview {
    var formatStyle: VersionFormatStyle {
        switch format.type {
        case .full:
            return .full
        case .medium:
            return .medium
        case .short:
            return .short
        case .custom:
            return VersionFormatStyle(options: format.options)
        }
    }
}

#Preview {
    @Previewable @State var model = VersionModel()
    @Previewable @State var format = VersionFormat()
    VersionPreview(model: $model, format: format)
}
