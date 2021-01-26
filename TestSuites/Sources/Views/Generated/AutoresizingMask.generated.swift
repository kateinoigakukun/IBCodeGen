import UIKit



class AutoresizingMask_0_Owner: NSObject {
    /// Generated from 'dsf-Di-YJM'
    lazy var view0: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return {
                    var components: [CGFloat] = [1.0, 1.0]
                    let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
                    let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
                    return UIColor(cgColor: cgColor)
                }()
            }
        }()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    var contentView: UIView {
        return view0
    }
}



class AutoresizingMask_1_Owner: NSObject {
    /// Generated from 'FVP-Xe-00x'
    lazy var view0: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return {
                    var components: [CGFloat] = [1.0, 1.0]
                    let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
                    let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
                    return UIColor(cgColor: cgColor)
                }()
            }
        }()
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        return view
    }()
    var contentView: UIView {
        return view0
    }
}



class AutoresizingMask_2_Owner: NSObject {
    /// Generated from 'Sy1-3i-uGc'
    lazy var view0: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 896.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return {
                    var components: [CGFloat] = [1.0, 1.0]
                    let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
                    let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
                    return UIColor(cgColor: cgColor)
                }()
            }
        }()
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        view.addSubview(view1)
        return view
    }()
    /// Generated from 'aoR-ox-Ktu'
    lazy var view1: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 1.0, y: 165.0, width: 413.0, height: 482.0)
        view.backgroundColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return {
                    var components: [CGFloat] = [1.0, 1.0]
                    let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!
                    let cgColor = CGColor(colorSpace: colorSpace, components: &components)!
                    return UIColor(cgColor: cgColor)
                }()
            }
        }()
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    var contentView: UIView {
        return view0
    }
}

func makeAutoresizingMaskViews() -> [UIView?] {
    [AutoresizingMask_0_Owner().contentView, AutoresizingMask_1_Owner().contentView, AutoresizingMask_2_Owner().contentView]
}
