//
//  Assertion.swift
//  TestSuites
//
//  Created by kateinoigakukun on 2021/01/18.
//

import Foundation
import SnapshotTesting
import XCTest

func XCTAssertEqualSnapshot<Value, Format>(
    _ lhs: Value, _ rhs: Value,
    as snapshotting: Snapshotting<Value, Format>,
    timeout: TimeInterval = 5, description: String = "",
    file: StaticString = #file, line: UInt = #line
) {
    let tookSnapshot = XCTestExpectation(description: "Took snapshot")
    var lhsDescription: Format!
    var rhsDescription: Format!
    snapshotting.snapshot(lhs).run { lhs in
        snapshotting.snapshot(rhs).run { rhs in
            lhsDescription = lhs
            rhsDescription = rhs
            tookSnapshot.fulfill()
        }
    }
    guard let (failure, _attachments) = snapshotting.diffing.diff(lhsDescription, rhsDescription) else {
        return
    }
    var attachments = _attachments
    if let lhsDescription = lhsDescription as? String,
       let rhsDescription = rhsDescription as? String {
        attachments.append(contentsOf: [
            XCTAttachment(data: Data(lhsDescription.utf8), uniformTypeIdentifier: "reference"),
            XCTAttachment(data: Data(rhsDescription.utf8), uniformTypeIdentifier: "failure"),
        ])
    }
    if !attachments.isEmpty {
        if ProcessInfo.processInfo.environment.keys.contains("__XCODE_BUILT_PRODUCTS_DIR_PATHS") {
            XCTContext.runActivity(named: "Attached Failure Diff") { activity in
                attachments.forEach {
                    activity.add($0)
                }
            }
        }
    }
    XCTFail("\(description) \(failure)", file: file, line: line)
}
func XCTAssertEqualProperties(_ lhs: UIView, _ rhs: UIView, timeout: TimeInterval = 5, description: String = "",
                              file: StaticString = #file, line: UInt = #line) {
    let snapshottings: [Snapshotting<UIView, String>] = [.deepRecursiveDescription, .recursiveDescription]
    for snapshotting in snapshottings {
        XCTAssertEqualSnapshot(lhs, rhs, as: snapshotting, timeout: timeout, description: description, file: file, line: line)
    }
}

func XCTAssertEqualAppearance(_ lhs: UIView, _ rhs: UIView, timeout: TimeInterval = 5, description: String = "",
                              file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqualSnapshot(lhs, rhs, as: .image, timeout: timeout, description: description, file: file, line: line)
}
