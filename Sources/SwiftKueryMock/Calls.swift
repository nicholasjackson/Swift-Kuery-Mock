import Foundation
import SwiftKuery

public struct MatchAny{}

public struct CallDetails {
    var arguments = [[Any]?]()
    var count: Int {
        get {
            return arguments.count
        }
    }
}

public struct Callback {
    var method: String
    var arguments: [Any]?
    var call: (([Any]?) -> Void)

    init(method: String, call: @escaping (([Any]?) -> Void), arguments: [Any]?) {
        self.method = method
        self.call = call
        self.arguments = arguments
    }
}

public class Calls {
    var details = [String: CallDetails]()
    var callbacks = [Callback]()

    public func called(method: String, arguments: [Any]?) {
        var detail = self.details[method]
        if detail == nil {
            detail = CallDetails()
        }

        detail!.arguments.append(arguments)

        self.details.updateValue(detail!, forKey: method)

        if let callback = getCallback(method: method, arguments: arguments) {
            callback.call(arguments)
        }
    }

    private func getCallback(method: String, arguments: [Any]?) -> Callback? {
        for callback in callbacks {
            if callback.method == method {
                if callback.arguments == nil && arguments == nil { return callback }

                if let args1 = callback.arguments, let args2 = arguments {
                    let equal = args1.elementsEqual(args2) { (obj1, obj2) in

                        if obj1 is MatchAny || obj2 is MatchAny { return true }
                        if isTypeEqual(type: Query.self, a: obj1, b: obj2) { return true }
                        if isTypeEqual(type: ((QueryResult) -> Void).self, a: obj1, b: obj2) { return true }
                        if isTypeEqual(type: [Any?].self, a: obj1, b: obj2) { return true }
                        if isTypeEqual(type: PreparedStatement.self, a: obj1, b: obj2) { return true }
                        if isEqual(type: String.self, a: obj1, b: obj2) { return true }

                        return false
                    }

                    if equal { return callback }
                }
            }
        }

       return nil
    }

    func isEqual<T: Equatable>(type: T.Type, a: Any, b: Any) -> Bool {
        guard let a = a as? T, let b = b as? T else { return false }

        return a == b
    }

    func isTypeEqual<T>(type: T.Type, a: Any, b: Any) -> Bool {
        if let a = a as? T, let b = b as? T  { return true }

        return false
    }

    public func on(method: String, callback: @escaping ((_ arguments: [Any]?) -> Void)) {
        callbacks.append(Callback(method: method, call: callback, arguments: nil))
    }

    public func on(method: String, withArguments arguments: [Any], callback: @escaping ((_ arguments: [Any]?) -> Void)) {
        callbacks.append(Callback(method: method, call: callback, arguments: arguments))
    }
}
