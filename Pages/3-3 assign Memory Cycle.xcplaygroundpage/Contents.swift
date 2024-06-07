import Foundation
import Combine
import PlaygroundSupport
/*:
 [< Previous](@previous)           [Home](Home)           [Next >](@next)
 * assign(to: on:) might cause memory cycle
*/
 

struct User {
    let name:String
    let id:Int
}


class UserViewModel {
    
    var user = CurrentValueSubject<User,Never>(User(name: "Betty", id: 20))
    var userID :Int = 0 {
        didSet{
            print("New ID Value change to \(userID)")
        }
    }
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        user
          .map(\.id)
          .assign(to: \.userID , on: self) //  Assign to self will give strong reference , it will cause Memory cycle
          .store(in: &subscriptions)
        
        /* Correct Fix: Use Sink
        user
            .map(\.id)
            .sink { [weak self] value in
                self?.userID = value  // Closure that can claim weak self keyword
            } .store(in: &subscriptions)
         */
    }
         
    
    deinit {
        print("Deinit")
    }
}

var viewModel:UserViewModel? = UserViewModel()
viewModel?.user.send(User(name: "Billy", id: 2))

viewModel = nil
