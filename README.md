# CertiChain – Mini dApp (MG3012)

**Course:** MG3012 – Blockchain Technology for Business  
**Project:** CertiChain – Decentralized Certificate Verification System  
**Network:** Ethereum Sepolia testnet  
**Stack:** Solidity 0.8.20+, Remix IDE, MetaMask, HTML, CSS, JavaScript, ethers.js v6

## 1. Project overview

CertiChain is a small decentralized application for issuing and verifying academic certificates. The issuer deploys the contract and can issue or revoke certificates. Anyone connected to Sepolia can read certificate information and verify its status.

### Smart contract functions

1. `issueCertificate(studentName, course, certificateHash)` – owner-only write function that stores a certificate.
2. `verifyCertificate(certificateId)` – public read function that checks whether a certificate exists and is not revoked.
3. `getCertificate(certificateId)` – public read function that returns certificate details.
4. `revokeCertificate(certificateId)` – owner-only write function that revokes a certificate.
5. `totalCertificates()` – public counter getter.

The certificate ID is calculated as `keccak256(abi.encodePacked(certificateHash))`. The frontend calculates the same ID using ethers.js.

## 2. Files and pngs

- `SmartContract.sol` – Solidity smart contract.
- `index.html` – single-page frontend and JavaScript.
- `style.css` – responsive styling.
- `screenshots png` – real screenshots of deployment, Etherscan and UI interaction.

## 3. Deploy the contract using Remix

1. Install the MetaMask browser extension and create/unlock your wallet. **Never share your Secret Recovery Phrase or private key.**
2. In MetaMask, enable/select the **Sepolia** test network.
3. Obtain a small amount of Sepolia test ETH from a reputable Sepolia faucet. Test ETH has no real monetary value.
4. Open https://remix.ethereum.org.
5. Create a file named `SmartContract.sol` and paste the contents of this project's `SmartContract.sol`.
6. Open **Solidity Compiler**, select compiler version `0.8.20` or a compatible `0.8.x` version, and compile.
7. Open **Deploy & Run Transactions**:
   - Environment: **Injected Provider – MetaMask**
   - Confirm MetaMask is connected to Sepolia.
   - Contract: **CertiChain**
   - Click **Deploy** and approve the transaction in MetaMask.
8. After deployment is confirmed, copy the deployed contract address from Remix. Open the contract on Sepolia Etherscan to confirm the transaction.

The contract owner is automatically set to the wallet that deploys the contract. Use the intended issuer wallet for deployment. The address supplied for this assignment is documented as the intended wallet, but the actual connected/deployer account must be checked in MetaMask before deployment.

## 4. Connect the frontend

1. Open `index.html` in a browser with MetaMask installed. For best results, use VS Code Live Server or another local web server.
2. In `index.html`, `CONTRACT_ADDRESS` is already set to the deployed contract above. If you redeploy, replace it with your new address (keep the quotation marks).
4. Save the file and refresh the page.
5. Click **Connect MetaMask** and approve the connection. The page will request Sepolia if another network is selected.
6. Check that the contract status says **Configured** and the certificate count loads.

The page loads ethers.js v6 from jsDelivr CDN, so an internet connection is required.

## 5. Test the dApp

1. **Issue:** enter a student name, course, and unique reference such as `CERT-2026-001`. Click Issue and confirm the transaction in MetaMask. Wait for confirmation.
2. **Verify:** enter the same reference in the verification form. It should show a valid certificate and its details.
3. **Revoke:** enter the same reference in the revoke form and confirm the transaction. Verify again; the result should now say revoked.
4. Check the total certificate count and transaction on Sepolia Etherscan.

Only the contract owner can issue and revoke. Other wallets can still read and verify records.

## 6. Screenshots

All screenshots below were taken from my own deployment and test transactions on Sepolia.

| File | What it shows |
|---|---|
| `01-remix-deployment.png` | Remix with CertiChain deployed (`0x1D3...1BB2`) and MetaMask on Sepolia |
| `02-etherscan-contract.png` | Contract page on Sepolia Etherscan |
| `03-etherscan-issue-transaction.png` | Successful `issueCertificate` transaction on Etherscan |
| `04-frontend-home.png` | Frontend home page |
| `05-metamask-confirm-transaction.png` | Issue form filled and MetaMask transaction request |
| `06-verify-result.png` | Verification result: valid certificate |

## 7. GitHub and ZIP submission

1. Create a public GitHub repository named `CertiChain-Mini-dApp`.
2. Upload `SmartContract.sol`, `index.html`, `style.css`, `README.md`, and the three screenshots.
3. Add the deployed contract address to the README after deployment.
4. Download the repository as ZIP or submit the provided project ZIP after adding your screenshots.
5. Submit the ZIP, public GitHub repository URL, and Sepolia contract address on Google Classroom.

## 8. Security and limitations

- Never put a wallet private key or Secret Recovery Phrase in the source code.
- This is an educational testnet project, not a production credential system.
- Blockchain data is public and generally permanent. Do not store sensitive personal information.
- The frontend requires the deployed address to be entered manually after deployment.
- The contract stores a reference string, not the actual certificate document.

## Deployment details

- Deployer / issuer wallet: `0x4F8980C35bF9fa57F74BBDa8f2E61850932804f3`
- Network: Sepolia
- Contract address: **`0x1D340AF5E244df75655F57Ee1EC8744057b31BB2`**
- Etherscan: https://sepolia.etherscan.io/address/0x1D340AF5E244df75655F57Ee1EC8744057b31BB2
- GitHub repository: https://github.com/i245630-droid/CertiChain_Mini_dApp
