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
        view.addSubview(view0)
        return view
    }()
    lazy var view0: UIView = {
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
        view.addSubview(button2)
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
    lazy var button2: UIButton = {
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
            {
                let constraint = NSLayoutConstraint(item: view0, attribute: .top, relatedBy: .equal, toItem: loadingBarButtonItemView3, attribute: .top, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view0, attribute: .leading, relatedBy: .equal, toItem: loadingBarButtonItemView3, attribute: .leading, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: loadingBarButtonItemView3, attribute: .bottom, relatedBy: .equal, toItem: view0, attribute: .bottom, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: loadingBarButtonItemView3, attribute: .trailing, relatedBy: .equal, toItem: view0, attribute: .trailing, multiplier: 1.0, constant: 0)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: button2, attribute: .top, relatedBy: .equal, toItem: view0, attribute: .top, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: activityIndicatorView1, attribute: .centerY, relatedBy: .equal, toItem: button2, attribute: .centerY, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button2, attribute: .leading, relatedBy: .equal, toItem: view0, attribute: .leading, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button2, attribute: .width, relatedBy: .equal, toItem: view0, attribute: .width, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view0, attribute: .bottom, relatedBy: .equal, toItem: button2, attribute: .bottom, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view0, attribute: .trailing, relatedBy: .equal, toItem: button2, attribute: .trailing, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view0, attribute: .trailing, relatedBy: .equal, toItem: activityIndicatorView1, attribute: .trailing, multiplier: 1.0, constant: 0)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: activityIndicatorView1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: activityIndicatorView1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: button2, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44)
                return constraint
            }(),
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