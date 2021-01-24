import XCTest
import UIKit
@testable import Views

final class IBCodeGenKitTests: XCTestCase {
    func testSimpleView() {
        let nib = UINib(nibName: "SimpleView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeSimpleViewViews()
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testAutoresizingMask() {
        let nib = UINib(nibName: "AutoresizingMask", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeAutoresizingMaskViews()
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testButton() {
        let nib = UINib(nibName: "Button", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIButton]
        let translatedViews = makeButtonViews()
        for (index, original) in views.enumerated() where index == 20 {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testSubview() {
        let nib = UINib(nibName: "Subview", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeSubviewViews()
        
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testLoadingBarButtonItemView() {
        let nib = UINib(nibName: "LoadingBarButtonItemView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeLoadingBarButtonItemViewViews()
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testDiscoveryProjectCategoryView() {
        let nib = UINib(nibName: "DiscoveryProjectCategoryView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeDiscoveryProjectCategoryViewViews()
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testPaymentMethodsFooterView() {
        let nib = UINib(nibName: "PaymentMethodsFooterView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makePaymentMethodsFooterViewViews()
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
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
