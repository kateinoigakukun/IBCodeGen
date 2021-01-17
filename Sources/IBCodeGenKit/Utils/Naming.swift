//
//  Naming.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

func dropHungarianNotation(from string: String) -> String {
    if string.hasPrefix("UI") {
        return String(string.dropFirst(2))
    }
    return string
}

func toLowerCamelCase(fromUpperCamelCase string: String) -> String {
    var string = string
    let first = string.removeFirst()
    string = first.lowercased() + string
    return string
}
