import UIKit



class LoadingBarButtonItemViewOwner: NSObject {
    lazy var loadingBarButtonItemView0: LoadingBarButtonItemView = {
        let view = LoadingBarButtonItemView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.contentMode = .scaleToFill
        view.addSubview(view1)
        return view
    }()
    lazy var view1: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.isUserInteractionEnabled = true
        view.backgroundColor = {
            var components: [CGFloat] = [1.0, 1.0]
            let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
            let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
            return UIColor(cgColor: cgColor)
        }()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        view.addSubview(activityIndicatorView2)
        view.addSubview(button3)
        return view
    }()
    lazy var activityIndicatorView2: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 355.0, y: 323.5, width: 20.0, height: 20.0)
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.isHidden = false
        view.setContentHuggingPriority(UILayoutPriority(750), for: .vertical)
        view.setContentHuggingPriority(UILayoutPriority(750), for: .horizontal)
        return view
    }()
    lazy var button3: UIButton = {
        let view = UIButton(type: .system)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.adjustsImageWhenDisabled = true
        view.adjustsImageWhenHighlighted = true
        view.contentHorizontalAlignment = .right
        view.contentVerticalAlignment = .fill
        view.isEnabled = false
        view.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        view.setTitle("Button", for: .normal)
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: loadingBarButtonItemView0.topAnchor),
            view1.leadingAnchor.constraint(equalTo: loadingBarButtonItemView0.leadingAnchor),
            loadingBarButtonItemView0.bottomAnchor.constraint(equalTo: view1.bottomAnchor),
            loadingBarButtonItemView0.trailingAnchor.constraint(equalTo: view1.trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            button3.topAnchor.constraint(equalTo: view1.topAnchor),
            activityIndicatorView2.centerYAnchor.constraint(equalTo: button3.centerYAnchor),
            button3.leadingAnchor.constraint(equalTo: view1.leadingAnchor),
            button3.widthAnchor.constraint(equalTo: view1.widthAnchor),
            view1.bottomAnchor.constraint(equalTo: button3.bottomAnchor),
            view1.trailingAnchor.constraint(equalTo: button3.trailingAnchor),
            view1.trailingAnchor.constraint(equalTo: activityIndicatorView2.trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            activityIndicatorView2.heightAnchor.constraint(equalToConstant: 20.0),
            activityIndicatorView2.widthAnchor.constraint(equalToConstant: 20.0),
        ])
        NSLayoutConstraint.activate([
            button3.widthAnchor.constraint(greaterThanOrEqualToConstant: 44.0),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return loadingBarButtonItemView0
    }
}
