import Foundation
import Combine
import PlaygroundSupport
import UIKit

/*:
 [< Previous](@previous)           [Home](Home)           [Next >](@next)
  #### assign(to: on:)
     - KVO - esque Pattern  => .assign(to: ReferenceWritableKeyPath, on:)
     - 可以直接把發出的值綁定到指定的屬性上
     - 常用情節是將發出的結果直接綁定到 UI 控件上,等同Rx bind(to:)。
*/
 
class TextFieldViewController: UIViewController, UITextFieldDelegate {
    var resultLabel = UILabel()
    var inputTextField:UITextField!
    
    var textMessage = CurrentValueSubject<String, Never>("Hello world")
    var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        inputTextField = UITextField()
        inputTextField.borderStyle = .roundedRect
        inputTextField.text = textMessage.value
        view.addSubview(inputTextField)
        view.addSubview(resultLabel)
        
        self.view = view
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false

        let margins = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            inputTextField.leftAnchor.constraint(equalTo: margins.leftAnchor),
            inputTextField.rightAnchor.constraint(equalTo: margins.rightAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            resultLabel.leftAnchor.constraint(equalTo: margins.leftAnchor),
            resultLabel.rightAnchor.constraint(equalTo: margins.rightAnchor)
        ])
        
        inputTextField.addTarget(self, action: #selector(updateLabel), for: .editingChanged)
        setResultValue()
    }
    
    
    private func setResultValue() {
        textMessage
            .compactMap { $0 }
            .assign(to: \.text, on: resultLabel)
            .store(in: &subscriptions)
    }
    
    
    @objc func updateLabel() {
        self.textMessage.value = inputTextField.text ?? ""
    }
    
}

let vc = TextFieldViewController()
PlaygroundPage.current.liveView = vc
