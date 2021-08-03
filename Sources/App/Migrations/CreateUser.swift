import Fluent
import FluentPostgresDriver

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user")
            .id()
            .field("nickname", .string, .required)
            .field("login", .bool, .required)
            .create()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user").delete()
    }
}
