# apr/09/2025 20:41:39 by RouterOS 6.49.17
# software id = 
#
#
#
/interface bridge
add ingress-filtering=yes name=SW vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] comment=KYIV-SW-2 disable-running-check=no
set [ find default-name=ether2 ] comment=KYIV-SW-3 disable-running-check=no
set [ find default-name=ether3 ] comment=IS-SRV-1 disable-running-check=no
set [ find default-name=ether4 ] comment=IS-SRV-WIN disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
set [ find default-name=ether6 ] disable-running-check=no
set [ find default-name=ether7 ] disable-running-check=no
set [ find default-name=ether8 ] comment="Home Server"
/interface vlan
add comment=MGMT interface=SW name=MGMT vlan-id=500
add comment=OSPF interface=SW name=OSPF vlan-id=800
add comment=SRV interface=SW name=SRV vlan-id=700
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=pool1 ranges=172.16.0.3-172.16.0.10
/routing ospf instance
add name=OSPF_ID router-id=1.1.1.1
/routing ospf area
add instance=OSPF_ID name=MAIN
/interface bridge port
add bridge=SW comment=KYIV-SW-2 interface=ether1
add bridge=SW comment=KYIV-SW-3 interface=ether2
add bridge=SW comment=IS-SRV-WIN frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether4 pvid=700
add bridge=SW comment=IS-SRV-1 frame-types=\
    admit-only-untagged-and-priority-tagged ingress-filtering=yes interface=\
    ether3 pvid=700
/ip neighbor discovery-settings
set discover-interface-list=none
/interface bridge vlan
add bridge=SW comment=MGMT tagged=SW,ether1,ether2 vlan-ids=500,800
add bridge=SW comment=SRV tagged=SW untagged=ether3,ether4 vlan-ids=700
/ip address
add address=192.168.10.1/24 comment=Management interface=MGMT network=\
    192.168.10.0
add address=172.16.0.1/24 comment=Server interface=SRV network=172.16.0.0
add address=172.16.8.1/26 comment="OSPF Instance" interface=OSPF network=\
    172.16.8.0
add address=192.168.56.2/24 comment="Home Server" interface=ether8 network=\
    192.168.56.0
/ip dhcp-client
add add-default-route=no interface=ether8
/ip dns
set allow-remote-requests=yes servers=192.168.0.10
/ip firewall address-list
add address=172.16.0.0/24 list=ALLOW_NET
add address=192.168.0.0/24 list=ALLOW_MGMT
add address=172.16.8.0/26 list=ALLOW_MGMT
add address=192.168.10.0/24 list=ALLOW_MGMT
add address=192.168.0.0/24 list=ALLOW_NET
add address=192.168.10.0/24 list=ALLOW_NET
add address=192.168.56.0/24 list=ALLOW_NET
/ip firewall filter
add action=drop chain=input comment="Drop invalid connection" \
    connection-state=invalid
add action=accept chain=forward comment="Allow forward" connection-state=\
    established,related
add action=accept chain=input comment="Allow OSPF" protocol=ospf
add action=accept chain=input comment="Allow access to router" dst-port=\
    22,23,8291 protocol=tcp src-address-list=ALLOW_MGMT
add action=accept chain=input comment="Allow ICMP" protocol=icmp \
    src-address-list=ALLOW_NET
add action=accept chain=input comment="Allow internet on router" \
    connection-state=established,related
add action=accept chain=input comment="Allow DNS to router" connection-state=\
    "" dst-port=53 protocol=udp src-address-list=ALLOW_NET
add action=drop chain=input comment="Drop all" log=yes src-address-list=\
    !ALLOW_NET
/ip firewall nat
add action=src-nat chain=srcnat disabled=yes out-interface=SRV to-addresses=\
    172.16.0.1
add action=masquerade chain=srcnat disabled=yes out-interface=MGMT \
    src-address=172.16.0.0/24 to-addresses=172.16.0.1
/ip firewall service-port
set ftp disabled=yes
set tftp disabled=yes
set h323 disabled=yes
set sip disabled=yes
set pptp disabled=yes
/ip route
add distance=1 gateway=192.168.56.1
/ip service
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/radius
add address=172.16.0.2 authentication-port=6700 disabled=yes service=dhcp \
    src-address=192.168.10.1
add address=172.16.0.3 secret=testing123 service=login src-address=\
    192.168.10.1
/routing ospf interface
add comment=Servers interface=SRV
add comment=OSPF interface=OSPF
/routing ospf network
add area=MAIN comment=Servers network=172.16.0.0/24
add area=MAIN comment=OSPF network=172.16.8.0/26
add area=backbone disabled=yes network=192.168.10.0/24
/snmp
set contact=o.zon77788@gmail.com enabled=yes location=Prolisky
/system clock
set time-zone-autodetect=no time-zone-name=Europe/Kyiv
/system clock manual
set time-zone=+02:00
/system identity
set name=IS-RT-1
/system note
set show-at-login=no
/user aaa
set use-radius=yes
