import Foundation
import SwiftKuery

public extension MockSQLConnection {
    public static func createPool(_ mockConnection: MockSQLConnection) -> ConnectionPool {
        let connectionGenerator: () -> Connection? = {
            return mockConnection
        }

        let connectionReleaser: (_ connection: Connection) -> () = { connection in
            connection.closeConnection()
        }

        let options = ConnectionPoolOptions(initialCapacity: 1)

        return ConnectionPool(
            options: options,
            connectionGenerator: connectionGenerator,
            connectionReleaser: connectionReleaser)
    }
}
