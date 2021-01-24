import UIKit



class SimpleViewOwner: NSObject {
    /// Generated from 'iN0-l3-epB'
    lazy var view0: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.contentMode = .scaleToFill
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    var contentView: UIView {
        return view0
    }
}

func makeSimpleViewViews() -> [UIView?] {
    [SimpleViewOwner().contentView]
}
