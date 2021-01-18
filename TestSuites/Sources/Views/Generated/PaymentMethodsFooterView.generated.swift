import UIKit



class PaymentMethodsFooterViewOwner: NSObject {
    lazy var paymentMethodsFooterView0: PaymentMethodsFooterView = {
        let view = PaymentMethodsFooterView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 44.0)
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.contentMode = .scaleToFill
        view.addSubview(button1)
        view.addSubview(view2)
        return view
    }()
    lazy var button1: UIButton = {
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
    lazy var view2: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 43.5, width: 375.0, height: 0.5)
        view.isUserInteractionEnabled = true
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemRed
            } else {
                return UIColor(red: 1.0, green: 0.23137255, blue: 0.1882353, alpha: 1.0)
            }
        }()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: view2, attribute: .width, relatedBy: .equal, toItem: paymentMethodsFooterView0, attribute: .width, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view2, attribute: .trailing, relatedBy: .equal, toItem: paymentMethodsFooterView0, attribute: .trailing, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button1, attribute: .bottom, relatedBy: .equal, toItem: paymentMethodsFooterView0, attribute: .bottom, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view2, attribute: .leading, relatedBy: .equal, toItem: paymentMethodsFooterView0, attribute: .leading, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button1, attribute: .top, relatedBy: .equal, toItem: paymentMethodsFooterView0, attribute: .top, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view2, attribute: .bottom, relatedBy: .equal, toItem: paymentMethodsFooterView0, attribute: .bottom, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button1, attribute: .leading, relatedBy: .equal, toItem: paymentMethodsFooterView0, attribute: .leading, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button1, attribute: .trailing, relatedBy: .equal, toItem: paymentMethodsFooterView0, attribute: .trailing, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button1, attribute: .width, relatedBy: .equal, toItem: paymentMethodsFooterView0, attribute: .width, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: button1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
                constraint.priority = UILayoutPriority(750)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: view2, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.5)
                return constraint
            }(),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return paymentMethodsFooterView0
    }
}
