//
//  main.swift
//  Week 1-day-2
//
//  Created by Ehlullah Karakurt on 18.09.2022.
//

import Foundation

struct User {
    var id:String
    var username:String
    let age: Int
    
    init(id: String, username: String, age:Int){
        self.id = id
        self.username = username
        self.age = age
    }
    
    mutating func updateUserName(_ username:String) {
        self.username = username
    }
}

// Struct için miras alma yapılamaz!
//struct AdminUser : User {
//
//}

class Programmer: Equatable {
    
    static let shared = Programmer(expert: "")
    
    static func == (lhs: Programmer, rhs:Programmer) -> Bool {
        lhs.expert == rhs.expert
    }
    
    var expert: String
    var experience: Int
    
    class var id: String {
        "000"
    }
    
    init(expert: String, experience: Int = 0){
        self.expert = expert
        self.experience = experience
    }
    
    func updateExperience(_ experience: Int) {
        self.experience = experience
    }
    
    static func printId() {
        print(id)
    }
   
}

class iOSProgrammer: Programmer {
    override init(expert: String, experience: Int = 0) {
        super.init(expert: expert, experience: experience)
    }
}

print(Programmer.printId())

var firstUser = User(id: "0123", username: "John", age: 22)

//firstUser.username = "Ehlullah"

firstUser.updateUserName("Ehlullah")

var secondUser = firstUser

firstUser.id = "0987"

print(firstUser)

print(secondUser)

var programmer = Programmer(expert: "iOS Developer")

print(programmer.expert)

var secondProgrammer = programmer

secondProgrammer.expert = "Android Developer"

print(programmer.expert)

print(secondProgrammer.expert)

if programmer == secondProgrammer
{
    print("Programmer is equal to secondProgrammer")
}
else {
    print("Not equal")
}
