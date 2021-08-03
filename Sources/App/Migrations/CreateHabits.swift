//
//  CreateHabits.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/02.
//

import Fluent
import FluentPostgresDriver

struct CreateHabits: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("habits")
            .id()
            .field("habit_name", .string, .required)
            .field("alarm_time", .datetime, .required)
            .field("public", .bool, .required)
            .field("user_id", .uuid, .required, .references("user", "id"))
            .create()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("habits").delete()
    }
}
