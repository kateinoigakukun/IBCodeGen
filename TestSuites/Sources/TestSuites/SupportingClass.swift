import UIKit

final class LoadingBarButtonItemView: UIView, CustomNSObjectReflectable {
    @IBOutlet fileprivate var activityIndicator: UIActivityIndicatorView!
    @IBOutlet fileprivate var titleButton: UIButton!
    var ignoringReflectionProperties: [String] {
        ["activityIndicator", "titleButton"]
    }
}

final class DiscoveryProjectCategoryView: UIView, CustomNSObjectReflectable {
    @IBOutlet private var blurView: UIImageView!
    @IBOutlet private var categoryStackView: UIStackView!
    @IBOutlet private var categoryViewImageView: UIImageView!
    @IBOutlet private var categoryViewLabel: UILabel!
    var ignoringReflectionProperties: [String] {
        ["blurView", "categoryStackView", "categoryViewImageView", "categoryViewLabel"]
    }
}
