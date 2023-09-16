// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft moodNft) {
        string memory happySVG = vm.readFile("./img/happy.svg");
        string memory sadSVG = vm.readFile("./img/sad.svg");
        vm.startBroadcast();
        moodNft = new MoodNft(svgToImageUri(happySVG), svgToImageUri(sadSVG));
        vm.stopBroadcast();
    }

    function svgToImageUri(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(abi.encodePacked(svg))
        );
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
