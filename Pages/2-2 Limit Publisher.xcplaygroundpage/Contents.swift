
import Foundation
import Combine
import PlaygroundSupport

/*:
 [< Previous](@previous)           [Home](Home)           [Next >](@next)
 
 ####  Publishers.Sequence<[Any] ,Never>  aka: [].publisher
  -  產生一組Output元素後,就完成資料流,等同Rx Observable.from()
*/
 

let foodPublisher = ["Hamburger","Pizza","Fried Rice","Beef Noodles"].publisher

foodPublisher.sink { completion in
    print("Completion : \(completion)")
} receiveValue: { item in
    print("Receive Item \(item)")
}
