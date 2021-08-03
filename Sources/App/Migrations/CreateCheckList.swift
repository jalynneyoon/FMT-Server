//
//  CreateCheckList.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/02.
//

import Fluent
import FluentPostgresDriver

struct CreateCheckList: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("checklists")
            .id()
            .field("checktlist_name", .string, .required)
            .field("is_checked", .bool, .required)
            .field("habit_id", .uuid, .required, .references("habits", "id"))

            .create()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("checklists").delete()
    }
}
