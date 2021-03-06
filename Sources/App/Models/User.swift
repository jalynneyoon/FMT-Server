//
//  User.swift
//  
//
//  Created by Johyeon Yoon on 2021/08/03.
//

import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "user"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "nickname")
    var nickname: String

    @Field(key: "login")
    var login: Bool
    
    @Children(for: \.$user)
        var habits: [Habit]
    
    
    init() { }

    init(id: UUID? = nil, nickname: String, login: Bool, habits : [Habit]) {
        self.id = id
        self.nickname = nickname
        self.login = login
        self.habits = habits
        
    }
}
