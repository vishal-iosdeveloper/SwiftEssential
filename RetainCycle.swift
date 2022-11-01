// Retain cycle
class Person {
    
    let name: String
    var macbook: MacBook?
    
    init(name: String, macbook: MacBook?) {
        self.name = name
        self.macbook = macbook
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}


class MacBook {
    
    let name: String
    weak var owner: Person?
    
    init(name: String, owner: Person?) {
        self.name = name
        self.owner = owner
    }
    
    deinit {
        print("Macbook named \(name) is being deinitialized")
    }
}

class AnyViewController {
    
    var sean: Person?
    var matilda: MacBook?
    
    init() {
        createObjects()
        assignProperties()
    }
    
    func createObjects() {
        sean = Person(name: "Sean", macbook: nil)
        matilda = MacBook(name: "Matilda", owner: nil)
    }
    
    func assignProperties() {
        sean?.macbook = matilda
        matilda?.owner = sean
        
        sean = nil
        matilda = nil
    }
}

AnyViewController()
