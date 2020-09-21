//
//  HotWaterShutoffHotWaterShutoffConfigurator.swift
//  GovermentServices
//
//  Created by Holyberry on 20/09/2020.
//  Copyright © 2020 Gulnaz Almukhametova. All rights reserved.
//

import UIKit

class HotWaterShutoffModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        
        if let viewController = viewInput as? HotWaterShutoffViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: HotWaterShutoffViewController) {
        let presenter = HotWaterShutoffPresenter()
        
        presenter.view = viewController
        
        let interactor = HotWaterShutoffInteractor(service: ApiProvider(fileService: DefaultFileService()),
                                                   storage: CoreDataStorage(),
                                                   output: HotWaterShutoffPresenter())
        interactor.output = presenter
        
        presenter.interactor = interactor
        
        viewController.output = presenter
    }
    
}
