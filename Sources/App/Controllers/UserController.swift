import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("user")
        users.get(use: index)
        users.post(use: create)
        users.group(":id") { user in
            user.delete(use: delete)
            user.get(use: show)
//            user.put(use: update)
        }
    }
    
   
    func index(req: Request) throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).map { user }
    }
    

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return User.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
    
    func show(req: Request) throws -> String {
        guard let id = req.parameters.get("id") else {
            throw Abort(.internalServerError)
        }
        return id
    }
    
//    func update(req: Request) throws -> String {
//        guard let id = req.parameters.get("id") else {
//            throw Abort(.internalServerError)
//        }
//        //
//
//        return id
//
//    }

}
