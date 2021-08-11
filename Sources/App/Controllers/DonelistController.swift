//
//  DonelistController.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/11.
//

import Fluent
import Vapor


struct DonelistController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let donelists = routes.grouped("donelists")
        donelists.get(use: getAllHandler)
        donelists.post(use: createHandler)
        
        // habit_id에 따라
        donelists.group(":habit_id") { donelist in
//            donelist.delete(use: deleteHandler)
//            donelist.get(use: getHabitChecklistsHandler)
//            donelist.post(use: createNewHabit)
        }
    }
    
   
    func getAllHandler(req: Request) throws -> EventLoopFuture<[Donelist]> {
        return Donelist.query(on: req.db).all()
    }
    
//    func getHabitChecklistsHandler(req: Request) throws -> EventLoopFuture<[Checklist]> {
//        return Checklist.query(on: req.db)
//            .all()
//    }

    func createHandler(req: Request) throws -> EventLoopFuture<Donelist> {
        let donelists = try req.content.decode(Donelist.self)
        return donelists.save(on: req.db).map { donelists }
    }
    
    

    func deleteHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Donelist.find(req.parameters.get("habit_id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
    
       
//
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
