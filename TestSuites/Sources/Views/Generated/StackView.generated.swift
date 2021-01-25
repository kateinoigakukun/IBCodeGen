import UIKit



class StackView_0Owner: NSObject {
    /// Generated from '6G3-mR-lPD': "Default Vertical"
    lazy var stackView0: UIStackView = {
        let view = UIStackView()
        view.isOpaque = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 110.0, height: 200.0)
        view.axis = .vertical
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addArrangedSubview(view1)
        view.addArrangedSubview(view2)
        return view
    }()
    /// Generated from 'CGU-a7-WiR'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 0.0, y: 0.0, width: 110.0, height: 100.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    /// Generated from 'Q4J-sK-Kmh'
    lazy var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 0.0, y: 100.0, width: 110.0, height: 100.0)
        view.backgroundColor = UIColor(red: 0.0, green: 0.97680455, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view1.widthAnchor.constraint(equalTo: stackView0.widthAnchor),
            view1.heightAnchor.constraint(equalTo: stackView0.heightAnchor, multiplier: 0.5),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return stackView0
    }
}



class StackView_1Owner: NSObject {
    /// Generated from 'GDo-3p-hbc': "Vertical with Alignment"
    lazy var stackView0: UIStackView = {
        let view = UIStackView()
        view.isOpaque = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 110.0, height: 200.0)
        view.axis = .vertical
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.alignment = .top
        view.addArrangedSubview(view1)
        view.addArrangedSubview(view2)
        return view
    }()
    /// Generated from 'Ihu-aR-D5s'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 0.0, y: 0.0, width: 110.0, height: 100.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    /// Generated from 'SVG-QE-aa1'
    lazy var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 0.0, y: 100.0, width: 110.0, height: 100.0)
        view.backgroundColor = UIColor(red: 0.0, green: 0.97680455, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view1.widthAnchor.constraint(equalTo: stackView0.widthAnchor),
            view1.heightAnchor.constraint(equalTo: stackView0.heightAnchor, multiplier: 0.5),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return stackView0
    }
}



class StackView_2Owner: NSObject {
    /// Generated from 'sVa-4f-NCV': "Vertical with Spacing"
    lazy var stackView0: UIStackView = {
        let view = UIStackView()
        view.spacing = 19.0
        view.isOpaque = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 110.0, height: 203.0)
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addArrangedSubview(view1)
        view.addArrangedSubview(view2)
        return view
    }()
    /// Generated from 'Q2U-4x-Ecq'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 110.0, height: 100.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    /// Generated from 'W9P-K2-1mX'
    lazy var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 0.0, y: 119.0, width: 110.0, height: 84.0)
        view.backgroundColor = UIColor(red: 0.0, green: 0.97680455, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1.19048),
            view1.widthAnchor.constraint(equalTo: stackView0.widthAnchor),
        ])
        NSLayoutConstraint.activate([
            view1.heightAnchor.constraint(equalToConstant: 100.0),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return stackView0
    }
}



class StackView_3Owner: NSObject {
    /// Generated from 'ZgO-qD-OrE': "Vertical with Baseline Relative"
    lazy var stackView0: UIStackView = {
        let view = UIStackView()
        view.spacing = 19.0
        view.isOpaque = false
        view.isBaselineRelativeArrangement = true
        view.frame = CGRect(x: 0.0, y: 0.0, width: 110.0, height: 203.0)
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addArrangedSubview(view1)
        view.addArrangedSubview(view2)
        return view
    }()
    /// Generated from 'TE8-yF-h8D'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 110.0, height: 100.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    /// Generated from 'X5u-p0-BHQ'
    lazy var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 0.0, y: 119.0, width: 110.0, height: 84.0)
        view.backgroundColor = UIColor(red: 0.0, green: 0.97680455, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view1.widthAnchor.constraint(equalTo: stackView0.widthAnchor),
            view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1.19048),
        ])
        NSLayoutConstraint.activate([
            view1.heightAnchor.constraint(equalToConstant: 100.0),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return stackView0
    }
}



class StackView_4Owner: NSObject {
    /// Generated from 'BGR-50-xJW': "Default Horizontal"
    lazy var stackView0: UIStackView = {
        let view = UIStackView()
        view.isOpaque = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 110.0, height: 200.0)
        view.axis = .horizontal
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addArrangedSubview(view1)
        view.addArrangedSubview(view2)
        return view
    }()
    /// Generated from 'Dwp-nL-IOC'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 0.0, y: 0.0, width: 55.0, height: 200.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    /// Generated from 'taM-Rd-b7c'
    lazy var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 55.0, y: 0.0, width: 55.0, height: 200.0)
        view.backgroundColor = UIColor(red: 0.0, green: 0.97680455, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view1.widthAnchor.constraint(equalTo: stackView0.widthAnchor, multiplier: 0.5),
            view1.heightAnchor.constraint(equalTo: stackView0.heightAnchor),
        ])
    }
    override init() {
        super.init()
        activateConstraints()
    }
    var contentView: UIView {
        return stackView0
    }
}

func makeStackViewViews() -> [UIView?] {
    [StackView_0Owner().contentView, StackView_1Owner().contentView, StackView_2Owner().contentView, StackView_3Owner().contentView, StackView_4Owner().contentView]
}
