import XCTest
import UIKit
import SnapshotTesting

func XCTAssertEqualProperties(_ lhs: UIView, _ rhs: UIView, timeout: TimeInterval = 5, file: StaticString = #file, line: UInt = #line) {
    let snapshotting = Snapshotting<UIView, String>.recursiveDescription
    let tookSnapshot = XCTestExpectation(description: "Took snapshot")
    var lhsDescription: String!
    var rhsDescription: String!
    snapshotting.snapshot(lhs).run { lhs in
        snapshotting.snapshot(rhs).run { rhs in
            lhsDescription = lhs
            rhsDescription = rhs
            tookSnapshot.fulfill()
        }
    }
    guard let (failure, _) = snapshotting.diffing.diff(lhsDescription, rhsDescription) else {
        return
    }
    XCTFail(failure)
}

final class IBCodeGenKitTests: XCTestCase {
    func testSimpleView() {
        let nib = UINib(nibName: "SimpleView", bundle: Bundle(for: Self.self))
        let view = nib.instantiate(withOwner: nil, options: nil).first! as! UIView
        XCTAssertEqualProperties(SimpleView().contentView, view)
    }
}
