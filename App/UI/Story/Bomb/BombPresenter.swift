//
//  ClockPresenter.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

protocol BombViewOutput {
    
}

final class BombPresenter: BombViewOutput {
    
    private var viewInput: BombViewInput?
    private let coordinator: BombCoordinating
    
    init(
        viewInput: BombViewInput,
        coordinator: BombCoordinating
    ) {
        self.viewInput = viewInput
        self.coordinator = coordinator
    }
    
}
