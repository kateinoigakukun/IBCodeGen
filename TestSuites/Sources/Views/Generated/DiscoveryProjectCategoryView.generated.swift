import UIKit



class DiscoveryProjectCategoryViewOwner: NSObject {
    /// Generated from 'iN0-l3-epB'
    lazy var discoveryProjectCategoryView0: DiscoveryProjectCategoryView = {
        let view = DiscoveryProjectCategoryView()
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.contentMode = .scaleToFill
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(stackView1)
        view.addSubview(imageView4)
        return view
    }()
    /// Generated from 'NgN-c7-cxN': "Category Stack View"
    lazy var stackView1: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.spacing = 5.0
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.contentMode = .scaleToFill
        view.axis = .horizontal
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.alignment = .center
        view.addArrangedSubview(imageView2)
        view.addArrangedSubview(label3)
        return view
    }()
    /// Generated from 'DCy-vT-LTC'
    lazy var imageView2: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.frame = CGRect(x: 0.0, y: 323.5, width: 20.0, height: 20.0)
        view.contentMode = .scaleAspectFit
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return view
    }()
    /// Generated from 'TRu-fJ-hBL'
    lazy var label3: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.textAlignment = .natural
        view.text = "Label"
        view.lineBreakMode = .byTruncatingTail
        view.isUserInteractionEnabled = false
        view.isOpaque = false
        view.frame = CGRect(x: 25.0, y: 323.5, width: 350.0, height: 20.5)
        view.font = UIFont.systemFont(ofSize: 17.0)
        view.contentMode = .left
        view.baselineAdjustment = .alignBaselines
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.adjustsFontSizeToFitWidth = false
        view.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
    /// Generated from 'QQz-Fr-vLT'
    lazy var imageView4: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: 375.0, y: 0.0, width: 5.0, height: 667.0)
        view.contentMode = .scaleAspectFill
        view.backgroundColor = {
            var components: [CGFloat] = [0.0, 0.0]
            let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
            let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
            return UIColor(cgColor: cgColor)
        }()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
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
                constraint.priority = .dragThatCannotResizeScene - 90
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            imageView2.widthAnchor.constraint(equalToConstant: 20.0),
            imageView2.heightAnchor.constraint(equalToConstant: 20.0),
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

func makeDiscoveryProjectCategoryViewViews() -> [UIView?] {
    [DiscoveryProjectCategoryViewOwner().contentView]
}
