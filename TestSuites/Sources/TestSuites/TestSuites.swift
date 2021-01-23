import XCTest
import UIKit
@testable import Views

final class IBCodeGenKitTests: XCTestCase {
    func testSimpleView() {
        let nib = UINib(nibName: "SimpleView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeSimpleViewViews()
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testAutoresizingMask() {
        let nib = UINib(nibName: "AutoresizingMask", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeAutoresizingMaskViews()
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testButton() {
        let nib = UINib(nibName: "Button", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIButton]
        let translatedViews = makeButtonViews()
        for (index, (original, translated)) in zip(views, translatedViews).enumerated() {
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testSubview() {
        let nib = UINib(nibName: "Subview", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeSubviewViews()
        
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testLoadingBarButtonItemView() {
        let nib = UINib(nibName: "LoadingBarButtonItemView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeLoadingBarButtonItemViewViews()
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testDiscoveryProjectCategoryView() {
        let nib = UINib(nibName: "DiscoveryProjectCategoryView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeDiscoveryProjectCategoryViewViews()
        for (original, translated) in zip(views, translatedViews) {
            XCTAssertEqualProperties(original, translated)
            XCTAssertEqualAppearance(original, translated)
        }
    }

    func testPaymentMethodsFooterView() {
        let nib = UINib(nibName: "PaymentMethodsFooterView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makePaymentMethodsFooterViewViews()
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
