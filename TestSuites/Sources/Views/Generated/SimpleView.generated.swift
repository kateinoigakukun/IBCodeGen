import UIKit



class SimpleViewOwner: NSObject {
    lazy var view0: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = true
        view.contentMode = .scaleToFill
        return view
    }()
    var contentView: UIView {
        return view0
    }
}

func makeSimpleViewViews() -> [UIView] {
    [SimpleViewOwner().contentView]
}
