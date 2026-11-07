// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title CertiChain - Decentralized Certificate Verification
/// @notice The contract owner (the wallet that deploys this contract) can issue and revoke certificates.
contract CertiChain {
    address public owner;
    uint256 public totalCertificates;

    struct Certificate {
        string studentName;
        string course;
        string certificateHash;
        address issuedBy;
        uint256 issuedAt;
        bool exists;
        bool revoked;
    }

    mapping(bytes32 => Certificate) private certificates;

    event CertificateIssued(bytes32 indexed certificateId, string studentName, string course);
    event CertificateRevoked(bytes32 indexed certificateId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /// @notice Issue a certificate. The certificate hash should be a unique reference or document hash.
    function issueCertificate(
        string calldata studentName,
        string calldata course,
        string calldata certificateHash
    ) external onlyOwner returns (bytes32) {
        require(bytes(studentName).length > 0, "Student name is required");
        require(bytes(course).length > 0, "Course is required");
        require(bytes(certificateHash).length > 0, "Certificate hash is required");

        bytes32 certificateId = keccak256(abi.encodePacked(certificateHash));
        require(!certificates[certificateId].exists, "Certificate already exists");

        certificates[certificateId] = Certificate({
            studentName: studentName,
            course: course,
            certificateHash: certificateHash,
            issuedBy: msg.sender,
            issuedAt: block.timestamp,
            exists: true,
            revoked: false
        });

        totalCertificates += 1;
        emit CertificateIssued(certificateId, studentName, course);
        return certificateId;
    }

    /// @notice Returns true only when the certificate exists and has not been revoked.
    function verifyCertificate(bytes32 certificateId) external view returns (bool) {
        Certificate storage cert = certificates[certificateId];
        return cert.exists && !cert.revoked;
    }

    /// @notice Revoke a previously issued certificate.
    function revokeCertificate(bytes32 certificateId) external onlyOwner {
        require(certificates[certificateId].exists, "Certificate does not exist");
        require(!certificates[certificateId].revoked, "Certificate already revoked");
        certificates[certificateId].revoked = true;
        emit CertificateRevoked(certificateId);
    }

    /// @notice Read all stored details for a certificate.
    function getCertificate(bytes32 certificateId)
        external
        view
        returns (
            string memory studentName,
            string memory course,
            string memory certificateHash,
            address issuedBy,
            uint256 issuedAt,
            bool exists,
            bool revoked
        )
    {
        Certificate storage cert = certificates[certificateId];
        return (
            cert.studentName,
            cert.course,
            cert.certificateHash,
            cert.issuedBy,
            cert.issuedAt,
            cert.exists,
            cert.revoked
        );
    }
}
