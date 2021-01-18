import XCTest
import UIKit
import SnapshotTesting

func XCTAssertEqualProperties(_ lhs: UIView, _ rhs: UIView, timeout: TimeInterval = 5, description: String = "",
                              file: StaticString = #file, line: UInt = #line) {
    let snapshottings: [Snapshotting<UIView, String>] = [.recursiveDescription, .deepRecursiveDescription]
    for snapshotting in snapshottings {
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
        XCTFail("\(description) \(failure)", file: file, line: line)
    }
}

func XCTAssertEqualAppearance(_ lhs: UIView, _ rhs: UIView, timeout: TimeInterval = 5, description: String = "",
                              file: StaticString = #file, line: UInt = #line) {
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
    guard let (failure, attachments) = snapshotting.diffing.diff(lhsDescription, rhsDescription) else {
        return
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

final class IBCodeGenKitTests: XCTestCase {
    func testSimpleView() {
        let nib = UINib(nibName: "SimpleView", bundle: Bundle(for: Self.self))
        let original = nib.instantiate(withOwner: nil, options: nil).first! as! UIView
        let translated = SimpleViewOwner().contentView
        XCTAssertEqualProperties(original, translated)
        XCTAssertEqualAppearance(original, translated)
    }

    func testAutoresizingMask() {
        let nib = UINib(nibName: "AutoresizingMask", bundle: Bundle(for: Self.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [AutoresizingMask_0Owner().contentView, AutoresizingMask_1Owner().contentView,
                               AutoresizingMask_2Owner().contentView]
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testButton() {
        let nib = UINib(nibName: "Button", bundle: Bundle(for: Self.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIButton]
        let translatedViews = [Button_0Owner().contentView, Button_1Owner().contentView,
                               Button_2Owner().contentView, Button_3Owner().contentView] as! [UIButton]
        for (index, (original, translated)) in zip(views, translatedViews).enumerated() {
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testSubview() {
        let nib = UINib(nibName: "Subview", bundle: Bundle(for: Self.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [SubviewOwner().contentView]
        
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testLoadingBarButtonItemView() {
        let nib = UINib(nibName: "LoadingBarButtonItemView", bundle: Bundle(for: Self.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [LoadingBarButtonItemViewOwner().contentView]
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }
}
