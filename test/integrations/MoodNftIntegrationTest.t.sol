// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {Constants} from "../../src/Constants.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract MoodNftIntegrationTest is Test {
    MoodNft private moodNft;
    DeployMoodNft private deployer;

    address USER = makeAddr("user");

    function setUp() public {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function testViewTokenUriIntegration() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }

    function testFlipTokenToSad() public {
        vm.startPrank(USER);
        moodNft.mintNft();

        string memory expectedUri = deployer.svgToImageUri(
            vm.readFile("./images/sad.svg")
        );

        moodNft.flipMood(0);
        assert(moodNft.getMood(0) == MoodNft.Mood.SAD);

        moodNft.flipMood(0);
        assert(moodNft.getMood(0) == MoodNft.Mood.HAPPY);
    }
}
