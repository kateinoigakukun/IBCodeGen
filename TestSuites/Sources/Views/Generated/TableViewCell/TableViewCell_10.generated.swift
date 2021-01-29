import UIKit



/// Generated from 'HMu-mk-wM6'
class TableViewCell_10_XibSkeleton: UITableViewCell {
    /// Generated from 'Ge4-cV-z4F'
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 16.0, y: 16.0, width: 382.0, height: 175.0)
        view.backgroundColor = UIColor(red: 1.0, green: 0.14913142, blue: 0.0, alpha: 1.0)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        return view
    }()
    func activateConstraints() {
        NSLayoutConstraint.activate([
            view1.heightAnchor.constraint(equalToConstant: 175.0),
        ])
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: 16.0),
            view1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            self.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: 16.0),
            view1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
        ])
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .default
        self.preservesSuperviewLayoutMargins = true
        self.indentationWidth = 10
        self.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 207.0)
        self.clipsToBounds = true
        self.autoresizingMask = []
        
        self.contentView.preservesSuperviewLayoutMargins = true
        self.contentView.isOpaque = false
        self.contentView.insetsLayoutMarginsFromSafeArea = false
        self.contentView.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 207.0)
        self.contentView.contentMode = .center
        self.contentView.clipsToBounds = true
        self.contentView.autoresizingMask = []
        self.contentView.addSubview(view1)
        activateConstraints()
    }
}

func makeTableViewCell_10Views() -> [UIView?] {
    [TableViewCell_10_XibSkeleton().contentView]
}
