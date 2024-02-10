//
//  LineStore.swift
//  Lines
//
//  Created by Carlyn Maw on 2/10/24.
//

import Foundation
import SwiftUI


class LinesVM:ObservableObject {
    @Published private(set) var lines:Lines
    
    init(lines:Lines = Lines()) {
        self.lines = lines
    }
    
    @discardableResult
    func append(possibleLine:String) async -> Bool {
        await MainActor.run {
            let before = lines.count
            lines.append(possibleLine: possibleLine)
            return before + 1 == lines.count
        }
    }
    
    func updateOrWarn(input:String?) async -> String {
        if input != nil {
            let appendTask = await self.append(possibleLine:input!)
            return appendTask ? "Success" : "Failed to add line text:\(input!)"
        } else {
            return "No message waiting."
        }
    }
}
