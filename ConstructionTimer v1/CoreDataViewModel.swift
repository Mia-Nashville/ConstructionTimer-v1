//
//  CoreDataViewModel.swift
//  ConstructionTimer v1
//
//  Created by Satoshi Mitsumori on 3/4/24.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let persistentContainer: NSPersistentContainer
    let dateFormatter = DateFormatter()
    
    @Published var savedEntities = [JikanEntity]()
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataContainer")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data storage failed \(error.localizedDescription)")
            }
        }
        fetchDelayTime()
    }
    
    func addDelayTime(topic: String, delay: String, start: String) {
        let newDelay = JikanEntity(context: persistentContainer.viewContext)
        newDelay.topic = topic
        newDelay.delay = delay
        newDelay.start = start
          
        print(newDelay.topic ?? "")
        print(newDelay.delay ?? "")
       
        print(newDelay.start ?? "")
  
        saveDelayTime()
    }

    func endDelayTime(endTime: String) {
        let endDelay = JikanEntity(context: persistentContainer.viewContext)
        endDelay.endTime = endTime
        
        print(endDelay.endTime ?? "")
        
        saveDelayTime()
    }
    
    func saveDelayTime() {
        do {
            try persistentContainer.viewContext.save()
            
            fetchDelayTime()
            
        } catch let error {
            print("Error Saving Data \(error)")
        }
    }
    
    func fetchDelayTime() {
        let fetchRequest = NSFetchRequest<JikanEntity>(entityName: "JikanEntity")
        
        do {
            savedEntities = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error fetching \(error)")
        }
    }
}
