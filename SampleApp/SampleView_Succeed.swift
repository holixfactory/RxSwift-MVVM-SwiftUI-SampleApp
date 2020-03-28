//
//  SampleView_Succeed.swift
//  SampleApp
//
//  Created by Hyuntak Joo on 2020/03/28.
//  Copyright © 2020 Hyuntak Joo. All rights reserved.
//

import SwiftUI
import RxSwift


struct SampleView_Succeed: View {

  @ObservedObject private var viewModel: ViewModel
  
  init(viewModel: SampleViewModelType) {
    self.viewModel = .init(viewModel)
  }

  var body: some View {
    Button(action: viewModel.inputs.buttonTapped) {
      Text(viewModel.outputs.title)
    }
  }
}

struct SampleView_Succeed_Previews: PreviewProvider {
  static var previews: some View {
    SampleView_Succeed(viewModel: SampleViewModel())
  }
}

extension SampleView_Succeed {
  struct Outputs {
    var title: String = ""
  }

  private final class ViewModel: NSObject, ObservableObject {
    let inputs: SampleViewModelInputs
    @Published var outputs = Outputs()

    private let disposeBag = DisposeBag()

    init(_ viewModel: SampleViewModelType) {
      self.inputs = viewModel.inputs
      super.init()
      
      viewModel.outputs.title
        .do(onNext: { _ in print(self.outputs) })
        .drive(rx[\.outputs.title])
        .disposed(by: disposeBag)
    }
  }
}
