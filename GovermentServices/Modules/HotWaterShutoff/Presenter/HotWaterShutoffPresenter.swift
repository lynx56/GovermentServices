//
//  HotWaterShutoffHotWaterShutoffPresenter.swift
//  GovermentServices
//
//  Created by Holyberry on 20/09/2020.
//  Copyright © 2020 Gulnaz Almukhametova. All rights reserved.
//

import Foundation

class HotWaterShutoffPresenter: HotWaterShutoffViewOutput, HotWaterShutoffInteractorOutput {
    
    weak var view: HotWaterShutoffViewInput!
    
    var interactor: HotWaterShutoffInteractorInput!

    private var models: [AddressModel] = []
    
    private var filterCondition: FilterCondition?

    func viewIsReady() {
        loadHotWaterShutoffSchedule()
    }

    private func loadHotWaterShutoffSchedule() {
        view.startLoading()
        interactor.loadHotWaterShutoffSchedule()
    }
    
    func didRecieveSchedule(schedule: Schedule) {
        models = schedule.map(scheduleToAddressModelConverter)
        view.stopLoading()
        view.reloadData()
    }
    
    func didRecieveCachedSchedule(schedule: Schedule, error: Error, lastUpdate: Date) {
        didRecieveSchedule(schedule: schedule)
    }
    
    func didRecievedError(error: DataProviderError) {
        view.stopLoading()
        
        switch error {
        case .dataError:
            view.showError(L10n.HotWaterShutoff.Errors.dataError)
        case .networkError:
            view.showError(L10n.HotWaterShutoff.Errors.networkError)
        }
    }
    
    func startRefreshing() {
        loadHotWaterShutoffSchedule()
    }
    
    func getViewModels() -> [AddressModel] {
        if let filter = filterCondition {
            return models.filter(filter)
        }
        
        return models
    }
    
    func didSearch(_ searchText: String) {
        filterCondition = !searchText.isEmpty ? { $0.street.contains(searchText) } : nil
        view.reloadData()
    }
    
    func didCancelSearch() {
        filterCondition = nil
        view.reloadData()
    }
    
    func didTapRetry() {
        loadHotWaterShutoffSchedule()
    }
        
    private lazy var dateIntervalFormatter: DateIntervalFormatter = {
        let formater = DateIntervalFormatter()
        formater.dateTemplate = "dd MMMM yyyy"
        formater.dateStyle = .long
        formater.timeStyle = .none
        return formater
    }()
    
    private var scheduleToAddressModelConverter: (ScheduleItem) -> AddressModel {
        return { [unowned self] item in
            
            let corpus = [L10n.HotWaterShutoff.corpus, item.corpus].conditionalJoin { return $0.last?.isEmpty == false }
            let litera = [L10n.HotWaterShutoff.litera, item.liter].conditionalJoin { return $0.last?.isEmpty == false }
            let subaddress = [L10n.HotWaterShutoff.house, item.house, corpus, litera].joined(separator: " ")
            
            let dates: String
            let image: String
            switch item.date {
            case .saved:
                dates = L10n.HotWaterShutoff.hotWaterNotShutoff
                image = Images.bath.name
            case .dates(let interval):
                dates = self.dateIntervalFormatter.string(from: interval.start, to: interval.end)
                image = Images.basin.name
            }
            
            return AddressModel(city: item.city,
                                street: item.address.trimmingCharacters(in: .whitespaces),
                                house: subaddress,
                                hotWaterStatus: dates,
                                image: image)
            
        }
    }
}


extension HotWaterShutoffPresenter {
    typealias FilterCondition = (AddressModel) -> Bool
}
