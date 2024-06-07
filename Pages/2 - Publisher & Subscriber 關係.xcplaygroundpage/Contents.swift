import Foundation
import PlaygroundSupport

/*:
 [< Previous](@previous)           [Home](Home)           [Next >](@next)
 
 ### Publisher
   - Publisher 被訂閱之後，會根據請求提供數據
   - 當數據被更改時, 會通知相關的Subscriber傳送新的值給他們 (類似NotificationCenter)
   - Subscriber沒有任何訂閱請求時,Publisher不會提供任何數據
   - 隨時間推移可能有成功或遇到失敗的值 , 因此會發出一個 <Output,Failure> 的泛型

 ### Subscription
 Subscription 是連接 Publisher 跟 Subscriber 的協議
 
  * 內建 Subscription的方法
 
   - sink {completion: ,receiveValue:} => 提供一個 closure 來接收發出的值和結束事件 ,等同Rx subscribe(event:)。
   - assign(to: on:) assign 可以直接把發出的值綁定到指定的屬性上, 常用情節是將發出的結果直接綁定到 UI 控件上,等同Rx bind(to:)。
   - assign(to:) => 這assign 要 iOS 14+ 才能使用
 
  * 自製 Subscription
    討論自製 Subscription前 ,先來看看Subscription的流程
     -  Subscription 有遵從 Cancellable, 所以自製 Subscription必定要遵從
     -  Subscription 會去確認 Subscriber 要接收的數量  , 確認後會再去跟Publisher接下需要的量

![Pattern](Pattern.png)
 
 */
 //    protocol Subscription:Cancellable,CustomCombineIdentifierConvertible {
 //         func request() {_ demand:Subscribers demand}
 //         func cancel() {}  // clean up
 //      }
 //    attaching sink {} => Create Subscription , return Subscription as Cancellable


/*:
 #### Cancellable
   - 當 Subscriber 沒有要從 Publisher 接收值的時候, Subscription 該取消訂閱讓内存管理得以釋放資料
   - AnyCancellable 實作了 Cancellable protocol ，這個協定有一個 cancel() 方法。
   - 如果沒有呼叫 cancel() 方法，訂閱會一直持續
*/
