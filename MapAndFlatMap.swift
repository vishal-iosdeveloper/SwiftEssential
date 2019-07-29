import Foundation
struct Person {
    let name: String
    let address: String
    let  age: Int
    let income: Double
    let cars: [String]
}
let peopleArray = [ Person(name:"Santosh", address: "Pune, India", age:34, income: 100000.0, cars:["i20","Swift VXI"]),
                    Person(name: "John", address:"New York, US", age: 23, income: 150000.0, cars:["Crita", "Swift VXI"]),
                    Person(name:"Amit", address:"Nagpure, India", age:17, income: 200000.0, cars:Array())]

let anyArray = peopleArray.map { (Person) -> String in
    Person.name
}
print("anyArray is : \(anyArray)")


let cars = peopleArray.map {(Person) -> [String] in
    Person.cars
}
print("anyArray is : \(cars)")

let flatCars = peopleArray.flatMap {(Person) -> [String] in
    Person.cars
}
print("flatCars: \(flatCars)")

// Example 2:
let numbers = [23.23478, -2.32784, 34.328, 33.28347]
let sum = numbers.reduce(0) { (result, next) -> Double in
    return result + next
}
print("Sum: \(sum)")
