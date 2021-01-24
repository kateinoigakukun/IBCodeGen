import UIKit



class SubviewOwner: NSObject {
    /// Generated from 'iN0-l3-epB'
    lazy var view0: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemGreen
            } else {
                return UIColor(red: 0.20392157, green: 0.78039217, blue: 0.34901962, alpha: 1.0)
            }
        }()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(view1)
        return view
    }()
    /// Generated from '0Nc-s8-VTj'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 20.0, y: 44.0, width: 374.0, height: 818.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemRed
            } else {
                return UIColor(red: 1.0, green: 0.23137255, blue: 0.1882353, alpha: 1.0)
            }
        }()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addSubview(view2)
        return view
    }()
    /// Generated from 'CS1-Qk-Vmy'
    lazy var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 8.0, y: 8.0, width: 358.0, height: 802.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemPurple
            } else {
                return UIColor(red: 0.6862745, green: 0.32156864, blue: 0.87058824, alpha: 1.0)
            }
        }()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addSubview(view3)
        return view
    }()
    /// Generated from 'xTZ-SP-w9T'
    lazy var view3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 8.0, y: 8.0, width: 342.0, height: 786.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemOrange
            } else {
                return UIColor(red: 1.0, green: 0.58431375, blue: 0.0, alpha: 1.0)
            }
        }()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addSubview(view4)
        view.addSubview(view5)
        return view
    }()
    /// Generated from '0zC-WS-O2V'
    lazy var view4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 10.0, y: 8.0, width: 323.0, height: 362.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemTeal
            } else {
                return UIColor(red: 0.3529412, green: 0.78431374, blue: 0.98039216, alpha: 1.0)
            }
        }()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    /// Generated from 'd7r-AA-zCd'
    lazy var view5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 8.0, y: 381.0, width: 323.0, height: 397.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBlue
            } else {
                return UIColor(red: 0.0, green: 0.47843137, blue: 1.0, alpha: 1.0)
            }
        }()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    var contentView: UIView {
        return view0
    }
}

func makeSubviewViews() -> [UIView?] {
    [SubviewOwner().contentView]
}
