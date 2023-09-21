//
//  MainScreenTableViewCell.swift
//  Time to travel
//
//  Created by i0240 on 21.09.2023.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {

    weak var delegate: MainScreenViewControllerDelegate?

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
        button.isSelected = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        button.addTarget(nil, action: #selector(changeFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.travel = nil
    }

    // MARK: - Setup

    private func setupHierarchy() {
        contentView.addSubview(departureCityLabel)
        contentView.addSubview(departureDateLabel)
        contentView.addSubview(arrivalCityLabel)
        contentView.addSubview(arrivalDateLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(favoriteButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            departureCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            departureCityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),

            departureDateLabel.topAnchor.constraint(equalTo: departureCityLabel.bottomAnchor, constant: 15),
            departureDateLabel.leadingAnchor.constraint(equalTo: departureCityLabel.leadingAnchor),

            arrivalCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            arrivalCityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

            arrivalDateLabel.topAnchor.constraint(equalTo: arrivalCityLabel.bottomAnchor, constant: 15),
            arrivalDateLabel.trailingAnchor.constraint(equalTo: arrivalCityLabel.trailingAnchor),

            priceLabel.topAnchor.constraint(equalTo: departureDateLabel.bottomAnchor, constant: 25),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),

            favoriteButton.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            favoriteButton.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),

            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

// MARK: - Actions

    @objc func changeFavorite() {
        favoriteButton.isSelected.toggle()

        if let travel = travel, let selectedTravel = delegate?.updateLikeState(travel) {
            self.travel = selectedTravel
        }
    }
}
