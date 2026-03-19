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
            let (string, attributed) = model.formatted(format: format)

            Text(string)
            Text(attributed)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .font(.title)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.thinMaterial)
        }
    }
}

#Preview {
    @Previewable @State var model = VersionModel()
    @Previewable @State var format = VersionFormat()
    VersionPreview(model: $model, format: format)
}
