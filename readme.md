# Parcel Track & Trace - Supply Chain Mobile dApp

Course : CSCI 4312 BLOCKCHAIN AND APPLICATION </br>
Section : 1

Team Members:
Name  | Matric No
------------- | -------------
MUHAMMAD IMRAN BIN MOHAMAD  | 1912837
MUHAMMAD IHSAN BIN AHMAD HANIZAR  | 1919939
MUHAMMAD FATIH BIN ABDUL RAZAK  | 1919131


## Project Background
In today's fast-paced business environment, supply chain management plays a critical role in ensuring the timely and efficient movement of goods. However, traditional supply chain systems are often riddled with inefficiencies and lack transparency. This is where blockchain technology comes in.

We propose to build a blockchain-based system to track logistics supply chain using Ethereum smart contracts. Blockchain technology offers a tamper-proof and decentralized ledger that can be used to track the movement of goods and ensure transparency throughout the supply chain. By using Ethereum smart contracts, we can automate the execution of complex logistics processes, reducing the need for manual intervention and minimizing the risk of errors.

Our goal of this project is to showcase the change of ownership between involved parties (Hub, Sender, Customer) using blockchain instead of conventional databases.

## Requirement Analysis
![Activity Diagram](https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/BC-Activity%20Diagram.drawio.png)</br>
*Activity Diagram*

![Sequence Diagram](https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/BC-Sequence%20Diagram.drawio.png)</br>
*Sequence Diagram*


## Screenshots


| Screen        | Functionality | 
|:--------------|:-------------:|
|    <img src="https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/cust-input.png" width="260" height="250">  | **Customer Page:** This is the display for public viewing where customers can access the details of their parcel by submitting the parcel tracking ID |
|    <img src="https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/cust-success.png" width="260" height="250">  | **Customer Page (Success):** A successful transaction will prompt the system to display details of the parcel; tracking ID, parcel origin, current owner, next owner |
|    <img src="https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/cust-error1.png" width="260" height="250">  | **Customer Page (Error):** The system handles the error by prompting a message saying that the tracking ID must not be empty|
|    <img src="https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/cust-error2.png" width="260" height="250">  | **Customer Page (Error):** A fail transaction will prompt a message to user to notify that the tracking ID is not available in the record|
|    <img src="https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/sender-input.png" width="260" height="250">  | **Sender Page:** This screen allows the sender to send a parcel to specific destination by filling in the parcel’s tracking number, sender’s location and parcel’s destination (next address) |
|    <img src="https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/sender-success.png" width="260" height="250">  | **Sender Page (Success):** A transaction is accepted into blockchain when all the necessary information is provided to the system |
|    <img src="https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/sender-error.png" width="260" height="250">  | **Sender Page (Error):** The system handles the error by prompting a message to notify that the details must be filled in |
|    <img src="https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/hub-input.png" width="260" height="250">  | **Hub Page:** This page enables a hub to transfer a parcel to another hub by filling in the parcel’s tracking number and its next address |
|    <img src="https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/hub-success.png" width="260" height="250">  | **Hub Page (Success):** This page enables a hub to transfer a parcel to another hub by filling in the parcel’s tracking number and its next address |
|    <img src="https://github.com/0xh34rtl3ss/SupplyChain_dApp/blob/main/assets/img/hub-error.png" width="260" height="250">  | **Hub Page (Error):** The system handles the error by prompting a message to notify that the details must not be empty |

