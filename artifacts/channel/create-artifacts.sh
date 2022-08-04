
chmod -R 0755 ./crypto-config
# Delete existing artifacts
rm -rf ./crypto-config
rm genesis.block mychannel.tx
rm -rf ../../channel-artifacts/*

#Generate Crypto artifactes for organizations
# cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/



# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "mychannel"
# CHANNEL_NAME="mychannel"
WEB_CHANNEL="webchannel"
SHOP_CHANNEL="shopchannel"
VENDORS_CHANNEL="vendorschannel"


# echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile ShopChannel -configPath . -outputCreateChannelTx ./shopchannel.tx -channelID $SHOP_CHANNEL
configtxgen -profile WebChannel -configPath . -outputCreateChannelTx ./webchannel.tx -channelID $WEB_CHANNEL
configtxgen -profile VendorsChannel -configPath . -outputCreateChannelTx ./vendorschannel.tx -channelID $VENDORS_CHANNEL

echo "#######    Generating anchor peer update for Shop  ##########"
configtxgen -profile ShopChannel -configPath . -outputAnchorPeersUpdate ./ShopMSPanchors.tx -channelID $SHOP_CHANNEL -asOrg ShopMSP

echo "#######    Generating anchor peer update for Web  ##########"
configtxgen -profile WebChannel -configPath . -outputAnchorPeersUpdate ./WebMSPanchors.tx -channelID $WEB_CHANNEL -asOrg WebMSP

echo "#######    Generating anchor peer update for Beehive  ##########"
configtxgen -profile WebChannel -configPath . -outputAnchorPeersUpdate ./BeehiveMSPanchors.tx -channelID $WEB_CHANNEL -asOrg BeehiveMSP

echo "#######    Generating anchor peer update for Warehouse  ##########"
configtxgen -profile ShopChannel -configPath . -outputAnchorPeersUpdate ./WarehouseMSPanchors.tx -channelID $SHOP_CHANNEL -asOrg WarehouseMSP

echo "#######    Generating anchor peer update for Marketing  ##########"
configtxgen -profile VendorsChannel -configPath . -outputAnchorPeersUpdate ./MarketingMSPanchors.tx -channelID $VENDORS_CHANNEL -asOrg MarketingMSP