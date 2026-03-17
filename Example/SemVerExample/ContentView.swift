//
//  ContentView.swift
//  SemVerExample
//
//  Created by Vitali Kurlovich on 17.03.26.
//

import SwiftUI

struct ContentView: View {
    @State var model = VersionModel()

    var body: some View {
        VersionEditor(model: $model)
    }
}

#Preview {
    ContentView()
}
