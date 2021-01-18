import XCTest
import UIKit
@testable import Views

final class IBCodeGenKitTests: XCTestCase {
    func testSimpleView() {
        let nib = UINib(nibName: "SimpleView", bundle: Bundle(for: ViewBundle.self))
        let original = nib.instantiate(withOwner: nil, options: nil).first! as! UIView
        let translated = SimpleViewOwner().contentView
        XCTAssertEqualProperties(original, translated)
        XCTAssertEqualAppearance(original, translated)
    }

    func testAutoresizingMask() {
        let nib = UINib(nibName: "AutoresizingMask", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [AutoresizingMask_0Owner().contentView, AutoresizingMask_1Owner().contentView,
                               AutoresizingMask_2Owner().contentView]
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testButton() {
        let nib = UINib(nibName: "Button", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIButton]
        let translatedViews = [Button_0Owner().contentView, Button_1Owner().contentView,
                               Button_2Owner().contentView, Button_3Owner().contentView] as! [UIButton]
        for (index, (original, translated)) in zip(views, translatedViews).enumerated() {
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testSubview() {
        let nib = UINib(nibName: "Subview", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [SubviewOwner().contentView]
        
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testLoadingBarButtonItemView() {
        let nib = UINib(nibName: "LoadingBarButtonItemView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [LoadingBarButtonItemViewOwner().contentView]
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testDiscoveryProjectCategoryView() {
        let nib = UINib(nibName: "DiscoveryProjectCategoryView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [DiscoveryProjectCategoryViewOwner().contentView]
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testPaymentMethodsFooterView() {
        let nib = UINib(nibName: "PaymentMethodsFooterView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = [PaymentMethodsFooterViewOwner().contentView]
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }
}

extension LoadingBarButtonItemView: CustomNSObjectReflectable {
    var ignoringReflectionProperties: [String] {
        ["activityIndicator", "titleButton"]
    }
}

extension DiscoveryProjectCategoryView: CustomNSObjectReflectable {
    var ignoringReflectionProperties: [String] {
        ["blurView", "categoryStackView", "categoryViewImageView", "categoryViewLabel"]
    }
}

extension PaymentMethodsFooterView: CustomNSObjectReflectable {
    var ignoringReflectionProperties: [String] {
        ["addCardButton", "separatorView"]
    }
}
