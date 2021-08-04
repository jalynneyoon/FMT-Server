import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.migrations.add(CreateUser())
    app.migrations.add(CreateHabits())
    app.migrations.add(CreateCheckList())
    app.migrations.add(CreateDoneLists())
    app.migrations.add(CreateLikes())
    
    
    if let databaseURL = Environment.get("DATABASE_URL") {
        app.databases.use(try .postgres(
            url: databaseURL
        ), as: .psql)
    } else {
        throw Abort(.internalServerError)
    }
    
    try routes(app)
}
