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
            view2.widthAnchor.constraint(equalTo: paymentMethodsFooterView0.widthAnchor),
            view2.trailingAnchor.constraint(equalTo: paymentMethodsFooterView0.trailingAnchor),
            button1.bottomAnchor.constraint(equalTo: paymentMethodsFooterView0.bottomAnchor),
            view2.leadingAnchor.constraint(equalTo: paymentMethodsFooterView0.leadingAnchor),
            button1.topAnchor.constraint(equalTo: paymentMethodsFooterView0.topAnchor),
            view2.bottomAnchor.constraint(equalTo: paymentMethodsFooterView0.bottomAnchor),
            button1.leadingAnchor.constraint(equalTo: paymentMethodsFooterView0.leadingAnchor),
            button1.trailingAnchor.constraint(equalTo: paymentMethodsFooterView0.trailingAnchor),
            button1.widthAnchor.constraint(equalTo: paymentMethodsFooterView0.widthAnchor),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = button1.heightAnchor.constraint(equalToConstant: 44.0)
                constraint.priority = .defaultHigh
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            view2.heightAnchor.constraint(equalToConstant: 0.5),
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
