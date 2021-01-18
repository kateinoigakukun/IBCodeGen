import UIKit

public final class LoadingBarButtonItemView: UIView {
    @IBOutlet fileprivate var activityIndicator: UIActivityIndicatorView!
    @IBOutlet fileprivate var titleButton: UIButton!
}

public final class DiscoveryProjectCategoryView: UIView {
    @IBOutlet private var blurView: UIImageView!
    @IBOutlet private var categoryStackView: UIStackView!
    @IBOutlet private var categoryViewImageView: UIImageView!
    @IBOutlet private var categoryViewLabel: UILabel!
}

public final class PaymentMethodsFooterView: UIView {
    @IBOutlet private var addCardButton: UIButton!
    @IBOutlet private var separatorView: UIView!
}

public final class ViewBundle {
    public static let bundle = Bundle(for: ViewBundle.self)
}
