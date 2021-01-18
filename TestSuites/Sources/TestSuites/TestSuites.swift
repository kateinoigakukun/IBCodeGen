import XCTest
import UIKit
import SnapshotTesting

func XCTAssertEqualProperties(_ lhs: UIView, _ rhs: UIView, timeout: TimeInterval = 5, file: StaticString = #file, line: UInt = #line) {
    let snapshotting = Snapshotting<UIView, String>.deepRecursiveDescription
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
    XCTFail(failure, file: file, line: line)
}

func XCTAssertEqualAppearance(_ lhs: UIView, _ rhs: UIView, timeout: TimeInterval = 5, file: StaticString = #file, line: UInt = #line) {
    let snapshotting = Snapshotting<UIView, UIImage>.image
    let tookSnapshot = XCTestExpectation(description: "Took snapshot")
    var lhsDescription: UIImage!
    var rhsDescription: UIImage!
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
    XCTFail(failure, file: file, line: line)
}

final class IBCodeGenKitTests: XCTestCase {
    func testSimpleView() {
        let nib = UINib(nibName: "SimpleView", bundle: Bundle(for: Self.self))
        let original = nib.instantiate(withOwner: nil, options: nil).first! as! UIView
        let translated = SimpleView().contentView
        XCTAssertEqualProperties(translated, original)
        XCTAssertEqualAppearance(translated, original)
    }

    func testAutoresizingMask() {
        let nib = UINib(nibName: "AutoresizingMask", bundle: Bundle(for: Self.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [AutoresizingMask_0().contentView, AutoresizingMask_1().contentView]
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(translated, original)
            XCTAssertEqualAppearance(translated, original)
        }
    }

    func testButton() {
        let nib = UINib(nibName: "Button", bundle: Bundle(for: Self.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [Button_0().contentView, Button_1().contentView, Button_2().contentView, Button_3().contentView]
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(translated, original)
            XCTAssertEqualAppearance(translated, original)
        }
    }

    func testSubview() {
        let nib = UINib(nibName: "Subview", bundle: Bundle(for: Self.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [Subview().contentView]
        
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(translated, original)
            XCTAssertEqualAppearance(translated, original)
        }
    }
}
