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
  * Subscription 是連接 Publisher 跟 Subscriber 的協議, 討論 Subscription前 ,先來看看Subscription的流程
     -  如同前面說的 Subscriber 是依附在 Publisher 上
     -  當要建立資料流的橋樑時, Publisher會傳送 Subscription
     -  這時Subscriber 會實行 Subscription 中 request 的方法  (Subscription 會去確認 Subscriber 要接收的數量)
     -  Subscription 會再去跟Publisher接下需要的量 ,可能是 0個, 1個或多個  (多個的Publisher 會在後面Subject 介紹)
     -  當確認這段資料流關係結束後 Publisher 會 透過Subscription 發出 completion

![Pattern](Pattern.png)
 */


 /*:
  ##### Documentation
  
      protocol Subscription:Cancellable,CustomCombineIdentifierConvertible {
            func request() {_ demand:Subscribers demand}
            func cancel() {}  // clean up
       }
        attaching sink {} => Create Subscription , return Subscription as Cancellable
  */
/*:
 #### Cancellable
   - 當 Subscriber 沒有要從 Publisher 接收值的時候, Subscription 該取消訂閱讓内存管理得以釋放資料
   - AnyCancellable 實作了 Cancellable protocol ，這個協定有一個 cancel() 方法。
   - 如果沒有呼叫 cancel() 方法，訂閱會一直持續
*/
