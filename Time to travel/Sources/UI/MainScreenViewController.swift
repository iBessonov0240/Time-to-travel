//
//  MainScreenViewController.swift
//  Time to travel
//
//  Created by i0240 on 20.09.2023.
//

import UIKit

protocol MainScreenViewControllerDelegate: AnyObject {
    func updateLikeState(_ flight: MockTravelDataDetails) -> MockTravelDataDetails?
}

class MainScreenViewController: UIViewController {

    private var travelData: [MockTravelDataDetails]?

    // MARK: - Outlets

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var travelTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: "travelCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loader()
        setupUI()
        setupHierarchy()
        setupLayout()
    }

// MARK: - ссылка не работает
    private func loader() {
        activityIndicator.startAnimating()
        // если будем грузить с реальным API

//        NetworkManager.shared.makeAPIRequest { [weak self] result in
//            DispatchQueue.main.async {
//                self?.activityIndicator.stopAnimating()
//                switch result {
//                case .success(let travelData):
//                    self?.travelData = travelData.data
//                    self?.travelTableView.reloadData()
//                case .failure(let error):
//                    print(error.rawValue)
//                }
//            }
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.travelData = MockTravelDataDetails.items
            self?.travelTableView.isHidden = false
            self?.travelTableView.reloadData()
        }
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Travels"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupHierarchy() {
        view.addSubview(activityIndicator)
        view.addSubview(travelTableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            travelTableView.topAnchor.constraint(equalTo: view.topAnchor),
            travelTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            travelTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            travelTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travelData?.count ?? 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath) as? MainScreenTableViewCell
        cell?.travel = travelData?[indexPath.row]
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailsViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        if let travel = travelData?[indexPath.row] {
            viewController.travel = travel
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - DetailsViewControllerDelegate
extension MainScreenViewController: MainScreenViewControllerDelegate {
    func updateLikeState(_ flight: MockTravelDataDetails) -> MockTravelDataDetails? {
        if let index = travelData?.firstIndex(where: { $0.cityFrom == flight.cityFrom }) {
            travelData?[index].isLiked.toggle()
            travelTableView.reloadData()
            return travelData?[index]
        }
        return nil
    }
}
