import UIKit



class TableViewCellOwner: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    /// Generated from 'rtJ-WA-hei': "Default"
    lazy var tableViewCell0: UITableViewCell = {
        let view = UITableViewCell()
        view.preservesSuperviewLayoutMargins = true
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 101.0)
        view.clipsToBounds = true
        view.autoresizingMask = []
        view.addSubview(tableViewContentView1)
        return view
    }()
    /// Generated from 'xjn-V9-HiR'
    lazy var tableViewContentView1: UITableViewContentView = {
        let view = UITableViewContentView()
        view.preservesSuperviewLayoutMargins = true
        view.isOpaque = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 101.0)
        view.contentMode = .center
        view.clipsToBounds = true
        view.autoresizingMask = []
        return view
    }()
    var contentView: UIView {
        return tableViewCell0
    }
}

func makeTableViewCellViews() -> [UIView?] {
    [TableViewCellOwner().contentView]
}
