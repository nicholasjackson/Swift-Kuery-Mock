import Foundation

public struct CallDetails {
    var arguments = [[Any]]()
    var count: Int {
        get {
            return arguments.count
        }
    }
}

public class Calls {
    var details = [String: CallDetails]()

    public func called(method: String, arguments: [Any]!) {
        var detail = self.details[method]
        if detail == nil {
            detail = CallDetails()
        }

        detail!.arguments.append(arguments)

        self.details.updateValue(detail!, forKey: method)
    }
}
