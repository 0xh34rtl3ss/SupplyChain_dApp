// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.8;
contract SupplyChain {

event AllParcelInformation(address sender, string tracking, string locationCreated);

address admin;

struct Sender{
uint senderID;
string senderName;
string senderLocation;
}

struct Parcel{
address sender;
string tracking;
string locationCreated;
}

struct Hub{
address hubID;
string hubLocation;
}

mapping (uint => Sender) allSenders;
mapping(uint => Parcel) allParcels;
uint256 items=0;

constructor(){
    admin = msg.sender;
}

modifier isAdmin(){
    require(admin == msg.sender, "Access denied!");
    _;
}


function addSender(string memory _name, string memory _location) public isAdmin {
uint256 sender_counter = 0;
Sender memory addsender = Sender({senderID: sender_counter,senderName: _name, senderLocation: _location});
allSenders[sender_counter] = addsender;
sender_counter += 1;
}


function addParcel(string memory _trackingID, string memory _location) public{
    Parcel memory addparcel = Parcel({sender: msg.sender, tracking: _trackingID, locationCreated: _location });
    allParcels[items]=addparcel;
    items = items+1;
}





function printAllParcels() public isAdmin {
  // Iterate over all the keys in the mapping
  for (uint i = 0; i < items; i++) {
    // Get the parcel at this key
    Parcel storage parcel = allParcels[i];
    // Emit an event with the parcel information
    emit AllParcelInformation(parcel.sender, parcel.tracking, parcel.locationCreated);
  }
}


}


 