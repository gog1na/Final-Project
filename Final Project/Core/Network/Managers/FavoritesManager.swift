//
//  FavoritesManager.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 4/4/23.
//

import UIKit
import CoreData

class FavoritesManager {
    public static let sharedInstance = FavoritesManager()
    
    func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    //MARK: - Cocktail
    
    func isFavorite(cocktailName: String) -> Bool {
        guard let managedContext = getContext() else { return false }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CocktailsCore")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "name == %@" ,NSString(string: cocktailName))
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                // Assuming there will only ever be one User in the app.
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Error in checking Favorite Cocktails :@", error.debugDescription)
            return false
        }
    }
    
    func toggleFavorite(cocktail: CocktailsCore) {
        if isFavorite(cocktailName: cocktail.name ?? "") {
            saveInFavorites(cocktail: cocktail)
        } else {
            removeFromFavorite(cocktail: cocktail.name ?? "")
        }
    }
    
    func removeFromFavorite(cocktail: String) {
        guard let managedContext = getContext() else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CocktailsCore")
        fetchRequest.predicate = NSPredicate(format: "name == %@" ,NSString(string: cocktail))
        if let result = try? managedContext.fetch(fetchRequest) {
            for object in result {
                managedContext.delete(object)
            }
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Error in deleting cocktail ", error.localizedDescription)
        }
    }
    
    func saveInFavorites(cocktail: CocktailsCore) {
        guard let managedContext = getContext() else { return }
        managedContext.insert(cocktail)
        do {
            print("Saving session...")
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save session data! Cocktail \(error): \(error.userInfo)")
        }
    }
    
    func getFavoriteCocktails() -> [CocktailsCore] {
        guard let managedContext = getContext() else { return [] }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CocktailsCore")
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                // Assuming there will only ever be one User in the app.
                return result as! [CocktailsCore]
            } else {
                return []
            }
        } catch let error as NSError {
            print("Error in Getting Favorite Cocktails :@", error.debugDescription)
            return []
        }
        
    }
    
    func getDrink(from cocktailCore: CocktailsCore) -> Drink {
        return Drink(name: cocktailCore.name, image: cocktailCore.image, ingredients: cocktailCore.ingredient?.components(separatedBy: "-"), instructions: cocktailCore.instruction)
    }
    
    
    //MARK: - Meal
    
    func isFavorite(mealName: String) -> Bool {
        guard let managedContext = getContext() else { return false }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MealCore")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "name == %@" ,NSString(string: mealName))
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                // Assuming there will only ever be one User in the app.
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Error in checking Favorite Meals :@", error.debugDescription)
            return false
        }
    }
    
    func toggleFavorite(meal: MealCore) {
        if isFavorite(mealName: meal.name ?? "") {
            saveInFavorites(meal: meal)
        } else {
            removeFromFavorite(meal: meal.name ?? "")
        }
    }
    
    func removeFromFavorite(meal: String) {
        guard let managedContext = getContext() else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MealCore")
        fetchRequest.predicate = NSPredicate(format: "name == %@" ,NSString(string: meal))
        if let result = try? managedContext.fetch(fetchRequest) {
            for object in result {
                managedContext.delete(object)
            }
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Error in deleting meal ", error.localizedDescription)
        }
    }
    
    func saveInFavorites(meal: MealCore) {
        guard let managedContext = getContext() else { return }
        managedContext.insert(meal)
        do {
            print("Saving session...")
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save session data! Meal \(error): \(error.userInfo)")
        }
    }
    
    func getFavoriteMeals() -> [MealCore] {
        guard let managedContext = getContext() else { return [] }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MealCore")
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                // Assuming there will only ever be one User in the app.
                return result as! [MealCore]
            } else {
                return []
            }
        } catch let error as NSError {
            print("Error in Getting Favorite Meals :@", error.debugDescription)
            return []
        }
        
    }
    
    func getMeal(from mealCore: MealCore) -> Meal {
        return Meal(name: mealCore.name, image: mealCore.image, ingredients: mealCore.ingredient?.components(separatedBy: "-"), instructions: mealCore.instruction?.components(separatedBy: "-"), calories: Int(mealCore.calories))
    }
    
    
    
    
    //MARK: - Georgian
    
    func isFavorite(georgianName: String) -> Bool {
        guard let managedContext = getContext() else { return false }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GeorgianCore")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "name == %@" ,NSString(string: georgianName))
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                // Assuming there will only ever be one User in the app.
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Error in checking Favorite Georgian :@", error.debugDescription)
            return false
        }
    }
    
    func toggleFavorite(georgian: GeorgianCore) {
        if isFavorite(georgianName: georgian.name ?? "") {
            saveInFavorites(georgian: georgian)
        } else {
            removeFromFavorite(georgian: georgian.name ?? "")
        }
    }
    
    func removeFromFavorite(georgian: String) {
        guard let managedContext = getContext() else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GeorgianCore")
        fetchRequest.predicate = NSPredicate(format: "name == %@" ,NSString(string: georgian))
        if let result = try? managedContext.fetch(fetchRequest) {
            for object in result {
                managedContext.delete(object)
            }
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Error in deleting georgian ", error.localizedDescription)
        }
    }
    
    func saveInFavorites(georgian: GeorgianCore) {
        guard let managedContext = getContext() else { return }
        managedContext.insert(georgian)
        do {
            print("Saving session...")
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save session data! Georgian \(error): \(error.userInfo)")
        }
    }
    
    func getFavoriteGeorgian() -> [GeorgianCore] {
        guard let managedContext = getContext() else { return [] }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GeorgianCore")
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                // Assuming there will only ever be one User in the app.
                return result as! [GeorgianCore]
            } else {
                return []
            }
        } catch let error as NSError {
            print("Error in Getting Favorite Meals :@", error.debugDescription)
            return []
        }
        
    }
    
    func getGeorgian(from georgianCore: GeorgianCore) -> Georgian {
        return Georgian(name: georgianCore.name, image: georgianCore.image, video: georgianCore.video, cal: Int(georgianCore.calories), ingredients: georgianCore.ingredient?.components(separatedBy: "-"), instructions: georgianCore.instruction?.components(separatedBy: "-"))
    }
    
}
