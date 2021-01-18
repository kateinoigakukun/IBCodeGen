import UIKit

final class LoadingBarButtonItemView: UIView, CustomNSObjectReflectable {
    @IBOutlet fileprivate var activityIndicator: UIActivityIndicatorView!
    @IBOutlet fileprivate var titleButton: UIButton!
    var ignoringReflectionProperties: [String] {
        ["activityIndicator", "titleButton"]
    }
}
