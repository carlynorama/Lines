//
//  ExtensionInfoView.swift
//  Lines (macOS)
//
//  Created by Carlyn Maw on 2/9/24.
//

import SwiftUI

struct ExtensionInfoView: View {
    let extensionInfo = ExtensionManager()
    @EnvironmentObject var lines:LineStore
    @State var statusMessage = ""
    var body: some View {
        VStack {
#if os(macOS)
            macExtInfoView().environmentObject(extensionInfo)
#else
            iOSExtInfoView().environmentObject(extensionInfo)
#endif
            Text(statusMessage)
            Button("Load Latest") {
                loadLatest()
            }
        }
    }
    
    func loadLatest() {
        print("checking lines")
        
        let newMessage = extensionInfo.getExtensionMessage()
        print(newMessage, extensionInfo.extensionMessageService.fromExtensionKey)
        if newMessage != nil {
            lines.append(possibleLine:newMessage!)
            print("added line")
        }
    }
    
}

#Preview {
    ExtensionInfoView()
}
