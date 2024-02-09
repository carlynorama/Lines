//
//  iOSContentView.swift
//  WebHelperExtension
//
//  Created by Carlyn Maw on 1/20/24.
//

#if !os(macOS)
import SwiftUI

struct iOSExtInfoView: View {
    @EnvironmentObject var viewModel:ExtensionManager
    
    var body: some View {
        VStack {
            HStack {
                
            }
            Text("Turn on the Safari extension \(Constants.extensionName) in “Settings › Safari” to grab new lines.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button("Open Settings") {
                // Get the settings URL and open it
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            }
            if let url = URL(string: Constants.goodSamplePage) {
                Link("Open Example page", destination: url)
            }
            
        }
    
}

#Preview {
    iOSExtInfoView()
}
#endif
