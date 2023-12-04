// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract ttt {
    uint256[3][3] box;
    uint256 gameResult;
    uint256 public currturn = 1;

    constructor() {
        box = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
        gameResult = 0;
    }

    function saveCurrentMove(
        uint256 rowVal,
        uint256 colVal,
        uint256 move
    ) public returns (string memory) {
        if (
            (move != 1 && move != 2) ||
            move != currturn ||
            box[rowVal][colVal] != 0
        ) {
            return "Invalid Move";
        } else {
            if (gameResult == 0) {
                box[rowVal][colVal] = move;
                currturn = (currturn % 2) + 1;
                if (checkWinner(move)) {
                    saveResult(move);
                }
                return "Move Saved";
            } else {
                return "Result already decided";
            }
        }
    }

    function saveResult(uint256 result) public {
        gameResult = result;
    }

    function checkWinner(uint256 curr) internal view returns (bool) {
        for (uint8 i = 0; i < 3; i++) {
            if (
                box[i][0] == box[i][1] &&
                box[i][1] == box[i][2] &&
                box[i][0] == curr
            ) {
                return true;
            }
            if (
                box[0][i] == box[1][i] &&
                box[1][i] == box[2][i] &&
                box[0][i] == curr
            ) {
                return true;
            }
        }
        if (
            box[0][0] == box[1][1] &&
            box[1][1] == box[2][2] &&
            box[0][0] == curr
        ) {
            return true;
        }
        if (
            box[0][2] == box[1][1] &&
            box[1][1] == box[2][0] &&
            box[0][2] == curr
        ) {
            return true;
        }
        return false;
    }

    function getCurrentBox() public view returns (uint256[3][3] memory) {
        return box;
    }

    function getGameResult() public view returns (uint256) {
        return gameResult;
    }
}