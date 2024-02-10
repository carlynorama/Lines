//
//  ContentView.swift
//  Lines
//
//  Created by Carlyn Maw on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var myLines = LinesVM(lines: Lines())
    @State var statusText = ""
    
    
    var body: some View {
        AdaptiveLayout(spacing:10) {
            VStack {
                List(myLines.lines) { line in
                    Link(line.string, destination: line.url)
                }
                Text(statusText)
                PasteButton(payloadType: String.self) { strings in
                    Task {
                        statusText = await myLines.updateOrWarn(input: strings.first)
                    }
                }.buttonBorderShape(.capsule)
            }
            ExtensionInfoView().environmentObject(myLines)
        }.padding()
    }
    
    func updateOrWarn(input:String?, statusLocation:Binding<String>) {

    }
}

#Preview {
    ContentView()
}
