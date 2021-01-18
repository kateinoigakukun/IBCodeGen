//
//  NSObjectDiffing.swift
//  TestSuites
//
//  Created by kateinoigakukun on 2021/01/18.
//

import Foundation
import SnapshotTesting
import UIKit

class NSObjectMirror {
    enum Value {
        case object(NSObjectMirror)
        case valueObject(Any)
        case array([Value])
        case null
    }
    typealias Property = (name: String, value: Value)
    private(set) var properties: [Property] = []

    private struct Context {
        var objectPath: [NSObject] = []
    }
    var object: NSObject

    init<Object: NSObject>(_ object: Object) {
        self.object = object
        var context = Context()
        context.objectPath.append(object)
        traverse(object, context: &context)
    }
    private init?(_ object: NSObject, context: inout Context) {
        self.object = object
        guard !context.objectPath.contains(object) else { return nil }
        context.objectPath.append(object)
        defer { _ = context.objectPath.popLast() }
        traverse(object, context: &context)
    }

    private func traverse(_ object: NSObject, context: inout Context) {
        var targetClass: AnyClass? = type(of: object)

        while let klass = targetClass {
            defer { targetClass = class_getSuperclass(klass) }
            var propertyCount: UInt32 = 0
            guard let propertyList = class_copyPropertyList(klass, &propertyCount) else {
                continue
            }
            defer { propertyList.deallocate() }

            let ignoreProperties = ["observationInfo", "superclass", "debugDescription", "hash"]
            for index in 0..<Int(propertyCount) {
                let rawPropertyName = property_getName(propertyList[index])
                let attributes = parseAttributes(property: propertyList[index])
                let propertyName = String(utf8String: rawPropertyName)!
                let getter = attributes?.getterName ?? propertyName
                // Avoid getting private property because some private getter assumes
                // that the instance is a specific class instance.
                guard !getter.hasPrefix("_") && !ignoreProperties.contains(getter)
                        && object.responds(to: Selector(getter)) else {
                    continue
                }
                let rawValue = object.value(forKey: getter)
                guard let value = decodeValue(rawValue, context: &context) else {
                    continue
                }
                properties.append((name: propertyName, value: value))
            }
        }
    }

    private func decodeValue(_ value: Any?, context: inout Context) -> Value? {
        switch value {
        case .some(is UIView), .some(is CALayer):
            guard let mirror = NSObjectMirror(object, context: &context) else {
                return nil
            }
            return .object(mirror)
        case .none:
            return .null
        case let .some(value):
            return .valueObject(value)
        }
    }

    struct Attributes {
        var rawType: String?
        var isReadOnly: Bool = false
        var getterName: String?
        var setterName: String?
        var isComputed: Bool = true
    }
    func parseAttributes(property: objc_property_t) -> Attributes? {
        var attributesCount: UInt32 = 0
        guard let attributesList = property_copyAttributeList(property, &attributesCount) else {
            return nil
        }
        func cchar(_ value: Character) -> CChar {
            CChar(value.asciiValue!)
        }
        var attrs = Attributes()
        for index in 0..<Int(attributesCount) {
            let attribute = attributesList[index]
            switch attribute.name.pointee {
            case cchar("T"):
                attrs.rawType = String(utf8String: attribute.value)
            case cchar("R"):
                attrs.isReadOnly = true
            case cchar("G"):
                attrs.getterName = String(utf8String: attribute.value)
            case cchar("S"):
                attrs.setterName = String(utf8String: attribute.value)
            case cchar("V"):
                attrs.isComputed = false
            default:
                break
            }
        }
        return attrs
    }
}

extension NSObjectMirror: AnySnapshotStringConvertible {
    static var renderChildren: Bool { false }
    var snapshotDescription: String {
        properties.sorted(by: { $0.name < $1.name })
            .map { "\($0.name)=\($0.value.snapshotDescription)"}.joined(separator: "\n")
    }
}

extension NSObjectMirror.Value: AnySnapshotStringConvertible {
    var snapshotDescription: String {
        switch self {
        case .object(let object):
            return purgePointers(String(describing: object))
        case .valueObject(let bool as Bool):
            return bool.description
        case .valueObject(let value):
            return purgePointers(String(describing: value))
        case .array(let array):
            return purgePointers(String(describing: array))
        case .null:
            return "nil"
        }
    }
}

extension Snapshotting where Value: NSObject, Format == String {
    public static var deepRecursiveDescription: Snapshotting {
        return SimplySnapshotting.lines.pullback { (object: Value) -> String in
            let mirror = NSObjectMirror(object)
            return mirror.snapshotDescription
        }
    }
}

fileprivate func purgePointers(_ string: String) -> String {
  return string.replacingOccurrences(of: ":?\\s*0x[\\da-f]+(\\s*)", with: "$1", options: .regularExpression)
}
