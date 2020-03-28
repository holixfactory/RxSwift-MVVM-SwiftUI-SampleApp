//
//  SampleViewController.swift
//  SampleApp
//
//  Created by Hyuntak Joo on 2020/03/28.
//  Copyright © 2020 Hyuntak Joo. All rights reserved.
//

import UIKit
import RxSwift

final class SampleViewController: UIViewController {
  private let viewModel: SampleViewModelType
  init(viewModel: SampleViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    let button = UIButton()
    button.frame = .init(x: 100, y: 100, width: 100, height: 100)
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    view.addSubview(button)

    viewModel.outputs.title
      .drive(button.rx.title())
      .disposed(by: disposeBag)
  }

  @IBAction func buttonTapped() {
    viewModel.inputs.buttonTapped()
  }
}
