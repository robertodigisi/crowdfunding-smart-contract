// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/Counters.sol";

contract Crowdfounding {

    using Counters for Counters.Counter;

    // Events to be emitted when specific actions are completed
    event CampaignCreated ( uint256 _campaignId, address _initiator ) ;

    Counters.Counter public totalCampaigns;
    uint256 public totalDonations;

    // Campaign details
    struct Campaign {
        uint256 id;
        address initiator;
        string title;
        string description;
        uint256 fundsRaised;
        uint256 deadline;
        uint256 balance;
    }

    // Map of all the campaigns that have been started
    mapping(uint256=>Campaign) public campaigns;

    // create a new campaign
    function createCampaign ( string calldata _title, string calldata _description, uint256 _deadline ) public {

        Campaign memory campaign;

        // require the current time to be less than the campaign deadline
        require(block.timestamp < _deadline, "Campaign is already ended");

        // increment the total number of charity campaigns created
        totalCampaigns.increment();

        campaign.id = totalCampaigns.current();
        campaign.title = _title;
        campaign.description = _description;
        campaign.initiator = msg.sender;
        campaign.deadline = _deadline;

        campaigns[campaign.id] = campaign;

        // emit an event to the blockchain
        emit CampaignCreated(totalCampaigns.current(), msg.sender);
    }
}