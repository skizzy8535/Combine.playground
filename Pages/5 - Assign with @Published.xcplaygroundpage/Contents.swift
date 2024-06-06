import Foundation
import Combine
import PlaygroundSupport
import SwiftUI

/*:
 [< Previous](@previous)           [Home](Home)           [Next >](@next)
 
 * assign(to:) 要在 iOS 14 + 以上的環境使用
    - 他是跟  @Published property 做綁定使用
    - 會直接幫忙處理 Subscription 的 Life Cycle ,也就是說 Published 實例被Deinit 後, 整個Subscription 流程就會中止
      所以你不用處理 .store(in: &AnyCancellable)
*/
 

PlaygroundPage.current.needsIndefiniteExecution = true

class MyTimeModel:ObservableObject {
    
    @Published var lastTime:Date = Date()
    
    init(){
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .assign(to: &$lastTime)
    }
}


struct ClockView :View {
    
    @StateObject var clockModel = MyTimeModel()
    
    var dateFormatter:DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }
    
    var body: some View {
        Text(dateFormatter.string(from: clockModel.lastTime))
            .fixedSize()
            .padding(50)
    }
}


PlaygroundPage.current.setLiveView(ClockView())
