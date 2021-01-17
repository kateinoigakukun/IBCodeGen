import UIKit



class AutoresizingMask_0: NSObject {
    lazy var view0: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return UIColor.white
            }
        }()
        return view
    }()
    var contentView: UIView {
        return view0
    }
}



class AutoresizingMask_1: NSObject {
    lazy var view0: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return UIColor.white
            }
        }()
        return view
    }()
    var contentView: UIView {
        return view0
    }
}
