// You can use let in class & Still update it values.

class FixedLengthRange {
    var firstValue: Int = 0
    init(){
        print("FixedLengthRange initiated")
    }
}

struct FixedLengthRangeStruct {
    var firstValue: Int
    let length: Int
}

let myclass = FixedLengthRange()
myclass.firstValue = 10 // Success
print(myclass.firstValue)


let myStruct = FixedLengthRangeStruct(firstValue: 10, length: 2)
//myStruct.firstValue = 10; // Error
