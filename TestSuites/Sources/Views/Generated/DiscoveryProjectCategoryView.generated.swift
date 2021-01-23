import UIKit



class DiscoveryProjectCategoryViewOwner: NSObject {
    lazy var discoveryProjectCategoryView0: DiscoveryProjectCategoryView = {
        let view = DiscoveryProjectCategoryView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleToFill
        view.addSubview(stackView1)
        view.addSubview(imageView4)
        return view
    }()
    lazy var stackView1: UIStackView = {
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
        view.addArrangedSubview(label3)
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
    lazy var label3: UILabel = {
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
    lazy var imageView4: UIImageView = {
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
            imageView4.trailingAnchor.constraint(equalTo: discoveryProjectCategoryView0.trailingAnchor, constant: 5.0),
            stackView1.topAnchor.constraint(equalTo: discoveryProjectCategoryView0.topAnchor),
            stackView1.trailingAnchor.constraint(equalTo: discoveryProjectCategoryView0.trailingAnchor),
            stackView1.leadingAnchor.constraint(equalTo: discoveryProjectCategoryView0.leadingAnchor),
            imageView4.topAnchor.constraint(equalTo: discoveryProjectCategoryView0.topAnchor),
            stackView1.bottomAnchor.constraint(equalTo: discoveryProjectCategoryView0.bottomAnchor),
            imageView4.bottomAnchor.constraint(equalTo: discoveryProjectCategoryView0.bottomAnchor),
            {
                let constraint = imageView4.leadingAnchor.constraint(equalTo: stackView1.trailingAnchor)
                constraint.priority = UILayoutPriority(400)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
        ])
        NSLayoutConstraint.activate([
            imageView2.widthAnchor.constraint(equalToConstant: 20.0),
            imageView2.heightAnchor.constraint(equalToConstant: 20.0),
        ])
        NSLayoutConstraint.activate([
        ])
        NSLayoutConstraint.activate([
            imageView4.widthAnchor.constraint(lessThanOrEqualToConstant: 15.0),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return discoveryProjectCategoryView0
    }
}
