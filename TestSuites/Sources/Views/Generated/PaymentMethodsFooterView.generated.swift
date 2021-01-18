import UIKit



class PaymentMethodsFooterViewOwner: NSObject {
    lazy var paymentMethodsFooterView2: PaymentMethodsFooterView = {
        let view = PaymentMethodsFooterView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 44.0)
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.contentMode = .scaleToFill
        view.addSubview(button0)
        view.addSubview(view1)
        return view
    }()
    lazy var button0: UIButton = {
        let view = UIButton(type: .system)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 44.0)
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.adjustsImageWhenDisabled = true
        view.adjustsImageWhenHighlighted = true
        view.contentHorizontalAlignment = .left
        view.contentVerticalAlignment = .center
        view.setImage(UIImage(named: "icon--plus", in: Bundle(for: Self.self), compatibleWith: nil), for: .normal)
        return view
    }()
    lazy var view1: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 43.5, width: 375.0, height: 0.5)
        view.isUserInteractionEnabled = true
        view.backgroundColor = {
            var components: [CGFloat] = [1.0, 1.0]
            let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
            let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
            return UIColor(cgColor: cgColor)
        }()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: view1, attribute: .width, relatedBy: .equal, toItem: paymentMethodsFooterView2, attribute: .width, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view1, attribute: .trailing, relatedBy: .equal, toItem: paymentMethodsFooterView2, attribute: .trailing, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button0, attribute: .bottom, relatedBy: .equal, toItem: paymentMethodsFooterView2, attribute: .bottom, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view1, attribute: .leading, relatedBy: .equal, toItem: paymentMethodsFooterView2, attribute: .leading, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button0, attribute: .top, relatedBy: .equal, toItem: paymentMethodsFooterView2, attribute: .top, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view1, attribute: .bottom, relatedBy: .equal, toItem: paymentMethodsFooterView2, attribute: .bottom, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button0, attribute: .leading, relatedBy: .equal, toItem: paymentMethodsFooterView2, attribute: .leading, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button0, attribute: .trailing, relatedBy: .equal, toItem: paymentMethodsFooterView2, attribute: .trailing, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button0, attribute: .width, relatedBy: .equal, toItem: paymentMethodsFooterView2, attribute: .width, multiplier: 1.0, constant: 0)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: button0, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44)
                constraint.priority = UILayoutPriority(750)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: view1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
                return constraint
            }(),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return paymentMethodsFooterView2
    }
}
