// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MathPuzzleRewards {
    // Mapping to track user rewards
    mapping(address => uint256) public rewards;

    // Events
    event PuzzleSolved(address indexed player, uint8 tier, uint256 reward);
    event RewardClaimed(address indexed player, uint256 totalReward);

    // Reward amounts for each tier
    uint256 public constant TIER_1_REWARD = 10;
    uint256 public constant TIER_2_REWARD = 50;
    uint256 public constant TIER_3_REWARD = 100;

    // Function to solve puzzles and earn rewards
    function solvePuzzle(uint8 tier) public {
        require(tier >= 1 && tier <= 3, "Invalid tier selected");

        uint256 rewardAmount;

        if (tier == 1) {
            rewardAmount = TIER_1_REWARD;
        } else if (tier == 2) {
            rewardAmount = TIER_2_REWARD;
        } else if (tier == 3) {
            rewardAmount = TIER_3_REWARD;
        }

        rewards[msg.sender] += rewardAmount;
        emit PuzzleSolved(msg.sender, tier, rewardAmount);
    }

    // Function to claim total rewards
    function claimRewards() public {
        uint256 totalReward = rewards[msg.sender];
        require(totalReward > 0, "No rewards to claim");

        // Reset rewards
        rewards[msg.sender] = 0;

        // Transfer reward (assuming ERC20 or native token mechanism implemented)
        payable(msg.sender).transfer(totalReward);
        emit RewardClaimed(msg.sender, totalReward);
    }

    // Function to view total rewards
    function getTotalRewards(address player) public view returns (uint256) {
        return rewards[player];
    }

    // Fallback function to accept Ether (if needed for reward payouts)
    receive() external payable {}
}
