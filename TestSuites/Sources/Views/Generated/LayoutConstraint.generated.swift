import UIKit



class LayoutConstraint_0Owner: NSObject {
    /// Generated from 'hmo-qG-qk9': "Edge Margin"
    lazy var view0: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 240.0, height: 153.0)
        view.backgroundColor = UIColor(red: 0.999996, green: 1.0, blue: 1.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addSubview(view1)
        return view
    }()
    /// Generated from 'foZ-Mt-bJs'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 16.0, y: 16.0, width: 208.0, height: 121.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view1.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            view1.topAnchor.constraint(equalTo: view0.topAnchor, constant: 16.0),
            contentView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: 16.0),
            contentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: 16.0),
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



class LayoutConstraint_1Owner: NSObject {
    /// Generated from '68f-wT-Kmk': "Baseline and Alignment"
    lazy var view0: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 240.0, height: 225.0)
        view.backgroundColor = UIColor(red: 0.999996, green: 1.0, blue: 1.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addSubview(view1)
        view.addSubview(view2)
        return view
    }()
    /// Generated from 'mui-4f-4Tq'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 16.0, y: 16.0, width: 200.0, height: 60.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    /// Generated from 'S3D-fn-uGX'
    lazy var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 16.0, y: 92.5, width: 208.0, height: 40.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view2.leadingAnchor.constraint(equalTo: view1.leadingAnchor),
            view1.topAnchor.constraint(equalTo: view0.topAnchor, constant: 16.0),
            view2.centerYAnchor.constraint(equalTo: view0.centerYAnchor),
            view1.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            view2.centerXAnchor.constraint(equalTo: view0.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            view1.heightAnchor.constraint(equalToConstant: 60.0),
            view1.widthAnchor.constraint(equalToConstant: 200.0),
        ])
        NSLayoutConstraint.activate([
            view2.heightAnchor.constraint(equalToConstant: 40.0),
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



class LayoutConstraint_2Owner: NSObject {
    /// Generated from 'vYD-m7-efO': "First Baseline and Aspect Ratio"
    lazy var view0: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 236.0, height: 96.0)
        view.backgroundColor = UIColor(red: 0.999996, green: 1.0, blue: 1.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addSubview(view1)
        view.addSubview(view2)
        return view
    }()
    /// Generated from 'BwP-Jg-aaA'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 16.0, y: 16.0, width: 200.0, height: 60.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    /// Generated from '9u5-04-kWH'
    lazy var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 16.0, y: 16.0, width: 160.0, height: 40.0)
        view.backgroundColor = UIColor(red: 0.0, green: 0.97680455, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view2.firstBaselineAnchor.constraint(equalTo: view1.firstBaselineAnchor),
            view2.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            view1.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            view1.topAnchor.constraint(equalTo: view0.topAnchor, constant: 16.0),
        ])
        NSLayoutConstraint.activate([
            view1.heightAnchor.constraint(equalToConstant: 60.0),
            view1.widthAnchor.constraint(equalToConstant: 200.0),
        ])
        NSLayoutConstraint.activate([
            view2.widthAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 4.0),
            view2.heightAnchor.constraint(equalToConstant: 40.0),
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



class LayoutConstraint_3Owner: NSObject {
    /// Generated from 'L9M-zy-IOf': "Equal Width and Height"
    lazy var view0: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 240.0, height: 225.0)
        view.backgroundColor = UIColor(red: 0.999996, green: 1.0, blue: 1.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.addSubview(view1)
        view.addSubview(view2)
        return view
    }()
    /// Generated from 'LCo-pB-yjL'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 16.0, y: 16.0, width: 208.0, height: 193.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    /// Generated from '79Y-Kj-XIm'
    lazy var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 16.0, y: 16.0, width: 208.0, height: 193.0)
        view.backgroundColor = UIColor(red: 0.0, green: 0.97680455, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view2.centerXAnchor.constraint(equalTo: view0.centerXAnchor),
            view2.centerYAnchor.constraint(equalTo: view0.centerYAnchor),
            view2.heightAnchor.constraint(equalTo: view1.heightAnchor),
            view1.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            view1.centerYAnchor.constraint(equalTo: view0.centerYAnchor),
            view1.centerXAnchor.constraint(equalTo: view0.centerXAnchor),
            view1.topAnchor.constraint(equalTo: view0.topAnchor, constant: 16.0),
            view2.widthAnchor.constraint(equalTo: view1.widthAnchor),
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

func makeLayoutConstraintViews() -> [UIView?] {
    [LayoutConstraint_0Owner().contentView, LayoutConstraint_1Owner().contentView, LayoutConstraint_2Owner().contentView, LayoutConstraint_3Owner().contentView]
}
