//
//  Created by Vitali Kurlovich on 17.03.26.
//

import SwiftUI

struct PreReleaseEditor: View {
    @Binding
    var model: VersionModel

    @State
    var preReleaseTextExpanded = false
    @State
    var preReleaseSeparatorExpanded = false

    var body: some View {
        TextAttributesPicker($model.preRelease)

        TextAttributesEditor("Pre-Release",
                             $model.preReleaseText,
                             isExpanded: $preReleaseTextExpanded)

        TextAttributesEditor("Group Separator",
                             $model.preReleaseSeparator,
                             isExpanded: $preReleaseSeparatorExpanded)
    }
}

#Preview {
    @Previewable @State var model = VersionModel()
    Form {
        PreReleaseEditor(model: $model)
    }
}
