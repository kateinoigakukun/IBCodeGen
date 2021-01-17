//
//  Version.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

struct Version: Hashable {

    let major: Int
    let minor: Int
    let patch: Int
    var components: [Int] {
        return [major, minor, patch]
    }
}

extension Version: Comparable {
    static func < (_ lhs: Version, _ rhs: Version) -> Bool {
        return lhs.components.lexicographicallyPrecedes(rhs.components)
    }
}
