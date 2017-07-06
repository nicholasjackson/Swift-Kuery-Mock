import Foundation

public struct CallDetails {
    var arguments = [[Any]]()
    var calls = 0
}

public class Calls {
    var details = [String: CallDetails]()

    public func called(method: String, arguments: [Any]!) {
        var detail = self.details[method]
        if detail == nil {
            detail = CallDetails()
        }

        if arguments != nil {
            detail!.arguments.append(arguments)
        }

        detail!.calls += 1

        self.details.updateValue(detail!, forKey: method)
    }
}
