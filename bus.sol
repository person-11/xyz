// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BusStationManagement {
    struct Person {
        string name;
        uint256 age;
    }

    struct Bus {
        uint256 busId;
        uint256 numberOfSeats;
        string route;
        uint256 passengersCount; // Tracks the current number of passengers
    }

    struct Passenger {
        string name;
        uint256 age;
    }

    // Mappings for management
    mapping(uint256 => Person) public drivers;
    mapping(uint256 => Person) public conductors;
    mapping(uint256 => Bus) public buses;
    mapping(uint256 => Passenger[]) public busPassengers; // Bus ID to Passenger list

    uint256 public driverCount;
    uint256 public conductorCount;
    uint256 public busCount;

    // Add a new driver
    function addDriver(string memory _name, uint256 _age) public {
        driverCount++;
        drivers[driverCount] = Person(_name, _age);
    }

    // Add a new conductor
    function addConductor(string memory _name, uint256 _age) public {
        conductorCount++;
        conductors[conductorCount] = Person(_name, _age);
    }

    // Add a new bus
    function addBus(uint256 _numberOfSeats, string memory _route) public {
        busCount++;
        buses[busCount] = Bus(busCount, _numberOfSeats, _route, 0);
    }

    // Assign a passenger to a bus
    function addPassenger(uint256 _busId, string memory _name, uint256 _age) public {
        require(buses[_busId].busId != 0, "Bus does not exist");
        require(buses[_busId].passengersCount < buses[_busId].numberOfSeats, "Bus is full");

        busPassengers[_busId].push(Passenger(_name, _age));
        buses[_busId].passengersCount++;
    }

    // Get all passengers of a bus
    function getPassengers(uint256 _busId) public view returns (Passenger[] memory) {
        return busPassengers[_busId];
    }

    // Get details of a bus
    function getBusDetails(uint256 _busId) public view returns (Bus memory) {
        require(buses[_busId].busId != 0, "Bus does not exist");
        return buses[_busId];
    }
}

        uint256 id;
        string name;
        uint256 totalFines; // Total unpaid fines
    }

    struct Rule {
        uint256 ruleId;
        string description;
        uint256 fineAmount; // Fine associated with the rule
    }

    // State variables
    mapping(uint256 => Driver) public drivers; // Driver ID to Driver details
    mapping(uint256 => Rule) public rules;    // Rule ID to Rule details
    mapping(uint256 => uint256[]) public driverViolations; // Driver ID to Rule IDs of violations

    uint256 public driverCount;
    uint256 public ruleCount;

    address public owner; // Contract owner for restricted actions

    // Modifier to restrict certain actions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Add a new driver
    function addDriver(string memory _name) public onlyOwner {
        driverCount++;
        drivers[driverCount] = Driver(driverCount, _name, 0);
    }

    // Add a new traffic rule
    function addRule(string memory _description, uint256 _fineAmount) public onlyOwner {
        ruleCount++;
        rules[ruleCount] = Rule(ruleCount, _description, _fineAmount);
    }

    // Record a rule violation by a driver
    function recordViolation(uint256 _driverId, uint256 _ruleId) public onlyOwner {
        require(drivers[_driverId].id != 0, "Driver does not exist");
        require(rules[_ruleId].ruleId != 0, "Rule does not exist");

        // Add the rule violation to the driver's record
        driverViolations[_driverId].push(_ruleId);

        // Add the fine amount to the driver's total fines
        drivers[_driverId].totalFines += rules[_ruleId].fineAmount;
    }

    // Get violations for a driver
    function getViolations(uint256 _driverId) public view returns (uint256[] memory) {
        return driverViolations[_driverId];
    }

    // Get total fines for a driver
    function getTotalFines(uint256 _driverId) public view returns (uint256) {
        require(drivers[_driverId].id != 0, "Driver does not exist");
        return drivers[_driverId].totalFines;
    }

    // Pay fine by driver
    function payFine(uint256 _driverId, uint256 _amount) public {
        require(drivers[_driverId].id != 0, "Driver does not exist");
        require(_amount <= drivers[_driverId].totalFines, "Amount exceeds total fines");

        // Deduct the paid amount from the driver's total fines
        drivers[_driverId].totalFines -= _amount;
    }

    // Get details of a rule
    function getRule(uint256 _ruleId) public view returns (Rule memory) {
        require(rules[_ruleId].ruleId != 0, "Rule does not exist");
        return rules[_ruleId];
    }
}


    struct Rule {
        uint256 ruleId;
        string description;
        uint256 fineAmount; // Fine associated with the rule
    }

    // State variables
    mapping(uint256 => Driver) public drivers; // Driver ID to Driver details
    mapping(uint256 => Rule) public rules;    // Rule ID to Rule details
    mapping(uint256 => uint256[]) public driverViolations; // Driver ID to Rule IDs of violations

    uint256 public driverCount;
    uint256 public ruleCount;

    address public owner; // Contract owner for restricted actions

    // Modifier to restrict certain actions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Add a new driver
    function addDriver(string memory _name) public onlyOwner {
        driverCount++;
        drivers[driverCount] = Driver(driverCount, _name, 0);
    }

    // Add a new traffic rule
    function addRule(string memory _description, uint256 _fineAmount) public onlyOwner {
        ruleCount++;
        rules[ruleCount] = Rule(ruleCount, _description, _fineAmount);
    }

    // Record a rule violation by a driver
    function recordViolation(uint256 _driverId, uint256 _ruleId) public onlyOwner {
        require(drivers[_driverId].id != 0, "Driver does not exist");
        require(rules[_ruleId].ruleId != 0, "Rule does not exist");

        // Add the rule violation to the driver's record
        driverViolations[_driverId].push(_ruleId);

        // Add the fine amount to the driver's total fines
        drivers[_driverId].totalFines += rules[_ruleId].fineAmount;
    }

    // Get violations for a driver
    function getViolations(uint256 _driverId) public view returns (uint256[] memory) {
        return driverViolations[_driverId];
    }

    // Get total fines for a driver
    function getTotalFines(uint256 _driverId) public view returns (uint256) {
        require(drivers[_driverId].id != 0, "Driver does not exist");
        return drivers[_driverId].totalFines;
    }

    // Pay fine by driver
    function payFine(uint256 _driverId, uint256 _amount) public {
        require(drivers[_driverId].id != 0, "Driver does not exist");
        require(_amount <= drivers[_driverId].totalFines, "Amount exceeds total fines");

        // Deduct the paid amount from the driver's total fines
        drivers[_driverId].totalFines -= _amount;
    }

    // Get details of a rule
    function getRule(uint256 _ruleId) public view returns (Rule memory) {
        require(rules[_ruleId].ruleId != 0, "Rule does not exist");
        return rules[_ruleId];
    }
}