//
//  Lines.swift
//  Lines
//
//  Created by Carlyn Maw on 2/9/24.
//

import Foundation

struct Line:Identifiable, Hashable {

    var id:String {
        "\(string)\(urlString)"
    }
    
    let string:String
    let urlString:String
    
    init(_ string:some StringProtocol, from url:URL) {
        self.string = String(string)
        self.urlString = url.absoluteString
    }
    
    init?(_ string:some StringProtocol, from urlString:some StringProtocol) {
        self.string = String(string)
        guard let tmp = URL(string:String(urlString))?.absoluteString else {
            return nil
        }
        self.urlString = tmp
    }
    
    fileprivate init?(knownFormatString:some StringProtocol) {
        let split = knownFormatString.split(separator: "|")
        if split.count != 2 {
            return nil
        }
        self.string = String(split[0])
        self.urlString = String(split[1])
    }
    
    var url:URL {
        URL(string: urlString)!
    }
    


}


//Maybe should be a Set instead.
struct Lines:RandomAccessCollection, ExpressibleByArrayLiteral {
    typealias Element = Line
    typealias ArrayLiteralElement = Line
    
    public var startIndex: Int { 0 }
    public var endIndex: Int { values.count }
    private(set) var values:[Line]
    
    //ExpressibleByArrayLiteral conformance
    init(arrayLiteral elements: Element...) {
        self.values = elements
    }
    
    init(_ values:[Element]) {
        self.values = values
    }
    
    subscript(position: Int) -> Line {
        get {
            values[position]
        }
        set {
            //probably should check for unique ids...
            values[position] = newValue
        }
    }
    
    mutating
    func append(possibleLine:String) {
        if let newLine = Line(knownFormatString: possibleLine) {
            self.values.append(newLine)
        }
    }
    
}


extension Lines {
    init() {
        //let stringPath = Bundle.main.path(forResource: "lines", ofType: "txt")
        let urlPath = Bundle.main.url(forResource: "lines", withExtension: "txt")
        self = Self.init(url: urlPath!)
    }
    
    init(url:URL) {
        if let tmp = Self.makeLines(from: url) {
            self = tmp
        } else {
            self = Self([])
        }
    }

    @inlinable
    static func makeLines(from fileURL:URL) -> Self? {
        guard let string = try? String(contentsOf: fileURL) else {
            return nil
        }
        let tmp:Self = Self(makeLineArray(from: string))
        if tmp.values.isEmpty { return nil }
        return tmp
    }
    
    @inlinable
    static func makeLineArray(from stringFromFile:String) -> [Line] {
        stringFromFile.split(separator: "\n").compactMap({
            Line(knownFormatString: $0)
        })
    }
}

