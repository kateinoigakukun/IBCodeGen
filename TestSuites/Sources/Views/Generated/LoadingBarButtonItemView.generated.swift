import UIKit



class LoadingBarButtonItemViewOwner: NSObject {
    /// Generated from 'iN0-l3-epB'
    lazy var loadingBarButtonItemView0: LoadingBarButtonItemView = {
        let view = LoadingBarButtonItemView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.isUserInteractionEnabled = false
        view.isOpaque = true
        view.isHidden = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.contentMode = .scaleToFill
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(view1)
        return view
    }()
    /// Generated from 'tcZ-2l-zCg'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.backgroundColor = {
            var components: [CGFloat] = [1.0, 1.0]
            let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
            let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
            return UIColor(cgColor: cgColor)
        }()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        view.addSubview(activityIndicatorView2)
        view.addSubview(button3)
        return view
    }()
    /// Generated from 'WeI-gS-cT0'
    lazy var activityIndicatorView2: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOpaque = false
        view.isHidden = false
        view.frame = CGRect(x: 355.0, y: 323.5, width: 20.0, height: 20.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }()
    /// Generated from 'z8e-UA-Yn2'
    lazy var button3: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOpaque = false
        view.isEnabled = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.contentVerticalAlignment = .fill
        view.contentHorizontalAlignment = .right
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.adjustsImageWhenHighlighted = true
        view.adjustsImageWhenDisabled = true
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
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

func makeLoadingBarButtonItemViewViews() -> [UIView?] {
    [LoadingBarButtonItemViewOwner().contentView]
}
