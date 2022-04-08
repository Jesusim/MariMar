//
//  HomePresenter.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

protocol HomeViewOutput {
    
}

final class HomePresenter: HomeViewOutput {
    
    private var viewInput: HomeViewInput?
    private let coordinator: HomeCoordinating
    
    init(
        viewInput: HomeViewInput,
        coordinator: HomeCoordinating
    ) {
        self.viewInput = viewInput
        self.coordinator = coordinator
    }
    
}
