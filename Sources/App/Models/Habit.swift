//
//  Habit.swift
//
//
//  Created by Johyeon Yoon on 2021/08/03.
//

import Fluent
import Vapor

final class Habit: Model, Content {
    static let schema = "habits"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "habit_name")
    var habit_name: String
    
    @Field(key: "alarm_time")
    var alarm_time: Date

    @Field(key: "public")
    var makepublic: Bool
    
    @Parent(key : "user_id")
    var user : User
    
    @Children(for: \.$checkHabits)
    var checklist: [Checklist]
    
    @Children(for: \.$doneHabits)
    var donelist : [Donelist]
    
    
    init() { }

    init(id: UUID? = nil, habit_name: String, alarm_time: Date, makepublic : Bool, user_id: UUID) {
        self.id = id
        self.habit_name = habit_name
        self.alarm_time = alarm_time
        self.makepublic = makepublic
        self.$user.id = user_id
    }
}
