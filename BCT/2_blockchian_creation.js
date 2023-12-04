const { createHash } = require('crypto');
const { createInterface } = require('readline');
const readline = createInterface({
    input: process.stdin,
    output: process.stdout,
});
class Block {
    constructor(index, timestamp, data, previoushash = "") {
        this.index = index;
        this.timestamp = timestamp;
        this.data = data;
        this.previoushash = previoushash;
        this.hash = this.computeHash();
    }
    computeHash() {
        return createHash('sha256')
            .update(
                this.index +
                this.previoushash +
                this.timestamp +
                JSON.stringify(this.data))
            .digest('hex');
    }
}

class BlockChain {
    constructor(origin) {
        this.chain = [origin];
    }
    addOneBlock(data) {
        let index = this.chain[this.chain.length - 1].index;
        let newBlock = new Block(
            index + 1,
            new Date(),
            data,
            this.chain[this.chain.length - 1].hash
        );
        this.chain.push(newBlock);
    }
}

const readLineAsync = (msg) => {
    return new Promise((resolve) => {
        readline.question(msg, (userRes) => {
            resolve(userRes);
        });
    });
};

(async () => {
    const totalBlocks = await readLineAsync(
        "How Many Blocks You Want in BlockChain : "
    );
    readline.close();
    let block1 = new Block(0, new Date(), "Origin of BlockChain 1", 0);
    let blockchain = new BlockChain(block1);
    for (let i = 1; i < parseInt(totalBlocks); i++) {
        blockchain.addOneBlock(`Block ${i}`);
    }
    console.log(JSON.stringify(blockchain, null, 2));
})();