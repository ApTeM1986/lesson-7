//
//  main.swift
//  lesson 7
//
//  Created by Artem Stetsenko on 18.05.2022.
//

import Foundation

//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

import Foundation
enum UserErrors: Error {
    case InsufficientFunds(coinsNeeded: Int)
    case OutofStock
    case InvalidName
}

struct Product {
var productName: String
var price: Int
var stock: Int
}

class WebShop {
    var inStock = ["ID001": Product(productName: "Creme", price: 8, stock: 3),
                   "ID002": Product(productName: "Shampoo", price: 55, stock: 3),
                   "ID003": Product(productName: "Soap", price: 5, stock: 0)]
   
    var paymentsFromClient = 50
    
    func checkForValid(itemName name: String)throws -> Product {
        guard let someValue = inStock[name] else {
            throw UserErrors.InvalidName
        }
        guard someValue.stock > 0 else {
            throw UserErrors.OutofStock
        }
        guard someValue.price <= paymentsFromClient else {
            throw UserErrors.InsufficientFunds(coinsNeeded: someValue.price - paymentsFromClient)
        }
        paymentsFromClient -= someValue.price
        var newStock = someValue
        newStock.stock -= 1
        inStock[name] = newStock
        return someValue
    }

}


let client1 = WebShop()


do {

    let clients1 = try   client1.checkForValid(itemName: "ID003")
} catch UserErrors.OutofStock {
    print("Товар закончился")
}
catch UserErrors.InsufficientFunds(_) {
    print("Недостаточно средств")
}
catch UserErrors.InvalidName {
    print("Не верный код товара")
}
catch let error {
    print (error.localizedDescription)
}


