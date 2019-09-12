import Foundation


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
