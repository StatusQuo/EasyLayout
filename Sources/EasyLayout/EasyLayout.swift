import Foundation
#if !os(macOS)
    import UIKit

    extension NSLayoutConstraint {
        static func activate(@ListBuilder <NSLayoutConstraint> build: () -> [NSLayoutConstraint]) {
            NSLayoutConstraint.activate(build())
        }
    }

    extension UIView {
        @discardableResult
        public func addSubview(@ListBuilder <UIView> build: () -> [UIView]) -> UIView {
            build().forEach { addSubview($0) }
            return self
        }
    }

    extension UIStackView {
        public func addArrangedSubview(@ListBuilder <UIView> build: () -> [UIView]) -> UIStackView {
            build().forEach { addArrangedSubview($0) }
            return self
        }
    }

#endif
