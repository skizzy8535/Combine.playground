import Foundation
import Combine
import PlaygroundSupport
/*:
 [< Previous](@previous)           [Home](Home)           [Next >](@next)
 
 ####  Just()
  - 產生一個Output元素後,就完成資料流,等同Rx Observable.just()
*/
let justPublisher = Just(42)
let justSubscriber = justPublisher.sink { value in
    print("Received Just value: \(value)")
}
