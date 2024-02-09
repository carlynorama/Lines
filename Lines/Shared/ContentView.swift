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
            List(myLines) { line in
                Link(line.string, destination: line.url)
            }
            .padding()
            ExtensionInfoView()
        }
    }
}

#Preview {
    ContentView()
}
