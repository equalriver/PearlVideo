//
//  YPJTextFieldEx.swift


import Foundation

extension UITextField {
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.returnKeyType = .default
        if self.delegate == nil {
            self.delegate = YPJTextFieldDelegate.shared
        }
//        self.addBlock(for: .editingChanged) { [weak self](tf) in
//            guard self != nil && self!.hasText else { return }
//            guard self!.markedTextRange == nil else { return }
//
//        }
    }

    
}

class YPJTextFieldDelegate: NSObject, UITextFieldDelegate {
    public static let shared: YPJTextFieldDelegate = {
        return YPJTextFieldDelegate()
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
