createCertificateForwh() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/wh.mercadona.es/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca.wh.mercadona.es --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-wh-mercadona-es.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-wh-mercadona-es.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-wh-mercadona-es.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-wh-mercadona-es.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/msp/config.yaml

  echo
  echo "Register peer0"
  echo

  fabric-ca-client register --caname ca.wh.mercadona.es --id.name wh1 --id.secret wh1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  echo
  echo "Register peer1"
  echo

  fabric-ca-client register --caname ca.wh.mercadona.es --id.name wh2 --id.secret wh2pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.wh.mercadona.es --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.wh.mercadona.es --id.name whadmin --id.secret whadminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/wh.mercadona.es/peers
  mkdir -p ../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://wh1:wh1pw@localhost:11054 --caname ca.wh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/msp --csr.hosts wh1.wh.mercadona.es --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://wh1:wh1pw@localhost:11054 --caname ca.wh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/tls --enrollment.profile tls --csr.hosts wh1.wh.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/tlsca/tlsca.wh.mercadona.es-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/ca
  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh1.wh.mercadona.es/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/ca/ca.wh.mercadona.es-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://wh2:wh2pw@localhost:11054 --caname ca.wh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh2.wh.mercadona.es/msp --csr.hosts wh2.wh.mercadona.es --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh2.wh.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://wh2:wh2pw@localhost:11054 --caname ca.wh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh2.wh.mercadona.es/tls --enrollment.profile tls --csr.hosts wh2.wh.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh2.wh.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh2.wh.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh2.wh.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh2.wh.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh2.wh.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/peers/wh2.wh.mercadona.es/tls/server.key
  # -----------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/wh.mercadona.es/users
  mkdir -p ../crypto-config/peerOrganizations/wh.mercadona.es/users/User1@wh.mercadona.es

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca.wh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/users/User1@wh.mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/wh.mercadona.es/users/Admin@wh.mercadona.es

  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://whadmin:whadminpw@localhost:11054 --caname ca.wh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/users/Admin@wh.mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/wh/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/wh.mercadona.es/users/Admin@wh.mercadona.es/msp/config.yaml

}

createCertificateForwh