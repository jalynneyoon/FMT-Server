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
    
    @Field(key: "habit_id")
    var habit_id: UUID
    
    init() { }

    init(id: UUID? = nil, done_date: Date, short_description : String, habit_id: UUID) {
        self.id = id
        self.done_date = done_date
        self.short_description = short_description
        self.habit_id = habit_id
        
    }
}
