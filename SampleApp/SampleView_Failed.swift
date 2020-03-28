//
//  SampleView_Failed.swift
//  SampleApp
//
//  Created by Hyuntak Joo on 2020/03/28.
//  Copyright © 2020 Hyuntak Joo. All rights reserved.
//

import SwiftUI
import RxSwift

struct SampleView_Failed: View {
  private let viewModel: SampleViewModelType
  private let disposeBag = DisposeBag()

  init(viewModel: SampleViewModelType) {
    self.viewModel = viewModel
    bindViewModel()
  }
  
  func bindViewModel() {
    viewModel.outputs.title
      .drive(onNext: { self.title = $0 })
      .disposed(by: disposeBag)
  }

  @State var title: String = "Default title" {
    didSet { print("title did set: \(title)") }
  }

  var body: some View {
    Button(action: viewModel.inputs.buttonTapped) {
      Text(title)
    }
  }
}

struct SampleView_Failed_Previews: PreviewProvider {
  static var previews: some View {
    SampleView_Failed(viewModel: SampleViewModel())
  }
}
