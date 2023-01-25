// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.15;

contract SupplyChain {


    event ParcelAdd(Parcel parcel);

    struct Sender {
        address senderID;
        string senderName;
        string senderLocation;
    }

    struct Hub {
        address hubID;
        string hubName;
        string hubLocation;
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

    address admin;
    
    uint256 senderCount = 0;
    uint256 parcelCount = 0;
    uint256 hubCount = 0;

    constructor() {
        admin = msg.sender;
    }

    modifier isAdmin {
        require(admin == msg.sender, "Access denied!");
        _;
    }
function registration(
        string memory _roles, //make sure on the front end, the options during sign up are 'seller' , 'hub' , or 'delivery'
        string memory _name,
        string memory _location
    ) public {
        if (keccak256(abi.encodePacked(_roles)) ==keccak256(abi.encodePacked("sender"))) {
            allSenders.push(Sender({senderID:msg.sender,senderName:_name,senderLocation:_location}));
        }
        else if(keccak256(abi.encodePacked(_roles)) == keccak256(abi.encodePacked("hub"))){
            allHubs.push(Hub({hubID:msg.sender,hubName:_name,hubLocation:_location}));
        }
    }



    function addParcel(string memory _trackingID, string memory _location, address _nextOwner) public  {      
        allParcels.push(Parcel({sender:msg.sender,currentOwner:msg.sender,nextOwner:_nextOwner,tracking:_trackingID,locationCreated:_location,delivered:false}));
        emit ParcelAdd(allParcels[parcelCount]);
        parcelCount = parcelCount+1;

    }

    function changeofOwnership(string memory _trackingID, address  _nextOwner) public  {

        for (uint256 i = 0; i < allParcels.length; i++) {
            if (keccak256(abi.encodePacked(allParcels[i].tracking)) == keccak256(abi.encodePacked(_trackingID))) {
                require(msg.sender == allParcels[i].nextOwner, "Access Denied!"); //check this comdition !!!
                allParcels[i].nextOwner = address(_nextOwner);}

        }

    }


    function viewParcelinfo(string memory _tracking) public returns(string memory, string memory, string memory, string memory, string memory, bool){
        for (uint256 i = 0; i < allParcels.length; i++) {
            if (keccak256(abi.encodePacked(allParcels[i].tracking)) == keccak256(abi.encodePacked(_tracking))) {
                 string memory sender = getAddressName(allParcels[i].sender);
                 string memory currentOwn = getAddressName(allParcels[i].currentOwner);
                 string memory nextOwn = getAddressName(allParcels[i].nextOwner);


                
                return (sender, currentOwn, nextOwn, allParcels[i].tracking, allParcels[i].locationCreated, allParcels[i].delivered);
            }
        }
    }

    function getAddressName(address _target)public returns(string memory){

            for (uint256 i = 0; i < allParcels.length; i++) {
            if (keccak256(abi.encodePacked(allSenders[i].senderID)) == keccak256(abi.encodePacked(_target))) {
                return allSenders[i].senderName;
            }
            }

            for (uint256 i = 0; i < allHubs.length; i++) {
            if (keccak256(abi.encodePacked(allHubs[i].hubID)) == keccak256(abi.encodePacked(_target))) {
                return allHubs[i].hubName;
            }
            }



        
    }
}