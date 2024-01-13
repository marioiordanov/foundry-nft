// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {Constants} from "../../src/Constants.sol";

contract MoodNftTest is Test {
    MoodNft private moodNft;

    address USER = makeAddr("user");

    function setUp() public {
        moodNft = new MoodNft(Constants.SAD_SVG_URI, Constants.HAPPY_SVG_URI);
    }

    function testViewTokenUri() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }
}
