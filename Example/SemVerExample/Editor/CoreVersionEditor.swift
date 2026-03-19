//
//  Created by Vitali Kurlovich on 17.03.26.
//

import SwiftUI

struct CoreVersionEditor: View {
    @Binding
    var model: VersionModel

    @State
    var majorExpanded = false
    @State
    var minorExpanded = false
    @State
    var patchExpanded = false
    @State
    var coreVersionSeparatorExpanded = false

    var body: some View {
        TextAttributesPicker($model.coreVersion)

        TextAttributesEditor("Major", $model.major, isExpanded: $majorExpanded)

        TextAttributesEditor("Minor", $model.minor, isExpanded: $minorExpanded)

        TextAttributesEditor("Patch", $model.patch, isExpanded: $patchExpanded)

        TextAttributesEditor("Group Separator",
                             $model.coreVersionSeparator,
                             isExpanded: $coreVersionSeparatorExpanded)
    }
}

#Preview {
    @Previewable @State var model = VersionModel()
    Form {
        CoreVersionEditor(model: $model)
    }
}
