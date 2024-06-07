
import Foundation
import Combine
import PlaygroundSupport
import UIKit

/*:
 [< Previous](@previous)           [Home](Home)           [Next >](@next)
   #### sink {completion: ,receiveValue:}
    -  提供一個 closure 來接收發出的值和結束事件 ,等同Rx subscribe(event:)。
*/

let url = URL(string: "https://random.imagecdn.app/300/300")!
let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
imageView.contentMode = .scaleAspectFit
PlaygroundPage.current.liveView = imageView

var taskCancellabe:AnyCancellable?

var imageTaskPublisher =  URLSession.shared.dataTaskPublisher(for: url)
                           .tryMap { (data,response) -> UIImage? in
                               guard let response = response as? HTTPURLResponse,
                                     response.statusCode >= 200 && response.statusCode < 300 else {
                                      throw URLError(.badServerResponse)
                               }
                               
                               return UIImage(data:data)
                        }
                           .receive(on: DispatchQueue.main)

cancellable = imageTaskPublisher.sink(receiveCompletion: { completion in
    switch completion {
      case .finished:
        print("Download Task Complete")
      case .failure(let failure):
        print("Download Task Failure ,Reason:\(failure)")
    }
}, receiveValue: { image in
    imageView.image = image
})


taskCancellabe?.cancel()
