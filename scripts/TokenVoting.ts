import {ethers} from "hardhat";

async function  main(){

    const [admin1, admin2, admin3, admin4] = await ethers.getSigners();
 
  const TokenVotingContract =  await ethers.getContractFactory("TokenVoting");

  const tokenVotingContract = await TokenVotingContract.deploy("VINCETOKEN","VIT", 1000);

  await tokenVotingContract.deployed();

  console.log(`Contract deployed at address ${tokenVotingContract.address}`);

  let AddressToken = admin4.address;

  let tokenName = await tokenVotingContract.TokenName();

  console.log(tokenName);

  let tokenSymbol = await tokenVotingContract.TokenSymbol();
  console.log(tokenSymbol);

  let tokenDecimal = await tokenVotingContract.TokenDecimal();

  console.log(tokenDecimal);

  let tokenBalance = await tokenVotingContract.balanceOf(AddressToken);
  console.log(tokenBalance);

    let transfer = await tokenVotingContract.Transfer("0x8e4AFA7AF752407783BcFCEB465D456E4179e79A", "10");

    console.log(transfer);
    let Admin1 = await tokenVotingContract.createVoters(admin1.address);
    console.log(Admin1);

    let Admin2 = await tokenVotingContract.createVoters(admin2.address);
    console.log(Admin2);

    let Admin3 = await tokenVotingContract.createVoters(admin3.address);
    console.log(Admin3);

    let createProposal = await tokenVotingContract.CreateProposal("buy Land","100","0x0fC865feDd0e1b1D40607fbF774c90f1442Fd93d" );
    console.log(createProposal);

    let createProposal2 = await tokenVotingContract.CreateProposal("buy House","100","0x89F748cd151895781b4694c814d4234914Fc860A" );
    console.log(createProposal2);

    let createProposal3 = await tokenVotingContract.CreateProposal("buy cloth","100","0x21ec8baBA0f58591E86816671693383C76935cee" );
    console.log(createProposal3);

    let voteProposal1 = await tokenVotingContract.VoteForProposal(admin3.address,"0x21ec8baBA0f58591E86816671693383C76935cee", "0x89F748cd151895781b4694c814d4234914Fc860A","0x0fC865feDd0e1b1D40607fbF774c90f1442Fd93d");

    console.log(voteProposal1);

    let voteProposal2 = await tokenVotingContract.VoteForProposal(admin2.address, "0x89F748cd151895781b4694c814d4234914Fc860A","0x0fC865feDd0e1b1D40607fbF774c90f1442Fd93d", "0x21ec8baBA0f58591E86816671693383C76935cee");

    console.log(voteProposal2);


    let voteProposal3 = await tokenVotingContract.VoteForProposal(admin1.address, "0x89F748cd151895781b4694c814d4234914Fc860A","0x0fC865feDd0e1b1D40607fbF774c90f1442Fd93d", "0x21ec8baBA0f58591E86816671693383C76935cee");

    console.log(voteProposal3);

}

main().then(()=>process.exitCode=0).catch((error)=>{
    console.error(error);
    process.exitCode =1;
})