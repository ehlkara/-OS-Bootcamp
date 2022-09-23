//
//  main.swift
//  Week 1-day-2
//
//  Created by Ehlullah Karakurt on 18.09.2022.
//

import Foundation

// MARK: Enumerations, Structures and Classes

protocol Profilable {
    var id: String {get set}
    var username: String {get set}
    var age: Int {get set}
}

struct User: Profilable {
    var id:String = "-"
    var username:String = "-"
    var age: Int = 0
    
    init() {
        id="-"
        username = "-"
        age = 0
    }
    
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

struct AdminUser: Profilable {
    var id: String
    
    var username: String
    
    var age: Int
    
    
}

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

class iOSProgrammer:Programmer{
    
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


//-------------------------------------------------------
// MARK: - Optional
var tamsayi: Int?

tamsayi = 5

func unwrapTamsayi()->Int {
    guard let tamsayi = tamsayi else { // tamsayi != nil
        fatalError("Tamsayi unwrap edilemedi.")
    }
    return tamsayi
}

//@IBOutlet weak var button: UIButton
let unwrappedTamsayi = unwrapTamsayi()
print(unwrappedTamsayi)

let fruits = ["apple","strawberry"]

let result = fruits.firstIndex(of: "apple")

print(result as Any)

// MARK: - Error Handling

enum NetworkError: Error, LocalizedError {
    case noInternetConnection
    case timeOut
    case userNotFound
    
    var errorDescription: String?{
        switch self {
        case .userNotFound:
            return "User not Found"
        default:
            return ""
        }
    }
}

//extension NetworkError: LocalizedError {
//    var errorDescription: String?{
//        switch self {
//        case .userNotFound:
//            return "User not Found"
//        default:
//            return ""
//        }
//    }
//}

func fetchUser(_ user: User?) throws -> User {
    guard let user = user else {
        throw NetworkError.userNotFound
    }
    return user
}

do {
    let user = try fetchUser(firstUser)
    print(user)
} catch(let error) {
    print(error.localizedDescription)
}

// MARK: - Protocol

class Profile {
    var user: Profilable
    
    init(user: Profilable) {
        self.user = user
    }
    
    func printProfile() {
        print("***************")
        print("ID \(user.id)")
        print("USERNAME \(user.username)")
        print("AGE \(user.age)")
        print("***************")
    }
}

let userProfile = Profile(user: firstUser)

userProfile.printProfile()

let adminUser = AdminUser(id: "123675", username: "Steve", age: 5)

let adminProfile = Profile(user: adminUser)

adminProfile.printProfile()


//-------------------------------------------------------
// MARK: - Generics
//
//protocol Provider{
//    var baseUrl: String{get}
//    var endPoint: String{get}
//    var parameters: [String:String] {get}
//}
//
//enum InstagramProvider{
//    case getRecentPosts
//    case getProfile
//    case search(text: String)
//
//    init?() {
//        self.init(rawValue: "/getProfile")
//    }
//}
//
//extension InstagramProvider:RawRepresentable{
//    typealias RawValue =  String
//
//    var rawValue: RawValue {
//        endPoint
//    }
//    init?(rawValue: RawValue) {
//        self.init()
//        switch rawValue {
//        case "/getRecentPosts":
//            self = .getRecentPosts
//        case "/getProfile":
//            self = .getProfile
//        default:
//            break
//        }
//    }
//}
//
//extension InstagramProvider:Provider {
//    var baseUrl: String {
//        "https://instagram.com"
//    }
//
//    var endPoint: String {
//        switch self {
//        case .getProfile:
//            return "/getProfile"
//        case .getRecentPosts:
//            return "/getRecentPhotos"
//        case .search:
//            return "/search"
//        }
//    }
//
//    var parameters: [String : String] {
//        [:]
//    }
//}
//
//let instaProvider = InstagramProvider()
//
//class NetworkProvider<P: RawRepresentable> {
//    let provider: P
//
//    init(provider: P){
//        self.provider = provider
//    }
//
//    func performRequest(_ request:P){
//        print(request.rawValue)
//    }
//}
//
//let networkProvider = NetworkProvider<InstagramProvider>(provider: instaProvider!)
//
//networkProvider.performRequest(.getProfile)

//-------------------------------------------------------
// MARK: - Closure, Delegate, Notification Center

protocol ButtonDelegate: AnyObject {
    func didTapButton(_ sender: Button)
    func didUnTapButton(_ sender: Button)
}

class Button {
    
    var delegate: ButtonDelegate?
    
    var didTapped: (() -> Void)?
    
    var isTapped: Bool = false {
        didSet{
            didTapped?()
        }
    }
    
    func tap () {
        isTapped = true
        delegate?.didTapButton(self)
        NotificationCenter.default.post(name: NSNotification.Name("buttonTapped"), object: nil)
    }
    
    func untap() {
        isTapped = false
        delegate?.didUnTapButton(self)
        NotificationCenter.default.post(name: NSNotification.Name("buttonUnTapped"), object: nil)
    }
    
    func didActive(completion: (Error?) -> Void){
        completion(nil)
    }
}

class View{
    var backgroundColor = "white" {
        didSet{
            print(backgroundColor)
        }
    }
    var button: Button
    
    init(button: Button) {
        self.button = button
        self.button.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(didButtonTapped), name: NSNotification.Name("buttonTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didButtonUnTapped), name: NSNotification.Name("buttonUnTapped"), object: nil)
    }
    
    @objc
    func didButtonTapped() {
        print("Background color: \(backgroundColor)")
    }
    
    @objc
    func didButtonUnTapped() {
        print("Background color: \(backgroundColor)")
    }
}

extension View: ButtonDelegate {
    func didTapButton(_ sender: Button) {
        backgroundColor = "red"
    }
    
    func didUnTapButton(_ sender: Button) {
        backgroundColor = "blue"
    }
}

var button = Button()

var view = View(button: button)

button.didTapped = {
    if button.isTapped{
        firstUser.age += 1
        print("Button Tapped")
        print(firstUser)
    } else {
        firstUser.age -= 1
        print("BUTTON RELEASED")
        print(firstUser)
    }
}

button.tap()

button.untap()

button.didActive() {
    error in print(error?.localizedDescription)
}

