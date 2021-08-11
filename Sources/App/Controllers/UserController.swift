import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("user")
        users.get(use: getAllHandler)
        users.post(use: create)
        
        users.group(":id") { user in
            user.delete(use: delete)
            user.get(use: getUserHabitsHandler)
//            user.put(use: update)
        }
    }
    
   
    func getAllHandler(req: Request) throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db)
            .with(\.$habits) { habit in
                habit.with(\.$checklist).with(\.$donelist)
            }
            .all()
    }
    
    func getUserHabitsHandler(req: Request) throws -> EventLoopFuture<[User]> {
        guard let id = req.parameters.get("id"),
              let uuid = UUID(id)
        else {
            throw Abort(.internalServerError)
        }
        
        return User.query(on: req.db)
            .with(\.$habits) { habit in
                habit.with(\.$checklist).with(\.$donelist)
            }
            .filter(\.$id == uuid)
            .all()
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
