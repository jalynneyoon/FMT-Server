import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get("hello") { req in
            return "Hello, world!"
        }
    
    try app.register(collection: UserController())
    try app.register(collection: HabitController())
    try app.register(collection: ChecklistController())


}
