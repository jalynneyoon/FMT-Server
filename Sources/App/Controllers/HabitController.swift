//
//  HabitController.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/09.
//

import Fluent
import Vapor

/*
GET /habits/{user_id} —  한 유저의 습관 정보 보여주기
POST /habits/{user_id} — 유저의 습관 추가 */

struct HabitController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let habits = routes.grouped("habits")
        habits.get(use: getAllHandler)
        habits.post(use: createHabitHandler)
        
        // habit_id에 따라
        habits.group(":id") { habit in
            habit.delete(use: deleteHandler)
            habit.get(use: getHabitHandler)
        }
        
        // user_id에 따라
        habits.group(":user_id") { habit in
//            habit.delete(use: delete)
//            habit.get(use: getUserHabitsHandler)  // 에러처리
//            habits.post(use: createNewHabit)
        }
    }
    
   
    func getAllHandler(req: Request) throws -> EventLoopFuture<[Habit]> {
        return Habit.query(on: req.db)
            .with(\.$checklist)
            .with(\.$donelist)
            .all()
    }
    
    func getHabitHandler(req: Request) throws -> EventLoopFuture<[Habit]> {
        guard let id = req.parameters.get("user_id"),
              let uuid = UUID(id)
        else {
            throw Abort(.internalServerError)
        }
        
        return Habit.query(on: req.db)
            .with(\.$checklist)
            .with(\.$donelist)
            .filter(\.$user.$id == uuid)
            .all()
    }
    
    func getUserHabitsHandler(req: Request) throws -> EventLoopFuture<[Habit]> {
        guard let id = req.parameters.get("id"),
              let uuid = UUID(id)
        else { throw Abort(.internalServerError)}
        
        return Habit.query(on: req.db)
            .filter(\.$user.$id == uuid)
            .with(\.$checklist)
            .with(\.$donelist)
            .all()
    }

    func createHabitHandler(req: Request) throws -> EventLoopFuture<Habit> {
        let habits = try req.content.decode(Habit.self)
        return habits.save(on: req.db).map { habits }
    }
    

    func deleteHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Habit.find(req.parameters.get("id"), on: req.db)
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
