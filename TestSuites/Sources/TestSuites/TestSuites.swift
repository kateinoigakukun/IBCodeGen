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
        for (index, original) in views.enumerated() where index == 16 {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testLabel() {
        let nib = UINib(nibName: "Label", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UILabel]
        let translatedViews = makeLabelViews()
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testImageView() {
        let nib = UINib(nibName: "ImageView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIImageView]
        let translatedViews = makeImageViewViews()
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testSimulatedMetrics() {
        let nib = UINib(nibName: "SimulatedMetrics", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeSimulatedMetricsViews()
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testView() {
        let nib = UINib(nibName: "View", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeViewViews()
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testStackView() {
        let nib = UINib(nibName: "StackView", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeStackViewViews()
        for (index, original) in views.enumerated() {
            guard let translated = translatedViews[index] else { continue }
            XCTAssertEqualProperties(original, translated, description: index.description)
            XCTAssertEqualAppearance(original, translated, description: index.description)
        }
    }

    func testLayoutConstraint() {
        let nib = UINib(nibName: "LayoutConstraint", bundle: Bundle(for: ViewBundle.self))
        let views = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        let translatedViews = makeLayoutConstraintViews()
        for (index, original) in views.enumerated() {
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

extension LoadingBarButtonItemView {
    override var ignoringReflectionProperties: [String] {
        super.ignoringReflectionProperties + ["activityIndicator", "titleButton"]
    }
}

extension DiscoveryProjectCategoryView {
    override var ignoringReflectionProperties: [String] {
        super.ignoringReflectionProperties + ["blurView", "categoryStackView", "categoryViewImageView", "categoryViewLabel"]
    }
}

extension PaymentMethodsFooterView {
    override var ignoringReflectionProperties: [String] {
        super.ignoringReflectionProperties + ["addCardButton", "separatorView"]
    }
}

extension NSAttributedString: CustomNSObjectReflectable {
    var reflectionDescription: String {
        // Workaround: NSAttributedString may have difference in NSParagraphStyle
        // but they don't have effect on iOS, so ignore them.
        return String(describing: self)
            .replacingOccurrences(of: "Blocks (null), ", with: "")
            .replacingOccurrences(of: "Lists (null), ", with: "")
            .replacingOccurrences(of: "Blocks (\\n), ", with: "")
            .replacingOccurrences(of: "Lists (\\n), ", with: "")
    }
}


extension UIView: CustomNSObjectReflectable {
    @objc var ignoringReflectionProperties: [String] {
        ["layoutMarginsGuide", "readableContentGuide"]
    }
}

extension UILabel {
    override var ignoringReflectionProperties: [String] {
        super.ignoringReflectionProperties + ["minimumFontSize"]
    }
}

extension UIButton {
    override var ignoringReflectionProperties: [String] {
        super.ignoringReflectionProperties + ["largeContentImage"]
    }
}

extension UIImageView {
    override var ignoringReflectionProperties: [String] {
        super.ignoringReflectionProperties + ["imageContentGuide", "layoutMarginsGuide", "layoutMarginsGuide"]
    }
}
