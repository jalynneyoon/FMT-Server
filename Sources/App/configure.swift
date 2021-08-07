import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
//    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    

    app.migrations.add(CreateUser())
    app.migrations.add(CreateHabits())
    app.migrations.add(CreateCheckList())
    app.migrations.add(CreateDoneLists())
    app.migrations.add(CreateLikes())
    
    
    if var config = Environment.get("DATABASE_URL")
        .flatMap(URL.init)
        .flatMap(PostgresConfiguration.init) {
        config.tlsConfiguration = .forClient(certificateVerification: .none)
        app.databases.use(.postgres(
            configuration: config
        ), as: .psql)
    } else {
      app.databases.use(
        .postgres(
          hostname: Environment.get("DATABASE_HOST") ??
            "localhost",
          username: Environment.get("DATABASE_USERNAME") ??
            "johyeonyoon",
          password: Environment.get("DATABASE_PASSWORD") ??
            "",
          database: Environment.get("DATABASE_NAME") ??
            "five_mins_tracker_database"),
        as: .psql)
    }
    
    try routes(app)
}
