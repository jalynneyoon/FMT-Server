//
//  CreateDoneLists.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/02.
//


import Fluent
import FluentPostgresDriver

struct CreateDoneLists: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("donelists")
            .id()
            .field("done_date", .datetime, .required)
            .field("short_description", .string, .required)
            .field("habit_id", .uuid, .required, .references("habits", "id"))
            .create()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("donelists").delete()
    }
}
