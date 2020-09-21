//
//  File.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import CoreData

class CoreDataStorage {
    private let modelName: String
    
    private lazy var storeConatiner: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                print("Unresolved error: \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    private lazy var managedContext: NSManagedObjectContext = {
        return self.storeConatiner.viewContext
    }()
    
    private lazy var privateContext: NSManagedObjectContext = {
        let ctx = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        ctx.parent = self.managedContext
        ctx.automaticallyMergesChangesFromParent = true
        return ctx
    }()
    
    init(modelName: String = "Model") {
        self.modelName = modelName
    }
    
    func saveContext(_ context: NSManagedObjectContext, completion: SaveCompletion? = nil) {
        guard context.hasChanges else { completion?(.success(false)); return }
        
        context.perform {
            do {
                try context.save()
                
                guard let parentContext = context.parent else { completion?(.success(true)); return }
                
                parentContext.performAndWait {
                    do {
                        try parentContext.save()
                        completion?(.success(true))
                    } catch {
                        parentContext.rollback()
                        completion?(.failure(.savingNotComplete))
                    }
                }
            } catch {
                context.rollback()
                completion?(.failure(.savingNotComplete))
            }
        }
    }
}


extension CoreDataStorage: DataStorage {
     
    func saveHotWaterShutoffSchedule(_ schedule: Schedule, completionHandler: SaveCompletion?) {
        privateContext.perform {
            let fetch: NSFetchRequest<ScheduleItemMO> = ScheduleItemMO.fetchRequest()
            
            let results = try? self.privateContext.fetch(fetch)
           
            if results != nil, results!.count > 0 {
                try? self.deleteAllData()
            }
            
            for scheduleItem in schedule {
                let item = ScheduleItemMO(context: self.privateContext)
                item.city = scheduleItem.city
                item.city = scheduleItem.city
                item.corpus = scheduleItem.corpus
                item.house = scheduleItem.house
                item.litera = scheduleItem.liter
                item.street = scheduleItem.address
                item.createdDate = Date()
                if case let .dates(intervals) = scheduleItem.date {
                    item.dateFrom = intervals.start
                    item.dateTo = intervals.end
                }
            }
            
            self.saveContext(self.privateContext, completion: completionHandler)
        }
    }
    
    func hotWaterShutoffSchedule() -> (Schedule, Date)? {
        let scheduleMO: NSFetchRequest<ScheduleItemMO> = ScheduleItemMO.fetchRequest()
        guard let savedSchedule = try? privateContext.fetch(scheduleMO), let first = savedSchedule.first else { return nil }
        
        let schedule = savedSchedule.map { (saved) -> ScheduleItem in
            let dates: DatePeriod
            if let from = saved.dateFrom, let to = saved.dateTo {
                dates = .dates(.init(start: from, end: to))
            } else {
                dates = .saved
            }
            
            return ScheduleItem(city: saved.city!,
                                address: saved.street!,
                                house: saved.house!,
                                corpus: saved.corpus!,
                                liter: saved.litera!,
                                date: dates)
        }
        
        return (schedule, first.createdDate!)
    }
    
    private func deleteAllData() throws {
        let request: NSFetchRequest<NSFetchRequestResult> = ScheduleItemMO.fetchRequest()
        
        let deleteAllRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        try managedContext.execute(deleteAllRequest)
    }
}
