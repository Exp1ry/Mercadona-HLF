createCertificateForbh() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/bh.mercadona.es/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca.bh.mercadona.es --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-bh-mercadona-es.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-bh-mercadona-es.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-bh-mercadona-es.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-bh-mercadona-es.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/msp/config.yaml

  echo
  echo "Register peer0"
  echo

  fabric-ca-client register --caname ca.bh.mercadona.es --id.name bh1 --id.secret bh1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  echo
  echo "Register peer1"
  echo

  fabric-ca-client register --caname ca.bh.mercadona.es --id.name bh2 --id.secret bh2pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.bh.mercadona.es --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.bh.mercadona.es --id.name bhadmin --id.secret bhadminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/bh.mercadona.es/peers
  mkdir -p ../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://bh1:bh1pw@localhost:10054 --caname ca.bh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/msp --csr.hosts bh1.bh.mercadona.es --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://bh1:bh1pw@localhost:10054 --caname ca.bh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/tls --enrollment.profile tls --csr.hosts bh1.bh.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/tlsca/tlsca.bh.mercadona.es-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/ca
  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh1.bh.mercadona.es/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/ca/ca.bh.mercadona.es-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://bh2:bh2pw@localhost:10054 --caname ca.bh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh2.bh.mercadona.es/msp --csr.hosts bh2.bh.mercadona.es --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh2.bh.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://bh2:bh2pw@localhost:10054 --caname ca.bh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh2.bh.mercadona.es/tls --enrollment.profile tls --csr.hosts bh2.bh.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh2.bh.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh2.bh.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh2.bh.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh2.bh.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh2.bh.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/peers/bh2.bh.mercadona.es/tls/server.key
  # -----------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/bh.mercadona.es/users
  mkdir -p ../crypto-config/peerOrganizations/bh.mercadona.es/users/User1@bh.mercadona.es

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca.bh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/users/User1@bh.mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/bh.mercadona.es/users/Admin@bh.mercadona.es

  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://bhadmin:bhadminpw@localhost:10054 --caname ca.bh.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/users/Admin@bh.mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/bh/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/bh.mercadona.es/users/Admin@bh.mercadona.es/msp/config.yaml

}

createCertificateForbh