const SHA256 = require("crypto-js/sha256");
const exp = require("express");
const app = exp();
app.use(exp.static("public"));

var curr_ind= 0
var last_Hash = ""

class CryptoBlock 
{
    constructor(index,timestamp,data)
    {
        this.index = index 
        this.timestamp = timestamp
        this.data = data;
        this.previousHash = last_Hash;
        [this.hash,this.timeTaken] =  this.mineBlock();
        last_Hash = this.hash
    }
    computeHash(nonce) {
        return SHA256(this.index+this.previousHash+this.timestamp+JSON.stringify(this.data) + nonce).toString();
    }

    mineBlock() {
        let nonce = 0
        let difficulty = 3
        let prefix = '0'.repeat(difficulty);
        let time_begin = Date.now();
      
        while (true) {
          const hash = this.computeHash(nonce);
          if (hash.startsWith(prefix)) {
            // console.log(`Block mined! Nonce: ${nonce}, Hash: ${hash}`);
            
            return [hash,Date.now()-time_begin];
          }
          nonce++;
        }
      }
      
}

app.get("/",(req,res)=>{
    curr_ind = 0;
    last_Hash = ""
    let DataList = [
        {
            "Sender" : "U1",
            "Receiver" : "U2",
            "Amount" : 4000,
            "Description" : "50000 from U1 to U2"
        },
        {
            "Sender" : "U2",
            "Receiver" : "U3",
            "Amount" : 6000,
            "Description" : "5000 from U2 to U3"
        },
        {
            "Sender" : "U3",
            "Receiver" : "U1",
            "Amount" : 7000,
            "Description" : "10000 from U3 to U1"
        }
    ]
    let blockList = []
    let outputHTML = "<head><link rel='stylesheet' type='text/css' href='style.css' /></head>";
    for(ind in DataList)
    {
        let block = new CryptoBlock(curr_ind++,Date.now(),DataList[ind])
        blockList.push(block)
        outputHTML+="<div class='blockTable'><table><tbody>"
        Object.keys(block).forEach(function(key) {
            outputHTML+=`<tr><td><b>${key}</b></td><td>${(block[key]!=="")?block[key]:"-"}</td></tr>`
          })
          outputHTML+="</tbody></table></div>";
    }
    res.setHeader("Content-Type", "text/html")
    res.send(outputHTML)
})

app.listen(process.env.PORT || 3000,function(){
    console.log("Server started on 3000");
  });

  

