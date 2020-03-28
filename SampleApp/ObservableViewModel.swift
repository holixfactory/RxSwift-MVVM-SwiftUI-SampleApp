//
//  ObservableViewModel.swift
//  SampleApp
//
//  Created by Hyuntak Joo on 2020/03/28.
//  Copyright © 2020 Hyuntak Joo. All rights reserved.
//

import SwiftUI
import Combine
import RxSwift
import RxCocoa

final class ObservableViewModel<ViewModelInputs, ViewModelOutputs>: ObservableObject {
  let inputs: ViewModelInputs
  let outputs: ObservableOutputs<ViewModelOutputs>

  private var cancellables = Set<AnyCancellable>()
  
  init(inputs: ViewModelInputs, outputs: ViewModelOutputs) {
    self.inputs = inputs
    self.outputs = .init(outputs)
    self.outputs.objectWillChange
      .sink(receiveValue: objectWillChange.send)
      .store(in: &cancellables)
  }
}

extension ObservableViewModel {
  @dynamicMemberLookup
  final class ObservableOutputs<ViewModelOutputs>: ObservableObject {
    private let outputs: ViewModelOutputs
    init(_ outputs: ViewModelOutputs) {
      self.outputs = outputs
    }
    
    @Published private var values: [AnyHashable: Any] = [:]
    private let disposeBag = DisposeBag()
    
    subscript<O: ObservableConvertibleType>(dynamicMember keyPath: KeyPath<ViewModelOutputs, O>) -> O.Element? {
      if let value = values[keyPath] as? O.Element {
        return value
      }
      outputs[keyPath: keyPath]
        .asObservable()
        .subscribe(onNext: { [weak self] value in
          self?.values[keyPath] = value
        })
        .disposed(by: disposeBag)
      return nil
    }
  }
}
