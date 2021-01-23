import UIKit



class DiscoveryProjectCategoryViewOwner: NSObject {
    lazy var discoveryProjectCategoryView1: DiscoveryProjectCategoryView = {
        let view = DiscoveryProjectCategoryView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleToFill
        view.addSubview(stackView4)
        view.addSubview(imageView3)
        return view
    }()
    lazy var stackView4: UIStackView = {
        let view = UIStackView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.contentMode = .scaleToFill
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 5.0
        view.addArrangedSubview(imageView2)
        view.addArrangedSubview(label0)
        return view
    }()
    lazy var imageView2: UIImageView = {
        let view = UIImageView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 323.5, width: 20.0, height: 20.0)
        view.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        view.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        return view
    }()
    lazy var label0: UILabel = {
        let view = UILabel()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 25.0, y: 323.5, width: 350.0, height: 20.5)
        view.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = false
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.contentMode = .left
        view.text = "Label"
        view.textAlignment = .natural
        view.baselineAdjustment = .alignBaselines
        view.adjustsFontSizeToFitWidth = false
        view.font = UIFont.systemFont(ofSize: 17.0)
        view.lineBreakMode = .byTruncatingTail
        view.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        view.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        view.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(250), for: .horizontal)
        return view
    }()
    lazy var imageView3: UIImageView = {
        let view = UIImageView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 375.0, y: 0.0, width: 5.0, height: 667.0)
        view.isUserInteractionEnabled = true
        view.backgroundColor = {
            var components: [CGFloat] = [0.0, 0.0]
            let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
            let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
            return UIColor(cgColor: cgColor)
        }()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: imageView3, attribute: .trailing, relatedBy: .equal, toItem: discoveryProjectCategoryView1, attribute: .trailing, multiplier: 1.0, constant: 5.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: stackView4, attribute: .top, relatedBy: .equal, toItem: discoveryProjectCategoryView1, attribute: .top, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: stackView4, attribute: .trailing, relatedBy: .equal, toItem: discoveryProjectCategoryView1, attribute: .trailing, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: stackView4, attribute: .leading, relatedBy: .equal, toItem: discoveryProjectCategoryView1, attribute: .leading, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: imageView3, attribute: .top, relatedBy: .equal, toItem: discoveryProjectCategoryView1, attribute: .top, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: stackView4, attribute: .bottom, relatedBy: .equal, toItem: discoveryProjectCategoryView1, attribute: .bottom, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: imageView3, attribute: .bottom, relatedBy: .equal, toItem: discoveryProjectCategoryView1, attribute: .bottom, multiplier: 1.0, constant: 0.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: imageView3, attribute: .leading, relatedBy: .equal, toItem: stackView4, attribute: .trailing, multiplier: 1.0, constant: 0.0)
                constraint.priority = UILayoutPriority(400)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: imageView2, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: imageView2, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: imageView3, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 15.0)
                return constraint
            }(),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return discoveryProjectCategoryView1
    }
}
