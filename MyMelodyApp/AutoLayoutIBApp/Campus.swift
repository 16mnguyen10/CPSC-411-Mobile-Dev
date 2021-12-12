//
//  Campus.swift
//
//
//  Created by Michael Nguyen on 10/19/21.
//

enum Gender : String {
    case female = "female"
    case male = "male"
}

// Struct can't inherit
struct PersonDO {
    var firstName : String
    var middleName : String?
    var lastName : String
    var gender : Gender
    var age : Int!
}

var personDO = PersonDO(firstName:"Michael", lastName:"Nguyen", gender:Gender.male)

class Person {
    // Stored Properties
    var firstName : String
    var middleName : String?
    var lastName : String
    var gender : Gender
    var age : Int!
    
    /*
    // Designated Initializer (Constructor)
    init(_ fn : String, _ ln : String, mn : String? = nil) {
        firstName = fn
        lastName = ln
    }
    */
    // Computed Properties
    // Option 1: Getter
    var fullName : String {
        get {
            if let m = middleName {
                return "\(firstName) \(m) \(lastName)"
            }
            else {
                return "\(firstName) \(lastName)"
            }
        }
    }
    
    // Option 2: Define-and-Call
    lazy var fullName1 : String = {()->String in
        if let m = middleName {
            return "\(firstName) \(m) \(lastName)"
        }
        else {
            return "\(firstName) \(lastName)"
        }
    }()
    
    // Failable Designated Initializer
    init?(_ fn : String, _ ln : String, mn : String? = nil, g : Gender)
    {
        if fn.isEmpty || ln.isEmpty {
            return nil
        }
        firstName = fn
        lastName = ln
        gender = g
        
    }
    
    
    // Convenience Initializer
    convenience init?(_ ln : String, g : Gender) {
        self.init("N/A", ln, g : g)
    }
    
    func getLabel() -> String {
        let title : String
        switch gender {
            case .female : title = "Ms. "
            case .male : title = "Mr. "
        }
        let label = "\(title) \(fullName)"
        return label
    }
}

class CampusMember : Person {
    var cwid : Int
    
    // Designated Initializer
    init?(_ fn : String, _ ln : String, mn : String? = nil, g : Gender, id : Int) {
        cwid = id
        // Call Parent
        super.init(fn, ln, g : g)
    }
    
    override func getLabel()->String {
        let label = "\(super.getLabel()) \(cwid)"
        return label
    }
}

class Student : CampusMember {
    var yearGrad : Int!
    var major : Department!
    var minor : Department?
 
    func major(m : String){
        if let d = CSUF.departments[m] {
            major = d
            if d.students != nil {
                d.students.append(self)
            }
            else {
                d.students = [Student]()
                d.students.append(self)
            }
        }
    }
}

class Department {
    var name : String
    var students : [Student]!
    init(_ n : String) {
        name = n
    }
}

// Singleton Object
class CSUF {
    static var departments : [String : Department] = {
        var dList = [String : Department]()
        dList["Math"] = Department("Math")
        dList["CS"] = Department("CS")
        return dList
    }()
}

var csDeptObj = CSUF.departments["CS"]

