//
//  EmailAnnotation.swift
//  experimental_annotation
//
//  Created by Francisco Javier Saldivar Rubio on 31/07/21.
//

import Foundation
@propertyWrapper
class Email<Value: StringProtocol>: Annotation {
    private var value: Value?
    init(wrappedValue value: Value? = nil) {
        self.wrappedValue = value
    }

    public var wrappedValue: Value? {
        get { return self.value }
        set { self.value = self.executeAction(wrappedValue: newValue) }
    }
    func initValue<T>(value: T) {
        guard let value = value as? Value else {
            return
        }
        self.wrappedValue = value
    }
    
    func executeAction<T>(wrappedValue: T?) -> T? {
        guard let stringValue = wrappedValue as? Value else {
            return wrappedValue
        }
        return (self.validate(email: stringValue) ? stringValue : nil ) as? T
    }

    private func validate(email: Value?) -> Bool {
        guard let email = email else { return false }
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-za-z]{2,64}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: email)
    }
}
