// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.15;

contract SimpleStorage {
    event AllParcelInformation(
        address sender,
        address currentOwner,
        string tracking,
        string locationCreated
    );

    event AllSenderInformation(
        uint256 senderID,
        string senderName,
        string senderLocation
    );

    address admin;

    struct Sender {
        uint256 senderID;
        string senderName;
        string senderLocation;
    }

    struct Hub {
        address hubID;
        string hubName;
        string hubLocation;
    }

    struct Delivery {
        address deliveryID;
        string deliveryName;
        string deliveryLocation;
    }

    struct Parcel {
        address sender;
        address currentOwner;
        string tracking;
        string locationCreated;
    }

    Parcel[] public allParcels;
    Sender[] public allSenders;

    uint256 senderCount = 0;
    uint256 parcelCount = 0;

    constructor() {
        admin = msg.sender;
    }

    modifier isAdmin() {
        require(admin == msg.sender, "Access denied!");
        _;
    }

    function registration(
        string memory _roles, //make sure on the front end, the options during sign up are 'seller' , 'hub' , or 'delivery'
        string memory _name,
        string memory _location
    ) public {
        if (
            keccak256(abi.encodePacked(_roles)) ==
            keccak256(abi.encodePacked("sender"))
        ) {
            allSenders.push(
                Sender({
                    senderID: senderCount,
                    senderName: _name,
                    senderLocation: _location
                })
            );
        }
    }

    function addParcel(string memory _trackingID, string memory _location)
        public
    {
        allParcels.push(
            Parcel({
                sender: msg.sender,
                currentOwner: msg.sender,
                tracking: _trackingID,
                locationCreated: _location
            })
        );
    }

    function printAllSenders() public isAdmin {
        for (uint256 i = 0; i < senderCount; i++) {
            Sender storage sender = allSenders[i];
            emit AllSenderInformation(
                sender.senderID,
                sender.senderName,
                sender.senderLocation
            );
        }
    }

    function printAllParcels() public isAdmin {
        for (uint256 i = 0; i < allParcels.length; i++) {
            Parcel storage _parcel = allParcels[i];
            emit AllParcelInformation(
                _parcel.sender,
                _parcel.currentOwner,
                _parcel.tracking,
                _parcel.locationCreated
            );
        }
    }
}
