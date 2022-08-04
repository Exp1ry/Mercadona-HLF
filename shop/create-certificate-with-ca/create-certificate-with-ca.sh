createCertificateForshop() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/shop.mercadona.es/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.shop.mercadona.es --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-shop-mercadona-es.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-shop-mercadona-es.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-shop-mercadona-es.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-shop-mercadona-es.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/msp/config.yaml

  echo
  echo "Register peer0"
  echo

  fabric-ca-client register --caname ca.shop.mercadona.es --id.name shop1 --id.secret shop1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  echo
  echo "Register peer1"
  echo

  fabric-ca-client register --caname ca.shop.mercadona.es --id.name shop2 --id.secret shop2pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.shop.mercadona.es --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.shop.mercadona.es --id.name shopadmin --id.secret shopadminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/shop.mercadona.es/peers
  mkdir -p ../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://shop1:shop1pw@localhost:8054 --caname ca.shop.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/msp --csr.hosts shop1.shop.mercadona.es --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://shop1:shop1pw@localhost:8054 --caname ca.shop.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/tls --enrollment.profile tls --csr.hosts shop1.shop.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/tlsca/tlsca.shop.mercadona.es-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/ca
  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop1.shop.mercadona.es/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/ca/ca.shop.mercadona.es-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://shop2:shop2pw@localhost:8054 --caname ca.shop.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop2.shop.mercadona.es/msp --csr.hosts shop2.shop.mercadona.es --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop2.shop.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://shop2:shop2pw@localhost:8054 --caname ca.shop.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop2.shop.mercadona.es/tls --enrollment.profile tls --csr.hosts shop2.shop.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop2.shop.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop2.shop.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop2.shop.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop2.shop.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop2.shop.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/peers/shop2.shop.mercadona.es/tls/server.key
  # -----------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/shop.mercadona.es/users
  mkdir -p ../crypto-config/peerOrganizations/shop.mercadona.es/users/User1@shop.mercadona.es

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.shop.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/users/User1@shop.mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/shop.mercadona.es/users/Admin@shop.mercadona.es

  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://shopadmin:shopadminpw@localhost:8054 --caname ca.shop.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/users/Admin@shop.mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/shop/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/shop.mercadona.es/users/Admin@shop.mercadona.es/msp/config.yaml

}

createCertificateForshop