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
        address senderID,
        string senderName,
        string senderLocation
    );

    address admin;

    struct Sender {
        address senderID;
        string senderName;
        string senderLocation;
        bool registered;
    }

    struct Hub {
        address hubID;
        string hubName;
        string hubLocation;
        bool registered;
    }

    struct Delivery {
        address deliveryID;
        string deliveryName;
        string deliveryLocation;
        bool registered;

    }

    struct Parcel {
        address sender;
        address currentOwner;
        address nextOwner;
        string tracking;
        string locationCreated;
        bool delivered;
    }

    Parcel[] public allParcels;
    Sender[] public allSenders;
    Hub[] public allHubs;
    Delivery[] public allDelivery;


    
    uint256 senderCount = 0;
    uint256 parcelCount = 0;
    uint256 hubCount = 0;
    uint256 deliveryCount = 0;

    constructor() {
        admin = msg.sender;
    }

    modifier isAdmin() {
        require(admin == msg.sender, "Access denied!");
        _;
    }

    modifier senderIsAllowed {
    for(uint i = 0; i < allSenders.length; i++) {
        if(msg.sender == allSenders[i].senderID) {
        _;
        }
    }
    revert();
    }


//change of ownership (done), verify user , delivery (done)


    function registration(
        string memory _roles, //make sure on the front end, the options during sign up are 'seller' , 'hub' , or 'delivery'
        string memory _name,
        string memory _location
    ) public {
        if (keccak256(abi.encodePacked(_roles)) ==keccak256(abi.encodePacked("sender"))) {
            allSenders.push(Sender({senderID:msg.sender,senderName:_name,senderLocation:_location, registered:false}));
        }
        else if(keccak256(abi.encodePacked(_roles)) == keccak256(abi.encodePacked("hub"))){
            allHubs.push(Hub({hubID:msg.sender,hubName:_name,hubLocation:_location,registered:false}));
        }
        else if(keccak256(abi.encodePacked(_roles)) == keccak256(abi.encodePacked("delivery"))){
            allDelivery.push(Delivery({deliveryID:msg.sender,deliveryName:_name,deliveryLocation:_location,registered:false}));
        }
    }



    function addParcel(string memory _trackingID, string memory _location, address _nextOwner) public{      
        allParcels.push(Parcel({sender:msg.sender,currentOwner:msg.sender,nextOwner:_nextOwner,tracking:_trackingID,locationCreated:_location,delivered:false}));
    }

    function changeofOwnership(string memory _trackingID, address  _nextOwner) public{
        uint256 index;
        for (uint256 i = 0; i < allParcels.length; i++) {
            if (keccak256(abi.encodePacked(allParcels[i].tracking)) == keccak256(abi.encodePacked(_trackingID))) {
                index = i;
                break;
        }
    }
        // Update the next owner of the parcel
        allParcels[index].nextOwner = address(_nextOwner);

    }

    function delivery(string memory _trackingID) public {

        for (uint256 i = 0; i < allParcels.length; i++) {
            if (keccak256(abi.encodePacked(allParcels[i].tracking)) == keccak256(abi.encodePacked(_trackingID))) {
                allParcels[i].delivered = true;
            }
        }

    }

    function viewParcelinfo(string memory _tracking) public {
        for (uint256 i = 0; i < allParcels.length; i++) {
            if (keccak256(abi.encodePacked(allParcels[i].tracking)) == keccak256(abi.encodePacked(_tracking))) {
                emit AllParcelInformation(
                allParcels[i].sender,
                allParcels[i].currentOwner,
                allParcels[i].tracking,
                allParcels[i].locationCreated
            );
            }
        }
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

        for (uint i = 0; i < allParcels.length; i++) {
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
