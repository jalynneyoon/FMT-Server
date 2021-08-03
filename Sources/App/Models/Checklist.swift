//
//  Checklist.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/03.
//

import Fluent
import Vapor

final class Checklist: Model, Content {
    static let schema = "checklists"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "checktlist_name")
    var checktlist_name: String
    

    @Field(key: "is_checked")
    var is_checked: Bool
    
    @Field(key: "habit_id")
    var habit_id: UUID
    
    init() { }

    init(id: UUID? = nil, checktlist_name: String, is_checked : Bool, habit_id: UUID) {
        self.id = id
        self.checktlist_name = checktlist_name
        self.is_checked = is_checked
        self.habit_id = habit_id
        
    }
}
