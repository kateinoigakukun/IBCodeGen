import UIKit



class SimpleView: NSObject {
    lazy var subview0: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        return view
    }()
    var contentView: UIView {
        return subview0
    }
}

