// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;
// import "./StringUtils.sol";


contract voting {
        // using StringUtils for uint;
        struct Candidate
        {
            string name;
            uint age;
            uint vCount;
        }

        struct Voter 
        {
            bool authorized;
            bool voted;
            uint vote;
        }

        address public auth;
        string public eleName;
        uint public eleYear;
        mapping  ( address => Voter) public  voters;
        Candidate[] public  candidates;
        uint public  totalVotes;
        modifier authOnly()
        {
            require(msg.sender == auth);
            _;
        }
         

        function Election(string memory _name,uint _year) public 
        {
            auth = msg.sender;
            eleName = _name;
            eleYear = _year;
        }
        function addNewCandidate(string memory _name,uint _age) authOnly public 
        {
            candidates.push(Candidate(_name,_age,0));
        } 
        function getCandidateCount() public view returns(uint)
        {
            return candidates.length;
        }

        function authorize(address _person) authOnly public 
        {
            voters[_person].authorized = true;
        }
        function vote(uint _candidateIndex) public 
        {
            // require(!voters[msg.sender].voted);
            require(voters[msg.sender].authorized);
            voters[msg.sender].vote = _candidateIndex;
            voters[msg.sender].voted = true;
            candidates[_candidateIndex].vCount +=1;
            totalVotes+=1;
        }
        function getResults() view public returns (uint)
        {
            uint ma=0;
            for (uint i=0; i<candidates.length; i+=1) 
            {
                if (candidates[i].vCount>candidates[ma].vCount) {
                    ma = i;
                }
            }
            // string memory ans = string(abi.encodePacked("Winner of the election ",eleName,"-",eleYear.uintToString()," is : ",candidates[ma].name));
            return ma;
        }
}
