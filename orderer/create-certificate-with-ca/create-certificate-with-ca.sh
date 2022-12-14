createCretificateForOrderer() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/ordererOrganizations/mercadona.es

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/ordererOrganizations/mercadona.es

  fabric-ca-client enroll -u https://admin:adminpw@localhost:13054 --caname ca-orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-13054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-13054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-13054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-13054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/ordererOrganizations/mercadona.es/msp/config.yaml

  echo
  echo "Register orderer"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer2"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer3"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register the orderer admin"
  echo

  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  mkdir -p ../crypto-config/ordererOrganizations/mercadona.es/orderers
  # mkdir -p ../crypto-config/ordererOrganizations/mercadona.es/orderers/mercadona.es

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p ../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es

  echo
  echo "## Generate the orderer msp"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:13054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/msp --csr.hosts orderer.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:13054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/tls --enrollment.profile tls --csr.hosts orderer.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/msp/tlscacerts/tlsca.mercadona.es-cert.pem

  mkdir ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/msp/tlscacerts/tlsca.mercadona.es-cert.pem

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p ../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es

  echo
  echo "## Generate the orderer2 msp"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:13054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/msp --csr.hosts orderer2.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the orderer2-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:13054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/tls --enrollment.profile tls --csr.hosts orderer2.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer2.mercadona.es/msp/tlscacerts/tlsca.mercadona.es-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p ../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es

  echo
  echo "## Generate the orderer3 msp"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:13054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/msp --csr.hosts orderer3.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/msp/config.yaml

  echo
  echo "## Generate the orderer3-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:13054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/tls --enrollment.profile tls --csr.hosts orderer3.mercadona.es --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/orderers/orderer3.mercadona.es/msp/tlscacerts/tlsca.mercadona.es-cert.pem
  # ---------------------------------------------------------------------------

  mkdir -p ../crypto-config/ordererOrganizations/mercadona.es/users
  mkdir -p ../crypto-config/ordererOrganizations/mercadona.es/users/Admin@mercadona.es

  echo
  echo "## Generate the admin msp"
  echo

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:13054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/users/Admin@mercadona.es/msp --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/mercadona.es/users/Admin@mercadona.es/msp/config.yaml

}

createCretificateForOrderer