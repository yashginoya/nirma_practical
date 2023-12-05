// design a smart contract in solidity to track the supply of medicine in healthcare. system consider 5 type/category of medicine & identify entities who is using the system
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 ;

contract healthcare {
        struct Manufacturer{
            string name;
            uint total_production;
            uint[5] medicine_count;
        }
        struct Consumer{
            string name;
            uint total_purchase;
            uint[5] medicine_count;
        }
        struct Sellsman{
            string name;
            uint total_purchase;
            uint[5] medicine_count;
        }

        address public auth;
        mapping  ( address => Consumer)   consumer;
        mapping (address => Sellsman)  sellsman;
        // Manufacturer manufacturer;
        mapping  (address => Manufacturer) manufacturer;
        
        modifier authOnly()
        {
            require(msg.sender == auth);
            _;
        }
        function New_Manufacturer_Details(string memory _name,address _person,uint _1st_Medicine,uint _2nd_Medicine,uint _3rd_Medicine,uint _4th_Medicine,uint _5th_Medicine) public 
        {
            // auth = msg.sender;
            manufacturer[_person].name = _name;
            manufacturer[_person].medicine_count[0] = _1st_Medicine;
            manufacturer[_person].medicine_count[1] = _2nd_Medicine;
            manufacturer[_person].medicine_count[2] = _3rd_Medicine;
            manufacturer[_person].medicine_count[3] = _4th_Medicine;
            manufacturer[_person].medicine_count[4] = _5th_Medicine;
            manufacturer[_person].total_production = _1st_Medicine + _2nd_Medicine + _3rd_Medicine + _4th_Medicine + _5th_Medicine;
        }
        function add_New_Medicine(address _person,uint _category,uint _quantity) public 
        {
            manufacturer[_person].medicine_count[_category] += _quantity;
            manufacturer[_person].total_production += _quantity;
        } 
        function Consumer_BUY(string memory _name,address _person,uint _buy_from,address _buy_address,uint _medicine_category,uint _medicine_quantity) public
        {
            if(_buy_from == 0){
                require(manufacturer[_buy_address].medicine_count[_medicine_category] >= _medicine_quantity, "Unsufficient Medicine");
                manufacturer[_buy_address].medicine_count[_medicine_category] -= _medicine_quantity;
                manufacturer[_buy_address].total_production -= _medicine_quantity;
            }
            else{
                require(sellsman[_buy_address].medicine_count[_medicine_category] >= _medicine_quantity, "Unsufficient Medicine");
                sellsman[_buy_address].medicine_count[_medicine_category] -= _medicine_quantity;
                sellsman[_buy_address].total_purchase -= _medicine_quantity;
            }
            consumer[_person].name = _name;
            consumer[_person].medicine_count[_medicine_category] += _medicine_quantity;
            consumer[_person].total_purchase += _medicine_quantity;
        }
        function Sellsman_BUY(string memory _name,address _person,address _buy_address,uint _medicine_category,uint _medicine_quantity) public
        {
            require(manufacturer[_buy_address].medicine_count[_medicine_category] >= _medicine_quantity, "Unsufficient Medicine");
            sellsman[_person].name = _name;
            sellsman[_person].medicine_count[_medicine_category] += _medicine_quantity;
            sellsman[_person].total_purchase += _medicine_quantity;
            manufacturer[_buy_address].medicine_count[_medicine_category] -= _medicine_quantity;
            manufacturer[_buy_address].total_production -= _medicine_quantity;
        }
        function get_manufacturer_Detail(address _person) view public returns (string memory, uint,uint,uint,uint,uint,uint){
            return (
                    manufacturer[_person].name,
                    manufacturer[_person].medicine_count[0],
                    manufacturer[_person].medicine_count[1],
                    manufacturer[_person].medicine_count[2],
                    manufacturer[_person].medicine_count[3],
                    manufacturer[_person].medicine_count[4],
                    manufacturer[_person].total_production
                    );
        }
        function get_Consumer_Detail(address _person) view public returns (string memory, uint,uint,uint,uint,uint,uint){
            return (
                    consumer[_person].name,
                    consumer[_person].medicine_count[0],
                    consumer[_person].medicine_count[1],
                    consumer[_person].medicine_count[2],
                    consumer[_person].medicine_count[3],
                    consumer[_person].medicine_count[4],
                    consumer[_person].total_purchase
                    );
        }
        function get_Sellsman_Detail(address _person) view public returns (string memory, uint,uint,uint,uint,uint,uint){
            return (
                    sellsman[_person].name,
                    sellsman[_person].medicine_count[0],
                    sellsman[_person].medicine_count[1],
                    sellsman[_person].medicine_count[2],
                    sellsman[_person].medicine_count[3],
                    sellsman[_person].medicine_count[4],
                    sellsman[_person].total_purchase
                    );
        }
        
}