createCertificateFormarketing() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/marketing.mercadona.es/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:12054 --caname ca.marketing.mercadona.es --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-marketing-mercadona-es.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-marketing-mercadona-es.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-marketing-mercadona-es.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-marketing-mercadona-es.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/msp/config.yaml

  echo
  echo "Register peer0"
  echo

  fabric-ca-client register --caname ca.marketing.mercadona.es --id.name marketing1 --id.secret marketing1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  echo
  echo "Register peer1"
  echo

  fabric-ca-client register --caname ca.marketing.mercadona.es --id.name marketing2 --id.secret marketing2pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.marketing.mercadona.es --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.marketing.mercadona.es --id.name marketingadmin --id.secret marketingadminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/marketing.mercadona.es/peers
  mkdir -p ../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://marketing1:marketing1pw@localhost:12054 --caname ca.marketing.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/msp --csr.hosts marketing1.marketing.mercadona.es --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://marketing1:marketing1pw@localhost:12054 --caname ca.marketing.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/tls --enrollment.profile tls --csr.hosts marketing1.marketing.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/tlsca/tlsca.marketing.mercadona.es-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/ca
  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing1.marketing.mercadona.es/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/ca/ca.marketing.mercadona.es-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://marketing2:marketing2pw@localhost:12054 --caname ca.marketing.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing2.marketing.mercadona.es/msp --csr.hosts marketing2.marketing.mercadona.es --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing2.marketing.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://marketing2:marketing2pw@localhost:12054 --caname ca.marketing.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing2.marketing.mercadona.es/tls --enrollment.profile tls --csr.hosts marketing2.marketing.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing2.marketing.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing2.marketing.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing2.marketing.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing2.marketing.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing2.marketing.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/peers/marketing2.marketing.mercadona.es/tls/server.key
  # -----------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/marketing.mercadona.es/users
  mkdir -p ../crypto-config/peerOrganizations/marketing.mercadona.es/users/User1@marketing.mercadona.es

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:12054 --caname ca.marketing.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/users/User1@marketing.mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/marketing.mercadona.es/users/Admin@marketing.mercadona.es

  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://marketingadmin:marketingadminpw@localhost:12054 --caname ca.marketing.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/users/Admin@marketing.mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/marketing/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/marketing.mercadona.es/users/Admin@marketing.mercadona.es/msp/config.yaml

}

createCertificateFormarketing