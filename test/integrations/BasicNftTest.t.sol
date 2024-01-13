// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {Constants} from "../../src/constants.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    address public USER = makeAddr("user");

    function setUp() external {
        basicNft = new DeployBasicNft().run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "BasicDog";
        string memory actualName = basicNft.name();
        // compare it like this, because solidity cannot compare dynamic arrays and strings are dynamic arrays
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNft.mintNft(Constants.AO);
        assert(basicNft.balanceOf(USER) == 1);

        console.logBytes(abi.encode(Constants.AO));
        console.logBytes(abi.encodePacked(Constants.AO));

        assert(
            keccak256(abi.encodePacked(Constants.AO)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );

        vm.prank(USER);
        // use arbitrary token uri
        basicNft.mintNft("ipfs://aaaaaaaaa");
        assert(basicNft.balanceOf(USER) == 2);
    }

    function testOverflow() public {
        uint8 x = 255;
        unchecked {
            x++;
        }

        console.log("x");
        assert(x == 0);
    }
}
