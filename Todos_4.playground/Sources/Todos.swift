

import Foundation



public class Todos {
    public var body : String?
    public var done : String?
    public var id : Int?
    public var priority : Int?
    public var title : String?
    
    public init(){}
    
    
    public var asDictionary: [String:AnyObject] {
        
        var dictionary = [String:AnyObject]()
        
        dictionary["body"] = body
        dictionary["done"] = done
        dictionary["id"] = id
        dictionary["priority"] = priority
        dictionary["title"] = title
        return dictionary
    }
}