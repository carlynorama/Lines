//
//  ContentView.swift
//  Lines
//
//  Created by Carlyn Maw on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var myLines = LineStore(lines: Lines())
    
    
    
    var body: some View {
        AdaptiveLayout(spacing:10) {
            VStack {
                List(myLines.lines) { line in
                    Link(line.string, destination: line.url)
                }
                
                PasteButton(payloadType: String.self) { strings in
                    guard let first = strings.first else { return }
                    myLines.append(possibleLine: first)
                }.buttonBorderShape(.capsule)
            }
            ExtensionInfoView().environmentObject(myLines)
        }.padding()
    }
}

#Preview {
    ContentView()
}
