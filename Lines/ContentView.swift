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
        List(myLines) { line in
            Link(line.string, destination: line.url)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
