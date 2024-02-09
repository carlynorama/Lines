//
//  ExtensionInfoView.swift
//  Lines (macOS)
//
//  Created by Carlyn Maw on 2/9/24.
//

import SwiftUI

struct ExtensionInfoView: View {
    let extensionInfo = ExtensionManager()
    var body: some View {
#if os(macOS)
        macExtInfoView().environmentObject(extensionInfo)
#else
        iOSExtInfoView().environmentObject(extensionInfo)
#endif
    }
}

#Preview {
    ExtensionInfoView()
}
