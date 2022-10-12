// const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("Shadows", function () {

    async function fixture() {
        const [deployer, account1] = await ethers.getSigners();

        // deploy renderers
        const BackgroundRenderer = await ethers.getContractFactory("BackgroundRenderer");
        const backgroundRenderer = await BackgroundRenderer.deploy();

        const ProfileRenderer = await ethers.getContractFactory("ProfileRenderer");
        const profileRenderer = await ProfileRenderer.deploy();

        // deploy components
        const BackgroundComponent = await ethers.getContractFactory("BackgroundComponent");
        const background = await BackgroundComponent.deploy(backgroundRenderer.address);
        
        const ProfileComponent = await ethers.getContractFactory("ProfileComponent");
        const profile = await ProfileComponent.deploy(profileRenderer.address);

        // deploy shadows nft
        const Shadows = await ethers.getContractFactory("Shadows");
        const shadows = await Shadows.deploy();

        // link components to composable
        await shadows.expandComponents(background.address);
        await shadows.expandComponents(profile.address);

        return {deployer, account1, background, profile, shadows};
    }

    // WIP
    describe.only("init test", function () {

        it("Should pass and print tokenUri", async () => {
            const { background, profile, shadows } = await loadFixture(fixture);

            // mint
            await shadows.mint();
            await profile.mint();
            await background.mint();

            // attach components
            await shadows.attachComponent(1, 0, 1);
            await shadows.attachComponent(1, 1, 1);

            // get uri
            const backgroundURI = await background.tokenURI(1);
            console.log('backgroundURI', backgroundURI, '\n');
            
            const profileURI = await profile.tokenURI(1);
            console.log('profileURI', profileURI, '\n');

            const shadowsURI = await shadows.tokenURI(1);
            console.log('shadowsURI', shadowsURI, '\n');
        });
    });
});