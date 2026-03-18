//
//  Created by Vitali Kurlovich on 18.03.26.
//

import SwiftUI

struct SettingFormSheet<Content: View>: View {
    let titleKey: LocalizedStringKey

    @Binding
    var isExpanded: Bool

    let content: () -> Content

    init(titleKey: LocalizedStringKey,
         isExpanded: Binding<Bool>,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.titleKey = titleKey
        _isExpanded = isExpanded
        self.content = content
    }

    var body: some View {
        DisclosureGroup(titleKey, isExpanded: $isExpanded) {}.sheet(isPresented: $isExpanded) {
            NavigationStack {
                Form {
                    content()
                }.toolbar {
                    Button(role: .close) {
                        isExpanded = false
                    }
                }
            }.presentationDetents([.medium, .large])
        }
    }
}
