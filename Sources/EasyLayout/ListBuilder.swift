import Foundation

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

