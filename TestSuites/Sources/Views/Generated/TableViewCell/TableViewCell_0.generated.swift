import UIKit



/// Generated from 'rtJ-WA-hei': "Default"
class TableViewCell_0_XibSkeleton: UITableViewCell {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.preservesSuperviewLayoutMargins = true
        self.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 101.0)
        self.clipsToBounds = true
        self.autoresizingMask = []
        
        self.contentView.preservesSuperviewLayoutMargins = true
        self.contentView.isOpaque = false
        self.contentView.insetsLayoutMarginsFromSafeArea = false
        self.contentView.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 101.0)
        self.contentView.contentMode = .center
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        self.contentView.autoresizingMask = []
    }
}

func makeTableViewCell_0Views() -> [UIView?] {
    [TableViewCell_0_XibSkeleton().contentView]
}
