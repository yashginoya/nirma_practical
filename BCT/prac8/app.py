import warnings
from flask import Flask, flash, request, redirect, url_for, render_template, Response
from web3 import Web3
from hexbytes import HexBytes


app = Flask(__name__)
w3 = Web3(Web3.HTTPProvider('https://sepolia.infura.io/v3/92beea93f95d4fb2bf03a5b6e0541053'))
contract_abi =[
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "num",
				"type": "uint256"
			}
		],
		"name": "store",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "retrieve",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
contract_address = '0x90282CFa4E4098e95770083a3A907483E3FF0fC6'  # Replace with your contract's address
contract = w3.eth.contract(address=contract_address, abi=contract_abi)


@app.route('/')
def hello_world():
    return render_template('index.html')
@app.route('/read')
def read():
    stored_data = contract.functions.retrieve().call()
    return render_template('read.html',value=stored_data)
    
@app.route('/write',methods =["GET","POST"])
def write():
    if request.method == "POST":
        new_val = int(request.form.get("new_val"))
        transaction = contract.functions.store(new_val).build_transaction(
            {
                "chainId": 11155111,  
                "gas": 1000000,  
                "gasPrice": w3.to_wei("20", "gwei"),  
                "nonce": w3.eth.get_transaction_count("0x25af8A9115E573B8759592ff131F9cfBA99Fb509"),
            }
        )

        private_key = "633e60dfe611fbcea90e871c53b3ddbc5a689dc9c59ff5ff14be84d67c317e75" 
        signed_transaction = w3.eth.account.sign_transaction(transaction, private_key=private_key)
        tx_hash = w3.eth.send_raw_transaction(signed_transaction.rawTransaction)
        print("Transaction Hash:", tx_hash.hex())


        receipt =dict(w3.eth.wait_for_transaction_receipt(tx_hash)) 
        # receipt = {'blockHash': HexBytes('0xe3f5ee19681e81b0a9f717af243a84d07825fec0aede12bf9ba8aba1146d4ef0'), 'blockNumber': 4358878, 'contractAddress': None, 'cumulativeGasUsed': 26624, 'effectiveGasPrice': 20000000000, 'from': '0x25af8A9115E573B8759592ff131F9cfBA99Fb509', 'gasUsed': 26624, 'logs': [], 'logsBloom': HexBytes('0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'), 'status': 1, 'to': '0x90282CFa4E4098e95770083a3A907483E3FF0fC6', 'transactionHash': HexBytes('0x2ebebaa2ff76156efd754a834cc5675d7222ea513d7a0445ddee00ad9417b90f'), 'transactionIndex': 0, 'type': 0}
        for k,v in receipt.items():
            if isinstance(v, HexBytes):
                receipt[k] = v.hex()
        return render_template('write.html',updated=True,value=new_val,receipt=receipt)
    else:
        return render_template('write.html',updated=False)
if __name__ == "__main__":
    app.run(debug=False)
