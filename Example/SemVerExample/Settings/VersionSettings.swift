//
//  Created by Vitali Kurlovich on 18.03.26.
//

import SwiftUI

struct VersionSettings: View {
    @Binding
    var model: VersionModel

    @State
    var coreVersionExpanded = false

    @State
    var preReleaseExpanded = false

    @State
    var metadataExpanded = false

    var body: some View {
        SettingItemEditor(titleKey: "Core Version", isExpanded: $coreVersionExpanded) {
            CoreVersionEditor(model: $model)
        }

        SettingItemEditor(titleKey: "Pre-Release", isExpanded: $preReleaseExpanded) {
            PreReleaseEditor(model: $model)
        }

        SettingItemEditor(titleKey: "Metadata", isExpanded: $metadataExpanded) {
            MetadataEditor(model: $model)
        }
    }
}
