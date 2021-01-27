import UIKit



class ImageView_0_Owner: NSObject {
    /// Generated from 'u31-2i-GD2': "Image View - Default"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 240.0, height: 128.0)
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return view
    }()
    var contentView: UIView {
        return imageView0
    }
}



class ImageView_1_Owner: NSObject {
    /// Generated from 'ej4-iy-YgX': "Image View - Image"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = UIImage(named: "normal-image", in: Bundle(for: Self.self), compatibleWith: nil)!
        view.frame = CGRect(x: 0.0, y: 0.0, width: 240.0, height: 128.0)
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return view
    }()
    var contentView: UIView {
        return imageView0
    }
}



class ImageView_2_Owner: NSObject {
    /// Generated from 'BWe-aZ-6bQ': "Image View - Highlighted Image"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.highlightedImage = UIImage(named: "highlighted-image", in: Bundle(for: Self.self), compatibleWith: nil)!
        view.frame = CGRect(x: 0.0, y: 0.0, width: 240.0, height: 128.0)
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return view
    }()
    var contentView: UIView {
        return imageView0
    }
}



class ImageView_3_Owner: NSObject {
    /// Generated from 'uSR-q8-arm': "Image View - Normal and Highlighted Images"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = UIImage(named: "normal-image", in: Bundle(for: Self.self), compatibleWith: nil)!
        view.highlightedImage = UIImage(named: "highlighted-image", in: Bundle(for: Self.self), compatibleWith: nil)!
        view.frame = CGRect(x: 0.0, y: 0.0, width: 240.0, height: 128.0)
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return view
    }()
    var contentView: UIView {
        return imageView0
    }
}



class ImageView_4_Owner: NSObject {
    /// Generated from 'CX9-QF-Dxl': "Image View - Normal and Highlighted Images (Highlighted)"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = UIImage(named: "normal-image", in: Bundle(for: Self.self), compatibleWith: nil)!
        view.highlightedImage = UIImage(named: "highlighted-image", in: Bundle(for: Self.self), compatibleWith: nil)!
        view.frame = CGRect(x: 0.0, y: 0.0, width: 240.0, height: 128.0)
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return view
    }()
    var contentView: UIView {
        return imageView0
    }
}



class ImageView_5_Owner: NSObject {
    /// Generated from 'Xvp-q2-DfL': "Image View - Image (Adjust Image Size)"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = UIImage(named: "normal-image", in: Bundle(for: Self.self), compatibleWith: nil)!
        view.frame = CGRect(x: 0.0, y: 0.0, width: 294.0, height: 56.0)
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        view.adjustsImageSizeForAccessibilityContentSizeCategory = true
        view.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return view
    }()
    var contentView: UIView {
        return imageView0
    }
}

func makeImageViewViews() -> [UIView?] {
    [ImageView_0_Owner().contentView, ImageView_1_Owner().contentView, ImageView_2_Owner().contentView, ImageView_3_Owner().contentView, ImageView_4_Owner().contentView, ImageView_5_Owner().contentView, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
}
