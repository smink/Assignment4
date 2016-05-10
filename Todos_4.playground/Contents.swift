/*:

Based on Sessions 1-15 (specifically Protocols, Extensions, Generics, JSON & Instances, HTTP & ReST), create a playground that will manage your todos.

You will need to:

Print all your Todos (small description)
Print a single Todo (large description)
Add a Todo
Update a Todo
Delete a Todo
Constraints:

Create a container protocol to store data
Create a data type comforming to your container
Serialize and deserialize the data within your container
Leverage a ReSTful web service to retrieve the todos
Create methods on your manager class to:
Get all your Todos
Get a single Todo passing an id as an argument
Add a Todo
Update a Todo
Delete a Todo
Todo Model has the following properties:

body: String
done: Bool
id: Int
priority: Int
title: String
Host = http://todo.eastus.cloudapp.azure.com

Path = /todo-ios/todos/api/v1.0

Routes

GET todos
GET todo/{id}
POST /todo/create
PUT /todo/update/{id}
DELETE /todo/delete/{id}
Users / Password

cemeh / password
tgebrete / password
tkhalaf / password
jmink2 / password
dsoisson1 / password
cURL Examples:

curl -u msheets:password -H "Accept: application/json" -i http://todo.eastus.cloudapp.azure.com/todo-ios/todos/api/v1.0/todos
curl -u msheets:password -H "Accept: application/json" -i http://todo.eastus.cloudapp.azure.com/todo-ios/todos/api/v1.0/todo/0
curl -u msheets:password -H "Content-Type: application/json" -X POST -d '{"title":"Lunch", "body":"Having lunch", "priority": 3}' -v http://todo.eastus.cloudapp.azure.com/todo-ios/todos/api/v1.0/todo/create
curl -u msheets:password -H "Content-Type: application/json" -X PUT -d '{"title":"Dinner", "body":"Having Dinner", "priority": 2}' -i http://todo.eastus.cloudapp.azure.com/todo-ios/todos/api/v1.0/todo/update/0
curl -u msheets:password -H "Accept: application/json" -X DELETE http://todo.eastus.cloudapp.azure.com/todo-ios/todos/api/v1.0/todo/delete/2

*/

import Foundation
import XCPlayground




var host = "http://todo.eastus.cloudapp.azure.com"

let config = NSURLSessionConfiguration.defaultSessionConfiguration()
let userPasswordString = "jmink2:password"
let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions([])
let authString = "Basic \(base64EncodedCredential)"
config.HTTPAdditionalHeaders = ["Authorization" : authString]
var session = NSURLSession(configuration: config)
//var session = NSURLSession.sharedSession()



var request = NSMutableURLRequest(URL: NSURL(string: "\(host)//todo-ios/todos/api/v1.0/todos")!)
request.HTTPMethod = "GET"
request.addValue("application/json", forHTTPHeaderField: "Content-Type")

var task = session.dataTaskWithRequest(request){ (data, response, error) -> Void in
    if error != nil {
        print(error)
    } else {
        guard (response as? NSHTTPURLResponse)?.statusCode >= 200, let json = data else {
            return
        }
        
        var result = NSString(data: json, encoding: NSASCIIStringEncoding)!
        
        print(result)



        }
}
task.resume()



var newTodo = Todos ()
newTodo.body = "Go to work"
newTodo.done = "false"
//newTodo.id = 3
newTodo.priority = 5
newTodo.title = "Work"
var jsonData = try NSJSONSerialization.dataWithJSONObject(newTodo.asDictionary, options: .PrettyPrinted)

// create a String from the NSData
var jsonString = String(data: jsonData, encoding: NSUTF8StringEncoding)!

//print(jsonString)



/*
 Add a todo
 */
request = NSMutableURLRequest(URL: NSURL(string: "\(host)//todo-ios/todos/api/v1.0/todo/create")!)
request.HTTPMethod = "POST"
request.addValue("application/json", forHTTPHeaderField: "Content-Type")

var jsonPayload = jsonString
request.HTTPBody = jsonPayload.dataUsingEncoding(NSUTF8StringEncoding)

 task = session.dataTaskWithRequest(request){ (data, response, error) -> Void in
    if error != nil {
        print(error)
    } else {
        guard (response as? NSHTTPURLResponse)?.statusCode >= 200, let json = data else {
            return
        }
        
        var result = NSString(data: json, encoding: NSASCIIStringEncoding)!
        
        print(result)
    }
}
task.resume()


newTodo.id = 3
newTodo.body = "Updated go to work"
 jsonData = try NSJSONSerialization.dataWithJSONObject(newTodo.asDictionary, options: .PrettyPrinted)

// create a String from the NSData
 jsonString = String(data: jsonData, encoding: NSUTF8StringEncoding)!
/*
 Add a todo
 */
request = NSMutableURLRequest(URL: NSURL(string: "\(host)//todo-ios/todos/api/v1.0/todo/create")!)
request.HTTPMethod = "POST"
request.addValue("application/json", forHTTPHeaderField: "Content-Type")

 jsonPayload = jsonString
request.HTTPBody = jsonPayload.dataUsingEncoding(NSUTF8StringEncoding)

task = session.dataTaskWithRequest(request){ (data, response, error) -> Void in
    if error != nil {
        print(error)
    } else {
        guard (response as? NSHTTPURLResponse)?.statusCode >= 200, let json = data else {
            return
        }
        
        var result = NSString(data: json, encoding: NSASCIIStringEncoding)!
        
        print(result)
    }
}
task.resume()

// needed to keep the playground page alive in order to see responses
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
