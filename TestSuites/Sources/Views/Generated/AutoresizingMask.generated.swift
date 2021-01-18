import UIKit



class AutoresizingMask_0Owner: NSObject {
    lazy var view0: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.isUserInteractionEnabled = true
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return {
                    var components: [CGFloat] = [1.0, 1.0]
                    let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
                    let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
                    return UIColor(cgColor: cgColor)
                }()
            }
        }()
        view.contentMode = .scaleToFill
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return view0
    }
}



class AutoresizingMask_1Owner: NSObject {
    lazy var view0: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.isUserInteractionEnabled = true
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return {
                    var components: [CGFloat] = [1.0, 1.0]
                    let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
                    let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
                    return UIColor(cgColor: cgColor)
                }()
            }
        }()
        view.contentMode = .scaleToFill
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return view0
    }
}



class AutoresizingMask_2Owner: NSObject {
    lazy var view1: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.isUserInteractionEnabled = true
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return {
                    var components: [CGFloat] = [1.0, 1.0]
                    let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
                    let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
                    return UIColor(cgColor: cgColor)
                }()
            }
        }()
        view.contentMode = .scaleToFill
        view.addSubview(view0)
        return view
    }()
    lazy var view0: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 1.0, y: 165.0, width: 413.0, height: 482.0)
        view.isUserInteractionEnabled = true
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return {
                    var components: [CGFloat] = [1.0, 1.0]
                    let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
                    let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
                    return UIColor(cgColor: cgColor)
                }()
            }
        }()
        view.contentMode = .scaleToFill
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
        ])
        NSLayoutConstraint.activate([
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return view1
    }
}
