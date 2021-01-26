import UIKit



class ImageView_0Owner: NSObject {
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



class ImageView_1Owner: NSObject {
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



class ImageView_2Owner: NSObject {
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



class ImageView_3Owner: NSObject {
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



class ImageView_4Owner: NSObject {
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



class ImageView_5Owner: NSObject {
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



class ImageView_6Owner: NSObject {
    /// Generated from 'EDm-t4-ipS': "Image View - Symbol (Automatic)"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "book", withConfiguration: UIImage.SymbolConfiguration.unspecified.withTraitCollection({
                    return UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])
                }()))!
            } else {
                return UIImage(named: "book", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 133.0)
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



class ImageView_7Owner: NSObject {
    /// Generated from 'xoL-bm-yQ9': "Image View - Symbol and Highlighted"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "book", withConfiguration: UIImage.SymbolConfiguration.unspecified.withTraitCollection({
                    return UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])
                }()))!
            } else {
                return UIImage(named: "book", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.highlightedImage = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "book.fill", withConfiguration: UIImage.SymbolConfiguration.unspecified.withTraitCollection({
                    return UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])
                }()))!
            } else {
                return UIImage(named: "book.fill", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 85.0, height: 136.0)
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



class ImageView_8Owner: NSObject {
    /// Generated from 'C9j-Oi-LxO': "Image View - Symbol (Original)"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "book", withConfiguration: UIImage.SymbolConfiguration.unspecified)!.withRenderingMode(.alwaysOriginal)
            } else {
                return UIImage(named: "book", in: Bundle(for: Self.self), compatibleWith: nil)!.withRenderingMode(.alwaysOriginal)
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 49.0)
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



class ImageView_9Owner: NSObject {
    /// Generated from 'ERG-rl-Ghc': "Image View - Symbol (Template)"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "book", withConfiguration: UIImage.SymbolConfiguration.unspecified)!.withRenderingMode(.alwaysTemplate)
            } else {
                return UIImage(named: "book", in: Bundle(for: Self.self), compatibleWith: nil)!.withRenderingMode(.alwaysTemplate)
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 49.0)
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



class ImageView_10Owner: NSObject {
    /// Generated from '3Zs-4K-fSb': "Image View - Symbol (Default Scale)"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "book", withConfiguration: UIImage.SymbolConfiguration(scale: .default))!
            } else {
                return UIImage(named: "book", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 49.0)
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



class ImageView_11Owner: NSObject {
    /// Generated from 'sw3-9m-J9Q': "Image View - Symbol (Small Scale)"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "book", withConfiguration: UIImage.SymbolConfiguration(scale: .small))!
            } else {
                return UIImage(named: "book", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 49.0)
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



class ImageView_12Owner: NSObject {
    /// Generated from 'ovE-Mz-Wdf': "Image View - Symbol (Medium Scale)"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "book", withConfiguration: UIImage.SymbolConfiguration(scale: .medium))!
            } else {
                return UIImage(named: "book", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 49.0)
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



class ImageView_13Owner: NSObject {
    /// Generated from 'N7j-wQ-xh2': "Image View - Symbol (Large Scale)"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "book", withConfiguration: UIImage.SymbolConfiguration(scale: .large))!
            } else {
                return UIImage(named: "book", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.5, width: 88.0, height: 49.0)
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



class ImageView_14Owner: NSObject {
    /// Generated from 'thb-ls-lJb': "Image View - Symbol with Point Size"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        if #available(iOS 13.0, *) {
            view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 4)
        }
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "command", withConfiguration: UIImage.SymbolConfiguration.unspecified.withTraitCollection({
                    return UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])
                }()))!
            } else {
                return UIImage(named: "command", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 47.0)
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



class ImageView_15Owner: NSObject {
    /// Generated from 'g0c-7V-auI': "Image View - Symbol with Font"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        if #available(iOS 13.0, *) {
            view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body))
        }
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "command", withConfiguration: UIImage.SymbolConfiguration.unspecified.withTraitCollection({
                    return UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])
                }()))!
            } else {
                return UIImage(named: "command", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 49.0)
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



class ImageView_16Owner: NSObject {
    /// Generated from 'wOy-qp-I6u': "Image View - Symbol with Small Scale Configuration"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        if #available(iOS 13.0, *) {
            view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(scale: .small)
        }
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "command", withConfiguration: UIImage.SymbolConfiguration.unspecified.withTraitCollection({
                    return UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])
                }()))!
            } else {
                return UIImage(named: "command", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 52.5)
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



class ImageView_17Owner: NSObject {
    /// Generated from 'Fye-tK-Ttn': "Image View - Symbol with Large Scale Configuration"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        if #available(iOS 13.0, *) {
            view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(scale: .large)
        }
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "command", withConfiguration: UIImage.SymbolConfiguration.unspecified.withTraitCollection({
                    return UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])
                }()))!
            } else {
                return UIImage(named: "command", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 44.5)
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



class ImageView_18Owner: NSObject {
    /// Generated from 'p0P-WH-QcM': "Image View - Symbol with Ultra Light Weight"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        if #available(iOS 13.0, *) {
            view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .ultraLight)
        }
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "command", withConfiguration: UIImage.SymbolConfiguration.unspecified.withTraitCollection({
                    return UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])
                }()))!
            } else {
                return UIImage(named: "command", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 49.0)
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



class ImageView_19Owner: NSObject {
    /// Generated from 'DEU-a9-W74': "Image View - Symbol with Bold Weight"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        if #available(iOS 13.0, *) {
            view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        }
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "command", withConfiguration: UIImage.SymbolConfiguration.unspecified.withTraitCollection({
                    return UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])
                }()))!
            } else {
                return UIImage(named: "command", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 48.5)
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



class ImageView_20Owner: NSObject {
    /// Generated from '4OI-4J-Fyu': "Image View - Symbol with Config Combination"
    lazy var imageView0: UIImageView = {
        let view = UIImageView()
        if #available(iOS 13.0, *) {
            view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .small)
        }
        view.isUserInteractionEnabled = false
        view.image = {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "command", withConfiguration: UIImage.SymbolConfiguration.unspecified.withTraitCollection({
                    return UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])
                }()))!
            } else {
                return UIImage(named: "command", in: Bundle(for: Self.self), compatibleWith: nil)!
            }
        }()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 52.0)
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

func makeImageViewViews() -> [UIView?] {
    [ImageView_0Owner().contentView, ImageView_1Owner().contentView, ImageView_2Owner().contentView, ImageView_3Owner().contentView, ImageView_4Owner().contentView, ImageView_5Owner().contentView, ImageView_6Owner().contentView, ImageView_7Owner().contentView, ImageView_8Owner().contentView, ImageView_9Owner().contentView, ImageView_10Owner().contentView, ImageView_11Owner().contentView, ImageView_12Owner().contentView, ImageView_13Owner().contentView, ImageView_14Owner().contentView, ImageView_15Owner().contentView, ImageView_16Owner().contentView, ImageView_17Owner().contentView, ImageView_18Owner().contentView, ImageView_19Owner().contentView, ImageView_20Owner().contentView]
}
