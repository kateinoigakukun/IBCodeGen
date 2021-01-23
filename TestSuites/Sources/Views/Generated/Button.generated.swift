import UIKit



class Button_0Owner: NSObject {
    lazy var button0: UIButton = {
        let view = UIButton()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 46.0, height: 30.0)
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.contentMode = .scaleToFill
        view.contentHorizontalAlignment = .center
        view.contentVerticalAlignment = .center
        view.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        view.titleLabel?.lineBreakMode = .byTruncatingMiddle
        view.setAttributedTitle(NSAttributedString(string: "Button", attributes: [
            .foregroundColor: UIColor.init(white: 1.0, alpha: 1.0), 
            .font: UIFont.systemFont(ofSize: 15)
        ]), for: .normal)
        view.setImage(UIImage(named: "zzz", in: Bundle(for: Self.self), compatibleWith: nil), for: .disabled)
        view.setAttributedTitle(NSAttributedString(string: "Selected Button", attributes: [
            .font: UIFont.systemFont(ofSize: 11), 
            .paragraphStyle: {
                let style = NSMutableParagraphStyle()
                style.alignment = .natural
                return style
            }()
        ]), for: .selected)
        return view
    }()
    var contentView: UIView {
        return button0
    }
}



class Button_1Owner: NSObject {
    lazy var button0: UIButton = {
        let view = UIButton(type: .detailDisclosure)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 25.0, height: 24.0)
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.contentMode = .scaleToFill
        view.adjustsImageWhenDisabled = true
        view.adjustsImageWhenHighlighted = true
        view.contentHorizontalAlignment = .center
        view.contentVerticalAlignment = .center
        return view
    }()
    var contentView: UIView {
        return button0
    }
}



class Button_2Owner: NSObject {
    lazy var button0: UIButton = {
        let view = UIButton()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 25.0, height: 24.0)
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.contentMode = .scaleToFill
        view.contentHorizontalAlignment = .center
        view.contentVerticalAlignment = .center
        view.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        view.titleLabel?.lineBreakMode = .byTruncatingMiddle
        view.setTitle("Custom", for: .normal)
        return view
    }()
    var contentView: UIView {
        return button0
    }
}



class Button_3Owner: NSObject {
    lazy var button0: UIButton = {
        let view = UIButton(type: .system)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.frame = CGRect(x: 0.0, y: 0.0, width: 25.0, height: 24.0)
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.contentMode = .scaleToFill
        view.adjustsImageWhenDisabled = true
        view.adjustsImageWhenHighlighted = true
        view.contentHorizontalAlignment = .center
        view.contentVerticalAlignment = .center
        view.setTitle("Button", for: .normal)
        return view
    }()
    var contentView: UIView {
        return button0
    }
}
