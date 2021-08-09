import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get("hello") { req in
            return "Hello, world!"
        }
    
//    app.get("user") {req in
//        User.query(on: req.db).all()

    
    try app.register(collection: UserController())

}
