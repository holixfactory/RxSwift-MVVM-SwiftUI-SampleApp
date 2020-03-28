//
//  SampleViewModel.swift
//  SampleApp
//
//  Created by Hyuntak Joo on 2020/03/28.
//  Copyright © 2020 Hyuntak Joo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SampleViewModelInputs {
  func buttonTapped()
}

protocol SampleViewModelOutputs {
  var title: Driver<String> { get }
}

protocol SampleViewModelType {
  var inputs: SampleViewModelInputs { get }
  var outputs: SampleViewModelOutputs { get }
}

final class SampleViewModel: SampleViewModelType,
SampleViewModelInputs,
SampleViewModelOutputs {
  var inputs: SampleViewModelInputs { self }
  var outputs: SampleViewModelOutputs { self }
  
  let title: Driver<String>
  init() {
    title = Driver.merge(
      .just("Default title"),
      buttonTappedProperty
        .map { _ in "Tapped" }
        .asDriver(onErrorJustReturn: "")
    )
  }
  
  private let buttonTappedProperty = PublishSubject<Void>()
  func buttonTapped() {
    buttonTappedProperty.on(.next(()))
  }
}
