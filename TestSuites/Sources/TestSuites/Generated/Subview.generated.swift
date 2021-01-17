import UIKit



class Subview: NSObject {
    lazy var view3: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.backgroundColor = UIColor.systemGreen
        view.addSubview(view1)
        return view
    }()
    lazy var view1: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 20.0, y: 44.0, width: 374.0, height: 818.0)
        view.backgroundColor = UIColor.systemRed
        view.addSubview(view2)
        return view
    }()
    lazy var view2: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 8.0, y: 8.0, width: 358.0, height: 802.0)
        view.backgroundColor = UIColor.systemPurple
        view.addSubview(view4)
        return view
    }()
    lazy var view4: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 8.0, y: 8.0, width: 342.0, height: 786.0)
        view.backgroundColor = UIColor.systemOrange
        view.addSubview(view5)
        view.addSubview(view0)
        return view
    }()
    lazy var view5: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 10.0, y: 8.0, width: 323.0, height: 362.0)
        view.backgroundColor = UIColor.systemTeal
        return view
    }()
    lazy var view0: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 8.0, y: 381.0, width: 323.0, height: 397.0)
        view.backgroundColor = UIColor.systemBlue
        return view
    }()
    var contentView: UIView {
        return view3
    }
}
