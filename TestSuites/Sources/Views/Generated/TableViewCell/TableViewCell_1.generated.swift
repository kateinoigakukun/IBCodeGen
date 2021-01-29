import UIKit



/// Generated from 'eip-Qm-tbh': "Basic"
class TableViewCell_1_XibSkeleton: UITableViewCell {
    /// Generated from 'yn4-g1-RCz'
    lazy var label1: UILabel = {
        let view = UILabel()
        view.textAlignment = .natural
        view.text = "Title"
        view.lineBreakMode = .byTruncatingTail
        view.isOpaque = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.frame = CGRect(x: 20.0, y: 0.0, width: 374.0, height: 44.0)
        view.font = UIFont.systemFont(ofSize: 17.0)
        view.contentMode = .left
        view.baselineAdjustment = .alignBaselines
        view.autoresizingMask = []
        view.adjustsFontSizeToFitWidth = false
        return view
    }()
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.preservesSuperviewLayoutMargins = true
        self.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 44.0)
        self.clipsToBounds = true
        self.autoresizingMask = []
        
        self.contentView.preservesSuperviewLayoutMargins = true
        self.contentView.isOpaque = false
        self.contentView.insetsLayoutMarginsFromSafeArea = false
        self.contentView.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 44.0)
        self.contentView.contentMode = .center
        self.contentView.clipsToBounds = true
        self.contentView.autoresizingMask = []
        self.contentView.addSubview(label1)
    }
}

func makeTableViewCell_1Views() -> [UIView?] {
    [TableViewCell_1_XibSkeleton().contentView]
}
