//
//  File.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/03.
//

import Fluent
import Vapor

final class Likes: Model, Content {
    static let schema = "likes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "habit_id")
    var habit_id: UUID
    
    @Field(key: "user_id")
    var user_id: UUID
    
    init() { }

    init(id: UUID? = nil, habit_id: UUID, user_id: UUID) {
        self.id = id
        self.habit_id = habit_id
        self.user_id = user_id
        
    }
}
