//
//  LineStore.swift
//  Lines
//
//  Created by Carlyn Maw on 2/10/24.
//

import Foundation


class LineStore:ObservableObject {
    @Published private(set) var lines:Lines
    
    init(lines: Lines) {
        self.lines = lines
    }
    
    func append(possibleLine:String) {
        lines.append(possibleLine: possibleLine)
    }
}
