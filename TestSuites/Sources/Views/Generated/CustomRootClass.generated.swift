import UIKit



/// Generated from 'iN0-l3-epB'
class CustomRootClass0_XibSkeleton: UIView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.isUserInteractionEnabled = true
        self.isOpaque = true
        self.isHidden = false
        self.frame = CGRect(x: 0.0, y: 0.0, width: 406.0, height: 413.0)
        self.contentMode = .scaleToFill
        self.backgroundColor = {
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
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

func makeCustomRootClassViews() -> [UIView?] {
    [CustomRootClass0_XibSkeleton()]
}
