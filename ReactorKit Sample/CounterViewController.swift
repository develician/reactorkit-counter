//
//  CounterViewController.swift
//  ReactorKit Sample
//
//  Created by killi8n on 2018. 8. 25..
//  Copyright © 2018년 killi8n. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift
import SnapKit

class CounterViewController: UIViewController, StoryboardView {
    
    let reactor: CounterViewReactor = CounterViewReactor()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    let increaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.semibold)
        return button
    }()
    
    let decreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.semibold)
        return button
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.semibold)
        return label
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.startAnimating()
        return view
    }()
    
    lazy var counterStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [decreaseButton, valueLabel, increaseButton])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .center
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        bind(reactor: reactor)
        
    }
    
    func setup() {
        addComponentsToView()
        setupComponents()
    }
    
    func addComponentsToView() {
        view.addSubview(counterStackView)
        view.addSubview(activityIndicatorView)
    }
    
    func setupComponents() {
        view.backgroundColor = .white
        counterStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().offset(16)
            make.height.equalTo(50)
        }
        activityIndicatorView.snp.makeConstraints { (make) in
            make.top.equalTo(counterStackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            
            
        }
        
        
    }


}

extension CounterViewController {
    func bind(reactor: CounterViewReactor) {
        
        
        reactor.state.asObservable().map { "\($0.value)" }
            .distinctUntilChanged()
            .bind(to: self.valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.asObservable().map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        increaseButton.rx.tap               // Tap event
            .map { Reactor.Action.increase }  // Convert to Action.increase
            .bind(to: reactor.action)         // Bind to reactor.action
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
}
