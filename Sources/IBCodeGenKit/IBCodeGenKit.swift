import IBDecodable
import Foundation

public class IBCodeGenerator {
    public init(from url: URL) {
        
    }

    public func generate<Target: TextOutputStream>(target: inout Target) {
        let syntax = """
        import UIKit

        class SimpleView: NSObject {
            lazy var contentView: UIView = {
                let view = UIView()
                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view.frame = CGRect(x: 0, y: 0, width: 600, height: 600)
                return view
            }()
        }
        """
        syntax.write(to: &target)
    }
}
