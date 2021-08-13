//
//  ChecklistController.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/11.
//

import Fluent
import Vapor


struct ChecklistController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let checklists = routes.grouped("checklists")
        checklists.get(use: getAllHandler)
        checklists.post(use: createHandler)
        
        // habit_id에 따라
        checklists.group(":habit_id") { checklist in
//            checklist.delete(use: deleteHandler)
            checklist.get(use: getHabitChecklistsHandler)
//            checklist.post(use: createNewHabit)
        }
        
        checklists.group(":id") { checklist in
            checklist.delete(use: deleteChecklistHandler)
        }
    }
    
   
    func getAllHandler(req: Request) throws -> EventLoopFuture<[Checklist]> {
        return Checklist.query(on: req.db).all()
    }
    
    func getHabitChecklistsHandler(req: Request) throws -> EventLoopFuture<[Checklist]> {
        guard let id = req.parameters.get("habit_id"),
              let uuid = UUID(id)
        else {
            throw Abort(.internalServerError)
        }
        
        return Checklist.query(on: req.db)
            .filter(\.$checkHabits.$id == uuid)
            .all()
    }

    func createHandler(req: Request) throws -> EventLoopFuture<Checklist> {
        let checklists = try req.content.decode(Checklist.self)
        return checklists.save(on: req.db).map { checklists }
    }
    
    func deleteChecklistHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Checklist.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }

    func deleteHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Checklist.find(req.parameters.get("habit_id"), on: req.db)
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
