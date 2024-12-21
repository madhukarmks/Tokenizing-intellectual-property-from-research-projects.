// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract IntellectualPropertyToken {
    struct IntellectualProperty {
        uint256 id;
        string title;
        string description;
        address creator;
        uint256 timestamp;
    }

    uint256 private _currentId;
    mapping(uint256 => IntellectualProperty) private _intellectualProperties;
    mapping(uint256 => address) private _owners;

    event IntellectualPropertyTokenized(
        uint256 indexed id,
        string title,
        address indexed creator,
        uint256 timestamp
    );

    function tokenizeIP(string memory title, string memory description) public {
        uint256 newId = _currentId + 1;
        _currentId = newId;

        _intellectualProperties[newId] = IntellectualProperty({
            id: newId,
            title: title,
            description: description,
            creator: msg.sender,
            timestamp: block.timestamp
        });

        _owners[newId] = msg.sender;

        emit IntellectualPropertyTokenized(newId, title, msg.sender, block.timestamp);
    }

    function getIPDetails(uint256 id) public view returns (IntellectualProperty memory) {
        require(_exists(id), "IP token does not exist.");
        return _intellectualProperties[id];
    }

    function getOwner(uint256 id) public view returns (address) {
        require(_exists(id), "IP token does not exist.");
        return _owners[id];
    }

    function _exists(uint256 id) private view returns (bool) {
        return _intellectualProperties[id].id != 0;
    }
}
