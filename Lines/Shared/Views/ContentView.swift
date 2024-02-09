//
//  ContentView.swift
//  Lines
//
//  Created by Carlyn Maw on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    @State var myLines = Lines()
    
    var body: some View {
        AdaptiveLayout {
            VStack {
                List(myLines) { line in
                    Link(line.string, destination: line.url)
                }
                PasteButton(payloadType: String.self) { strings in
                    guard let first = strings.first else { return }
                    myLines.append(possibleLine: first)
                }
                .buttonBorderShape(.capsule)
            }
            .padding()
            ExtensionInfoView()
        }
    }
}

#Preview {
    ContentView()
}
