import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get("user") {req in
        User.query(on: req.db).all()
    }
    
//    app.post("user") { req -> EventLoopFuture<User> in
//        let user = try req.content.decode(User.self)
//        return user.create(on: req.db).map { user }
//    }

}
