//
//  File.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/03.
//

import Fluent
import Vapor

final class Donelist: Model, Content {
    static let schema = "donelists"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "done_date")
    var done_date: Date
    
    @Field(key: "short_description")
    var short_description: String
    
    @Parent(key: "habit_id")
    var doneHabits: Habit
    
    init() { }

    init(id: UUID? = nil, done_date: Date, short_description : String, habit_id: UUID) {
        self.id = id
        self.done_date = done_date
        self.short_description = short_description
        self.$doneHabits.id = habit_id
        
    }
}
