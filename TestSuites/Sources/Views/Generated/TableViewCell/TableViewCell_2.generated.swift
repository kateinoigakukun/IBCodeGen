import UIKit



/// Generated from 'cmz-kz-LrM': "Selection"
class TableViewCell_2_XibSkeleton: UITableViewCell {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .gray
        self.preservesSuperviewLayoutMargins = true
        self.indentationWidth = 10
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
    }
}

func makeTableViewCell_2Views() -> [UIView?] {
    [TableViewCell_2_XibSkeleton().contentView]
}
