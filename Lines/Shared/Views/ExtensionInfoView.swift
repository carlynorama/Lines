//
//  ExtensionInfoView.swift
//  Lines (macOS)
//
//  Created by Carlyn Maw on 2/9/24.
//

import SwiftUI

struct ExtensionInfoView: View {
    let extensionInfo = ExtensionManager()
    @EnvironmentObject var myLines:LinesVM
    @State var statusText = ""
    var body: some View {
        VStack {
#if os(macOS)
            macExtInfoView().environmentObject(extensionInfo)
#else
            iOSExtInfoView().environmentObject(extensionInfo)
#endif
            Text(statusText)
            Button("Load Latest") {
                loadLatest()
            }
        }
    }
    
    func loadLatest() {
        statusText = "checking for lines..."
        Task {
            statusText = await myLines.updateOrWarn(input: extensionInfo.getExtensionMessage())
        }
    }
    
    
    
    
}

#Preview {
    ExtensionInfoView()
}
