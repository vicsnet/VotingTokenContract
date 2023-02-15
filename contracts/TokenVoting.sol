// SPDX-License-Identifier: UNLICCENSED

pragma solidity ^0.8.0;


contract TokenVoting{
string name;
string symbol;
uint decimal;
uint supply;
address owner;
address[] Voters;
bool[] TotalVoters;

struct VoteDetails{
    string proposal;
    address _proposalAddress;
    uint amountNeeded;
    uint TotalVote;
}

VoteDetails[] public voteDetails;

mapping(address =>VoteDetails) VD; 
mapping(address => bool) voted;
// mapping(address => uint) yourVote;

mapping(address=>uint) TokenBalance;
mapping(address=>mapping(address=>uint)) allowance;

constructor(string memory _name, string memory _symbol, uint _supply){
    name =_name;
    symbol = _symbol;
    supply = _supply;

    TokenBalance[msg.sender] +=supply;
    
    owner = msg.sender;


}

function TokenName() public view returns (string memory _name){
    _name = name;
   
   return _name;
} 

function TokenSymbol() public view returns (string memory){
    return symbol;
}

function TokenDecimal() public view returns (uint256){
    return decimal;
}

function TotalSupply() public view returns (uint256){
    return supply;
}

function balanceOf(address _owner) public view returns(uint256 balance){

return TokenBalance[_owner];
}

function Transfer(address _to, uint amount ) public returns(bool success){
TransferLogic(msg.sender, _to, amount);
success;
}

function TransferLogic(address from, address _to, uint amount) internal {
    require(TokenBalance[from] >= amount, "Insufficient Fund");
    require(_to != address(0), "You can't transfer to address 0 ");
    TokenBalance[from] -= amount;
    TokenBalance[_to] += amount;


}

function _allowance(address _owner, address spender) public view returns(uint amount){
    amount = allowance[_owner][spender];

}
function TransferFrom(address from, address _to, uint amount) public{
    uint value = _allowance(from, msg.sender);
    require(amount <= value, "Insufficient allowance");
    allowance[from][msg.sender] -= amount;
    TransferLogic(from, _to, amount);

}
function approve(address spender, uint amount) public{
    allowance[msg.sender][spender] += amount;
}

function mintToken(address _to, uint amount) public{
    require(msg.sender == owner, "You are not the owner of the contract");
    require(_to != address(0), "Minting to address(0) not alllowed");
    supply += amount;
    TokenBalance[_to] += amount;
}


// creating Admin
function createVoters(address admin) public{
    // bool success = false;
    require(msg.sender == owner, "you are not an admin");

    Voters.push(admin);
    Transfer(admin, 6);
    // require(success == true, "You can not register again");
    // Voters.push(success = true);
    // TokenBalance[admin] = 6;
}

function CreateProposal(string memory test, uint amount, address _address) public{
    VoteDetails storage vDetails = VD[_address];
    VoteDetails memory v;
    v.proposal = test;
    v.amountNeeded = amount;
    v._proposalAddress = _address;

    vDetails.proposal = test;
    vDetails.amountNeeded =amount;
    vDetails._proposalAddress = _address;

    voteDetails.push(v);
}

function VoteForProposal(address _address, address _toBeVotedFor, address _2ndAddressToVoteFor, address _3rdAddressToVoteFor) public{
require(TokenBalance[_address] >=0, "Insufficient Balance");
require(voted[_address] == false, "You have Voted");
 VoteDetails storage getAddress = VD[_toBeVotedFor];
 VoteDetails storage getAddress2 = VD[_2ndAddressToVoteFor];
 VoteDetails storage getAddress3 = VD[_3rdAddressToVoteFor];
 require(getAddress._proposalAddress ==_toBeVotedFor, "No Proposal found");
  require(getAddress2._proposalAddress ==_2ndAddressToVoteFor, "No Proposal found");
  require(getAddress3._proposalAddress ==_3rdAddressToVoteFor, "No Proposal found");

// yourVote[_toBeVotedFor] +=3;
// yourVote[_2ndAddressToVoteFor] +=2;
// yourVote[_3rdAddressToVoteFor] +=1;
// uint total1 = yourVote[_toBeVotedFor];
getAddress.TotalVote +=3;
TokenBalance[_address] -=3;
getAddress2.TotalVote +=2;
TokenBalance[_address] -=2;
getAddress3.TotalVote +=1;
TokenBalance[_address] -=1;

uint total1 = getAddress.TotalVote;
uint total2 = getAddress2.TotalVote;
uint total3 = getAddress3.TotalVote;

voted[_address] = true;

uint size = Voters.length;

TotalVoters.push(voted[_address]);
uint votedAdmin = TotalVoters.length;
uint percentage = (size*60)/100;


if(votedAdmin >= percentage){
    if(total1 > total2 && total1 > total3){
        Transfer(getAddress._proposalAddress, 100);
    }else if(total2 >total1 && total2 > total3){
        Transfer(getAddress2._proposalAddress, 100);
    }else if(total3 > total1 && total3 > total2){
        Transfer(getAddress3._proposalAddress, 100);
    }
}

}

}