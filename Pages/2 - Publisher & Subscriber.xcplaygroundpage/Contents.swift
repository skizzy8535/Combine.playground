import Foundation
import Combine
import PlaygroundSupport
/*:
 [< Previous](@previous)           [Home](Home)           [Next >](@next)
 
 ## Publisher
   - Publisher 被訂閱之後，會根據請求提供數據
   - 當數據被更改時, 會通知相關的Subscriber傳送新的值給他們 (類似NotificationCenter)
   - Subscriber沒有任何訂閱請求時,Publisher不會提供任何數據
   - 隨時間推移可能有成功或遇到失敗的值 , 因此會發出一個 <Output,Failure> 的泛型
*/

/*:
 ## Subscriber
   如何建立一組訂閱機制
   - sink {completion: ,receiveValue:} => 提供一個 closure 來接收發出的值和結束事件 ,等同Rx subscribe(event:)。
   - assign(to: on:) assign 可以直接把發出的值綁定到指定的屬性上, 常用情節是將發出的結果直接綁定到 UI 控件上,等同Rx bind(to:)。
   - assign() => 這assign 要 iOS 14+ 才能使用
*/


/*:
#####  Just()
  - 產生一個Output元素後,就完成資料流,等同Rx Observable.just()
 */

let justPublisher = Just(42)
let justSubscriber = justPublisher.sink { value in
    print("Received Just value: \(value)")
}


/*:
#####  Publishers.Sequence<[Any] ,Never>  aka: [].publisher
  -  產生一組Output元素後,就完成資料流,等同Rx Observable.from()
 */


let foodPublisher = ["Hamburger","Pizza","Fried Rice","Beef Noodles"].publisher

foodPublisher.sink { completion in
    print("Completion : \(completion)")
} receiveValue: { item in
    print("Receive Item \(item)")
}


/*:
#####  assign 範例1：
 */


class BirdClass{
    var numberOfBirds:Int = 0 {
        didSet{
            print("The Number of bird is \(numberOfBirds)")
        }
    }
}


let myBirds = BirdClass()
let birdObject = [1,2,3].publisher
birdObject.assign(to: \.numberOfBirds, on: myBirds)
