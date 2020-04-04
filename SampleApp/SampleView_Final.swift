//
//  SampleView_Final.swift
//  SampleApp
//
//  Created by Hyuntak Joo on 2020/03/28.
//  Copyright © 2020 Hyuntak Joo. All rights reserved.
//

import SwiftUI

struct SampleView_Final: View {

  @ObservedObject private var viewModel: ObservableSampleViewModel
  
  init(viewModel: SampleViewModelType) {
    self.viewModel = .init(viewModel)
  }

  var body: some View {
    Button(action: viewModel.inputs.buttonTapped) {
      Text(viewModel.outputs.title)
    }
  }
}

struct SampleView_Final_Previews: PreviewProvider {
  static var previews: some View {
    SampleView_Final(viewModel: SampleViewModel())
  }
}

private typealias ObservableSampleViewModel = ObservableViewModel<SampleViewModelInputs, SampleViewModelOutputs>
extension ObservableSampleViewModel {
  convenience init(_ viewModel: SampleViewModelType) {
    self.init(inputs: viewModel.inputs, outputs: viewModel.outputs)
    outputs.bind(\.title)
  }
}
