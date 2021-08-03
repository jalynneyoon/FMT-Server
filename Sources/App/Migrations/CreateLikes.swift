//
//  CreateLikes.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/02.
//

import Fluent
import FluentPostgresDriver

struct CreateLikes: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("likes")
            .id()
            .field("habit_id", .uuid, .required, .references("habits", "id"))
            .field("user_id", .uuid, .required, .references("user", "id"))
            .create()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("likes").delete()
    }
}
