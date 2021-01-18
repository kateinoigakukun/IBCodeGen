import UIKit



class LoadingBarButtonItemViewOwner: NSObject {
    lazy var loadingBarButtonItemView2: LoadingBarButtonItemView = {
        let view = LoadingBarButtonItemView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
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
        view.backgroundColor = {
            var components: [CGFloat] = [1.0, 1.0]
            let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
            let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
            return UIColor(cgColor: cgColor)
        }()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.addSubview(activityIndicatorView3)
        view.addSubview(button0)
        return view
    }()
    lazy var activityIndicatorView3: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 355.0, y: 323.5, width: 20.0, height: 20.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    lazy var button0: UIButton = {
        let view = UIButton(type: .system)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.adjustsImageWhenDisabled = true
        view.adjustsImageWhenHighlighted = true
        view.setTitle("Button", for: .normal)
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: view1, attribute: .top, relatedBy: .equal, toItem: loadingBarButtonItemView2, attribute: .top, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view1, attribute: .leading, relatedBy: .equal, toItem: loadingBarButtonItemView2, attribute: .leading, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: loadingBarButtonItemView2, attribute: .bottom, relatedBy: .equal, toItem: view1, attribute: .bottom, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: loadingBarButtonItemView2, attribute: .trailing, relatedBy: .equal, toItem: view1, attribute: .trailing, multiplier: 1.0, constant: 0)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: button0, attribute: .top, relatedBy: .equal, toItem: view1, attribute: .top, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: activityIndicatorView3, attribute: .centerY, relatedBy: .equal, toItem: button0, attribute: .centerY, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button0, attribute: .leading, relatedBy: .equal, toItem: view1, attribute: .leading, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: button0, attribute: .width, relatedBy: .equal, toItem: view1, attribute: .width, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view1, attribute: .bottom, relatedBy: .equal, toItem: button0, attribute: .bottom, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view1, attribute: .trailing, relatedBy: .equal, toItem: button0, attribute: .trailing, multiplier: 1.0, constant: 0)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: view1, attribute: .trailing, relatedBy: .equal, toItem: activityIndicatorView3, attribute: .trailing, multiplier: 1.0, constant: 0)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: activityIndicatorView3, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
                return constraint
            }(),
            {
                let constraint = NSLayoutConstraint(item: activityIndicatorView3, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
                return constraint
            }(),
        ])
        NSLayoutConstraint.activate([
            {
                let constraint = NSLayoutConstraint(item: button0, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44)
                return constraint
            }(),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return loadingBarButtonItemView2
    }
}
