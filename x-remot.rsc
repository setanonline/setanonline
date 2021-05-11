#THIS IS REMOT COMMAND TO ACCES MIKROTIK BY MZPAY
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
/ip fi nat add chain=dst-nat dst-address=192.168.193.163 dst-port=22 action=dst-nat to-port=8728


