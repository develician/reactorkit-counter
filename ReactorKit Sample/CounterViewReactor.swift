//
//  CounterViewReactor.swift
//  ReactorKit Sample
//
//  Created by killi8n on 2018. 8. 25..
//  Copyright © 2018년 killi8n. All rights reserved.
//

import ReactorKit
import RxSwift

final class CounterViewReactor: Reactor {
    
    enum Action {
        case increase
        case decrease
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    struct State {
        var value: Int
        var isLoading: Bool
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(value: 0, isLoading: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increaseValue).delay(0.5, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
                ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue).delay(0.5, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
                ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .increaseValue:
            state.value += 1
        case .decreaseValue:
            state.value -= 1
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
