import UIKit



class Button_0: NSObject {
    lazy var subview0: UIButton = {
        let view = UIButton()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 46.0, height: 30.0)
        return view
    }()
    var contentView: UIView {
        return subview0
    }
}



class Button_1: NSObject {
    lazy var subview0: UIButton = {
        let view = UIButton(type: .detailDisclosure)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 25.0, height: 24.0)
        return view
    }()
    var contentView: UIView {
        return subview0
    }
}



class Button_2: NSObject {
    lazy var subview0: UIButton = {
        let view = UIButton()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 25.0, height: 24.0)
        return view
    }()
    var contentView: UIView {
        return subview0
    }
}



class Button_3: NSObject {
    lazy var subview0: UIButton = {
        let view = UIButton(type: .system)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 25.0, height: 24.0)
        view.setTitle("Button", for: .normal)
        view.setAttributedTitle(NSAttributedString(string: "", attributes: [.font : { let style = NSMutableParagraphStyle(); style.alignment = .natural; return style }()]), for: .normal)
        return view
    }()
    var contentView: UIView {
        return subview0
    }
}
