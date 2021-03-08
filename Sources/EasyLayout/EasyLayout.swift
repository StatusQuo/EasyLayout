import Foundation
#if !os(macOS)
    import UIKit

    #if swift(>=5.4)
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

        @resultBuilder
        public struct ListBuilder<T> {
            public typealias Component = [T]

            public static func buildArray(_ components: [Component]) -> Component {
                Array(components.joined())
            }

            public static func buildEither(first component: Component) -> Component {
                component.compactMap { $0 }
            }

            public static func buildEither(second component: Component) -> Component {
                component.compactMap { $0 }
            }

            public static func buildOptional(_ component: Component?) -> Component {
                component ?? []
            }

            public static func buildExpression(_ expression: T) -> Component {
                return [expression]
            }

            public static func buildExpression(_ expression: [T]) -> Component {
                return expression
            }

            public static func buildExpression(_ expression: T?) -> Component {
                if let constraint = expression {
                    return [constraint]
                }
                return []
            }

            public static func buildBlock(_ children: Component...) -> Component {
                Array(children.joined())
            }
        }
    #endif

    #if swift(<5.4)
        extension NSLayoutConstraint {
            static func activate(@ListBuilder build: () -> Listable) {
                if let list = build().asList() as? [NSLayoutConstraint] {
                    NSLayoutConstraint.activate(list)
                }
            }
        }

        extension UIView {
            @discardableResult
            public func addSubview(@ListBuilder build: () -> Listable) -> UIView {
                guard let list = build().asList() as? [UIView] else {
                    return self
                }
                list.forEach { addSubview($0) }
                return self
            }
        }

        extension UIStackView {
            public func addArrangedSubview(@ListBuilder build: () -> Listable) -> UIStackView {
                guard let list = build().asList() as? [UIView] else {
                    return self
                }
                list.forEach { addArrangedSubview($0) }
                return self
            }
        }

        extension SettingsList {
            public func add(@ListBuilder build: () -> Listable) {
                guard let list = build().asList() as? [SettingsCell] else {
                    return
                }
                list.forEach { append($0) }
            }
        }

        public protocol Listable {
            func asList() -> [Any]
        }

        public struct ListContaier: Listable {
            public func asList() -> [Any] {
                return list
            }

            var list: [Any] = []
        }

        extension NSObject: Listable {
            public func asList() -> [Any] {
                return [self]
            }
        }

        extension Array: Listable {}
        extension Array where Element: Any {
            public func asList() -> [Any] {
                return Array(self)
            }
        }

        @_functionBuilder
        public struct ListBuilder {
            public typealias Component = Listable

            public static func buildBlock(_ children: Component...) -> Component {
                var container = ListContaier()
                for child in children {
                    container.list.append(contentsOf: child.asList())
                }
                return container
            }
        }
    #endif

#endif
