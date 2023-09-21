//
//  DetailsViewController.swift
//  Time to travel
//
//  Created by i0240 on 21.09.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    weak var delegate: MainScreenViewControllerDelegate? = nil
    
    var travel: MockTravelDataDetails? {
        didSet {
            departureCityLabel.text = travel?.cityFrom
            arrivalCityLabel.text = travel?.cityTo
            priceLabel.text = "\(travel?.price ?? 0) RUB"
            favoriteButton.isSelected = travel?.isLiked ?? false

            if let modifiedDepartureDate = travel?.departureDate, let modifiedArrivalDate = travel?.returnDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                if let formattedDepartureDate = dateFormatter.date(from: modifiedDepartureDate), let formattedArrivalDate = dateFormatter.date(from: modifiedArrivalDate) {
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    let dateDepartureString = dateFormatter.string(from: formattedDepartureDate)
                    let dateArrivalString = dateFormatter.string(from: formattedArrivalDate)
                    departureDateLabel.text = dateDepartureString
                    arrivalDateLabel.text = dateArrivalString
                }
            } else {
                departureDateLabel.text = ""
            }
        }
    }
    
    // MARK: - Outlets
    
    private lazy var departureCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()

    private lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()

    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.up.arrow.down")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var arrivalCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()

    private lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        button.addTarget(nil, action: #selector(changeFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(departureCityLabel)
        view.addSubview(departureDateLabel)
        view.addSubview(arrowImage)
        view.addSubview(arrivalCityLabel)
        view.addSubview(arrivalDateLabel)
        view.addSubview(priceLabel)
        view.addSubview(favoriteButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            departureCityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            departureCityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            departureDateLabel.topAnchor.constraint(equalTo: departureCityLabel.bottomAnchor, constant: 15),
            departureDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            arrowImage.topAnchor.constraint(equalTo: departureDateLabel.bottomAnchor, constant: 125),
            arrowImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 100),
            arrowImage.widthAnchor.constraint(equalToConstant: 30),

            arrivalCityLabel.topAnchor.constraint(equalTo: arrowImage.bottomAnchor, constant: 125),
            arrivalCityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            arrivalDateLabel.topAnchor.constraint(equalTo: arrivalCityLabel.bottomAnchor, constant: 15),
            arrivalDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            priceLabel.centerYAnchor.constraint(equalTo: arrowImage.centerYAnchor),

            favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            favoriteButton.centerYAnchor.constraint(equalTo: arrowImage.centerYAnchor)
        ])
    }

    //MARK: - Actions

    @objc func changeFavorite() {
        favoriteButton.isSelected.toggle()
        
        if let travel = travel, let selectedTravel = delegate?.updateLikeState(travel) {
            self.travel = selectedTravel
        }
    }
}
