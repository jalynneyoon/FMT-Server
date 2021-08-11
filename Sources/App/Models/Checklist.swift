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

    @Field(key: "checklist_name")
    var checklist_name: String
    

    @Field(key: "is_checked")
    var is_checked: Bool
    
    @Parent(key: "habit_id")
    var checkHabits: Habit
    
    init() { }

    init(id: UUID? = nil, checktlist_name: String, is_checked : Bool, habit_id: UUID) {
        self.id = id
        self.checklist_name = checklist_name
        self.is_checked = is_checked
        self.$checkHabits.id = habit_id
        
    }
}
