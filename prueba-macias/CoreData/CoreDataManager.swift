//
//  CoreDataManager.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 14/11/21.
//

import Foundation
import CoreData

class CoreDataManager {
    private let container: NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "prueba_macias")
        setupDatabase()
        
    }
    private func setupDatabase() {
        //4
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading store \(desc) — \(error)")
                return
            }
            print("Database ready!")
        }
    }
    
    
    // CREAR USUARIO
    func createEmployee(user: UserModel, completion: @escaping() -> Void) {
        
        let context = container.viewContext
      
        let userTmp = User(context: context)
        userTmp.id = user.id
        userTmp.names = user.names
        userTmp.lastNames = user.lastNames
        userTmp.email = user.email
        userTmp.username = user.username
        userTmp.password = user.password
        userTmp.role = user.role
        
        do {
            try context.save()
            print("Usuario \(userTmp.names) guardado")
            completion()
        } catch {
         
          print("Error guardando usuario — \(error)")
        }
    }
    
    func login(_ username: String, _ password: String) -> User?{
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        fetchRequest.predicate = predicate
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            if results.count > 0 {
                return results[0]
            } else {
                return nil
            }
        } catch let error as NSError {
            print("No ha sido posible cargar \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func fetchUsers() -> [User] {
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print("El error obteniendo usuario(s) \(error)")
         }
         return []
    }
    
    func getEmployees() -> [User]{
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "role = %@", "E")
        fetchRequest.predicate = predicate
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("No ha sido posible cargar \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                container.viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func deleteSingleData(_ entity:String, _ id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let predicate = NSPredicate(format: "id == %@", id)
            fetchRequest.predicate = predicate
        do {
            let result = try? container.viewContext.fetch(fetchRequest)
            let resultData = result as! [User]
        
            for object in resultData {
                container.viewContext.delete(object)
            }
            // Save Changes
            try container.viewContext.save()
            return true
        }catch let error{
            print("Detele error :", error)
            return false
        }
    }
    
    func updateEmployee(_ id: String, _ userModel: UserModel) -> Bool? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        do {
            let user = try container.viewContext.fetch(fetchRequest)
            let obj = user[0] as! NSManagedObject
            obj.setValue(userModel.ubication, forKey: "ubication")
            obj.setValue(userModel.phoneNumber, forKey: "phoneNumber")
            obj.setValue(userModel.vaccunatedState, forKey: "vaccunatedState")
            do {
                try container.viewContext.save()
                return true
            } catch _ {
                return nil
            }
            
        } catch let error {
            print("Update error :", error)
            return nil
        }
    }
    

}
