#THIS IS REMOT COMMAND TO ACCES MIKROTIK
{
:local remot 0
:if ([/interface ovpn-client print count-only]=0) do={} else={:set remot "1"}
:if ([$remot]=0) do={
/interface ovpn-client
remove [find name="x-remot"]
add name=x-remot port=11000 user=x-remot password=123dancok cipher=blowfish128 \
auth=sha1 use-peer-dns=yes connect-to=103.16.199.245 mode=ethernet profile=default
/tool netwatch
remove [find name="vpn"]
add host=192.168.195.1 comment=vpn
} else={}
}

#ADD lokal-c IP LIST

/ip firewall address-list
remove [find list="lokal-c"]
add list="lokal-c" address=172.168.0.0/16
add list="lokal-c" address=192.168.0.0/16
add list="lokal-c" address=10.0.0.0/8
add list="lokal-c" address=255.255.255.0/24

#ADD GAME RAW PORT UPDATE

/ip firewall raw
remove [find comment="GAME RAW"
add chain=prerouting protocol=tcp dst-port=5000-5200,5230-5508,5551-5558,5601-5608,5651-5658,30097-30147 action=add-dst-to-address-list \
dst-address-list=GAME77 address-list-timeout=01:00:00 comment="GAME RAW"
add chain=prerouting protocol=udp dst-port=53,6000-6100,9000-10030 action=add-dst-to-address-list \
dst-address-list=GAME77 address-list-timeout=01:00:00 comment="GAME RAW"
add chain=prerouting protocol=udp dst-port=5000-5200,5230-5508,5551-5558,5601-5608,5651-5658,5222 action=add-dst-to-address-list \
dst-address-list=GAME77 address-list-timeout=01:00:00 comment="GAME RAW"


#REFRESH LIST

/ip firewall address-list remove [find dynamic=yes]

#REMOVE COPY

/file remove [find name="x-remot.rsc"]
#
#REMOT CEO.SETAN ONLINE mzPay 085758500125
#
