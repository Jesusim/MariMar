//
//  ClockPresenter.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

protocol ClockViewOutput {
    
}

final class ClockPresenter: ClockViewOutput {
    
    private var viewInput: ClockViewInput?
    private let coordinator: ClockCoordinating
    
    init(
        viewInput: ClockViewInput,
        coordinator: ClockCoordinating
    ) {
        self.viewInput = viewInput
        self.coordinator = coordinator
    }
    
}
