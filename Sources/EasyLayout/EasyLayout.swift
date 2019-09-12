import Foundation
import UIKit

extension UIView {
    public func layout(@ListBuilder build: () -> Listable) {
        if let list = build().asList() as? [NSLayoutConstraint] {
            NSLayoutConstraint.activate(list)
        }
    }
}

extension UIViewController {
    public func layout(@ListBuilder build: () -> Listable) {
        if let list = build().asList() as? [NSLayoutConstraint] {
            NSLayoutConstraint.activate(list)
        }
    }
}

extension UIView {
    public func add(@ListBuilder build: () -> Listable) -> UIView {
        if let list = build().asList() as? [UIView] {
            list.forEach { view in
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(view)
            }
        }
        return self
    }
}

extension UIStackView {
    public func arrange(@ListBuilder build: () -> Listable) -> UIStackView {
        if let list = build().asList() as? [UIView] {
            list.forEach { view in
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addArrangedSubview(view)
            }
        }
        return self
    }
}


public protocol HasApply { }

extension HasApply {
    public func apply(closure:(Self) -> ()) -> Self {
        closure(self)
        return self
    }
}

extension UIView: HasApply { }

//class HStack: UIStackView {
//    init(@ListBuilder build: () -> Listable) {
//        super.init(frame: .zero)
//        self.axis = .horizontal
//
//        if let list = build().asList() as? [UIView] {
//            list.forEach { view in
//                view.translatesAutoresizingMaskIntoConstraints = false
//                self.addArrangedSubview(view)
//            }
//        }
//    }
//
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class VStack: UIStackView {
//    init(@ListBuilder build: () -> Listable) {
//        super.init(frame: .zero)
//        self.axis = .vertical
//
//        if let list = build().asList() as? [UIView] {
//            list.forEach { view in
//                view.translatesAutoresizingMaskIntoConstraints = false
//                self.addArrangedSubview(view)
//            }
//        }
//    }
//
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

