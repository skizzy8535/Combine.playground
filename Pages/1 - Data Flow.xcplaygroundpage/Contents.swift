import Foundation
import Combine

/*:
 [< Previous](@previous)           [Home](Home)           [Next >](@next)
 
 ## Data Flow (資料流)

 我們處理資料就像工廠的自動生產線一樣
 從建立可觀察,可修改的產品,到針對不同狀態下處理
 
 最後這個生產線會出現 正確/錯誤的結果
 或知道這條生產線不需要運作的情況下, 停止這條生產線
 
 而在Rx, Combine 這類的Reactive Framework會按時間排序的事件傳出一組數據流
 
 只要這個數據是被觀察的, 那他就必須有一個數據流的產生。
 
 而數據會發出三種不同的 Events: Value/Error/Completed。
 
 我們就負責監聽可觀測的流動數據，在有event的時候通知我。
 
 ![WorkFlow](WorkFlow.png)

*/
