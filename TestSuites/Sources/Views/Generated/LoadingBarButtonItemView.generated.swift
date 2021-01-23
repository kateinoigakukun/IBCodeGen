import UIKit



class LoadingBarButtonItemViewOwner: NSObject {
    lazy var loadingBarButtonItemView3: LoadingBarButtonItemView = {
        let view = LoadingBarButtonItemView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.contentMode = .scaleToFill
        view.addSubview(view2)
        return view
    }()
    lazy var view2: UIView = {
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
        view.addSubview(activityIndicatorView1)
        view.addSubview(button0)
        return view
    }()
    lazy var activityIndicatorView1: UIActivityIndicatorView = {
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
    lazy var button0: UIButton = {
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
            view2.topAnchor.constraint(equalTo: loadingBarButtonItemView3.topAnchor),
            view2.leadingAnchor.constraint(equalTo: loadingBarButtonItemView3.leadingAnchor),
            loadingBarButtonItemView3.bottomAnchor.constraint(equalTo: view2.bottomAnchor),
            loadingBarButtonItemView3.trailingAnchor.constraint(equalTo: view2.trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            button0.topAnchor.constraint(equalTo: view2.topAnchor),
            activityIndicatorView1.centerYAnchor.constraint(equalTo: button0.centerYAnchor),
            button0.leadingAnchor.constraint(equalTo: view2.leadingAnchor),
            button0.widthAnchor.constraint(equalTo: view2.widthAnchor),
            view2.bottomAnchor.constraint(equalTo: button0.bottomAnchor),
            view2.trailingAnchor.constraint(equalTo: button0.trailingAnchor),
            view2.trailingAnchor.constraint(equalTo: activityIndicatorView1.trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            activityIndicatorView1.heightAnchor.constraint(equalToConstant: 20.0),
            activityIndicatorView1.widthAnchor.constraint(equalToConstant: 20.0),
        ])
        NSLayoutConstraint.activate([
            button0.widthAnchor.constraint(greaterThanOrEqualToConstant: 44.0),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return loadingBarButtonItemView3
    }
}
