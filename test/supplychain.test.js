const SupplyChain = artifacts.require("SupplyChain.sol");

contract("SupplyChain", accounts => {
    let instance;

    beforeEach(async () => {
        instance = await SupplyChain.new();
    });

    it("should deploy successfully", async () => {
        assert.ok(instance.address);
    });

    it("should register a actor(sender) successfully", async () => {
        await instance.registration("sender", "Imran", "Cheras");
        const sender = await instance.allSenders(0);
        assert.equal(sender.senderID, accounts[0]);
        assert.equal(sender.senderName, "Imran");
        assert.equal(sender.senderLocation, "Cheras");
    });

    it("should register a actor(hub) successfully", async () => {
        await instance.registration("hub", "[Hub-Perak]", "Ipoh");
        const hub = await instance.allHubs(0);
        assert.equal(hub.hubID, accounts[0]);
        assert.equal(hub.hubName, "[Hub-Perak]");
        assert.equal(hub.hubLocation, "Ipoh");
    });


    it("should add and read parcel info successfully", async () => {
        await instance.addParcel("12345", "Gombak", accounts[1]);
        const parcel = await instance.allParcels(0);

        assert.equal(parcel.sender, accounts[0]);
        assert.equal(parcel.currentOwner, accounts[0]);
        assert.equal(parcel.nextOwner, accounts[1]);
        assert.equal(parcel.tracking, "12345");
        assert.equal(parcel.locationCreated, "Gombak");
        assert.equal(parcel.delivered, false);
    });

    it("should change ownership of a parcel successfully", async () => {
        await instance.addParcel("12345", "Gombak", accounts[0]);
        await instance.changeofOwnership("12345", accounts[2]);
        const parcel = await instance.allParcels(0);
        assert.equal(parcel.nextOwner, accounts[2]);
    });


});

