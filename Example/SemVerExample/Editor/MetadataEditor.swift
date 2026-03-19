//
//  Created by Vitali Kurlovich on 17.03.26.
//

import SwiftUI

struct MetadataEditor: View {
    @Binding
    var model: VersionModel

    @State
    var metadataTextExpanded = false
    @State
    var metadataSeparatorExpanded = false

    var body: some View {
        TextAttributesPicker($model.metadata)

        TextAttributesEditor("Metadata",
                             $model.metadataText,
                             isExpanded: $metadataTextExpanded)

        TextAttributesEditor("Group Separator",
                             $model.metadataSeparator,
                             isExpanded: $metadataSeparatorExpanded)
    }
}

#Preview {
    @Previewable @State var model = VersionModel()
    Form {
        MetadataEditor(model: $model)
    }
}
