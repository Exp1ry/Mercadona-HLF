createCertificateForweb() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/web.mercadona.es/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.web.mercadona.es --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-web-mercadona-es.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-web-mercadona-es.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-web-mercadona-es.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-web-mercadona-es.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/msp/config.yaml

  echo
  echo "Register peer0"
  echo

  fabric-ca-client register --caname ca.web.mercadona.es --id.name web1 --id.secret web1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  echo
  echo "Register peer1"
  echo

  fabric-ca-client register --caname ca.web.mercadona.es --id.name web2 --id.secret web2pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.web.mercadona.es --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.web.mercadona.es --id.name webadmin --id.secret webadminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/web.mercadona.es/peers
  mkdir -p ../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://web1:web1pw@localhost:9054 --caname ca.web.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/msp --csr.hosts web1.web.mercadona.es --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://web1:web1pw@localhost:9054 --caname ca.web.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/tls --enrollment.profile tls --csr.hosts web1.web.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/tlsca/tlsca.web.mercadona.es-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/ca
  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web1.web.mercadona.es/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/ca/ca.web.mercadona.es-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://web2:web2pw@localhost:9054 --caname ca.web.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web2.web.mercadona.es/msp --csr.hosts web2.web.mercadona.es --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web2.web.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://web2:web2pw@localhost:9054 --caname ca.web.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web2.web.mercadona.es/tls --enrollment.profile tls --csr.hosts web2.web.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web2.web.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web2.web.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web2.web.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web2.web.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web2.web.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/peers/web2.web.mercadona.es/tls/server.key
  # -----------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/web.mercadona.es/users
  mkdir -p ../crypto-config/peerOrganizations/web.mercadona.es/users/User1@web.mercadona.es

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:9054 --caname ca.web.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/users/User1@web.mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/web.mercadona.es/users/Admin@web.mercadona.es

  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://webadmin:webadminpw@localhost:9054 --caname ca.web.mercadona.es -M ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/users/Admin@web.mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/web/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/web.mercadona.es/users/Admin@web.mercadona.es/msp/config.yaml

}

createCertificateForweb