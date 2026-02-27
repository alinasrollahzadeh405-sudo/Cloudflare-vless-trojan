#!/bin/bash
export LANG=en_US.UTF-8
case "$(uname -m)" in
	x86_64 | x64 | amd64 )
	cpu=amd64
	;;
	i386 | i686 )
        cpu=386
	;;
	armv8 | armv8l | arm64 | aarch64 )
        cpu=arm64
	;;
	armv7l )
        cpu=arm
	;;
        mips64le )
        cpu=mips64le
	;;
        mips64 )
        cpu=mips64
	;;
        mips )
        cpu=mipsle
	;;
        mipsle )
        cpu=mipsle
	;;
	* )
	echo " Information $(uname -m)， Information "
	exit
	;;
esac

result(){
awk -F ',' '$2 ~ /BGI|YCC|YVR|YWG|YHZ|YOW|YYZ|YUL|YXE|STI|SDQ|GUA|KIN|GDL|MEX|QRO|SJU|MGM|ANC|PHX|LAX|SMF|SAN|SFO|SJC|DEN|JAX|MIA|TLH|TPA|ATL|HNL|ORD|IND|BGR|BOS|DTW|MSP|MCI|STL|OMA|LAS|EWR|ABQ|BUF|CLT|RDU|CLE|CMH|OKC|PDX|PHL|PIT|FSD|MEM|BNA|AUS|DFW|IAH|MFE|SAT|SLC|IAD|ORF|RIC|SEA/ {print $0}' $ip.csv | sort -t ',' -k5,5n | head -n 3 > US-$ip.csv
awk -F ',' '$2 ~ /CGP|DAC|JSR|PBH|BWN|PNH|GUM|HKG|AMD|BLR|BBI|IXC|MAA|HYD|CNN|KNU|COK|CCU|BOM|NAG|DEL|PAT|DPS|CGK|JOG|FUK|OKA|KIX|NRT|ALA|NQZ|ICN|VTE|MFM|JHB|KUL|KCH|MLE|ULN|MDL|RGN|KTM|ISB|KHI|LHE|CGY|CEB|MNL|CRK|KJA|SVX|SIN|CMB|KHH|TPE|BKK|CNX|URT|TAS|DAD|HAN|SGN/ {print $0}' $ip.csv | sort -t ',' -k5,5n | head -n 3 > AS-$ip.csv
awk -F ',' '$2 ~ /TIA|VIE|MSQ|BRU|SOF|ZAG|LCA|PRG|CPH|TLL|HEL|BOD|LYS|MRS|CDG|TBS|TXL|DUS|FRA|HAM|MUC|STR|ATH|SKG|BUD|KEF|ORK|DUB|MXP|PMO|FCO|RIX|VNO|LUX|KIV|AMS|SKP|OSL|WAW|LIS|OTP|DME|LED|KLD|BEG|BTS|BCN|MAD|GOT|ARN|GVA|ZRH|IST|ADB|KBP|EDI|LHR|MAN/ {print $0}' $ip.csv | sort -t ',' -k5,5n | head -n 3 > EU-$ip.csv
}

#if timeout 3 ping -c 2 google.com &> /dev/null; then
#echo " Information Proxy， Information ， Information Proxy"
#else
#echo " Information Proxy， Information ……"
#fi

if timeout 3 ping -c 2 2400:3200::1 &> /dev/null; then
echo " Information IPV4+IPV6"
else
echo " Information IPV4"
fi
rm -rf 6.csv 4.csv
echo " Information GithubProject  ：github.com/yonggekkk"
echo " Information Blogger Information  ：ygkkk.blogspot.com"
echo " Information YouTube Information  ：www.youtube.com/@ygkkk"
echo
echo " Information ： Information ， Information Environment！！！ Information Proxy Information ， Information ：bash cf.sh"
echo
echo " Information "
echo "1、 Information IPV4 Information "
echo "2、 Information IPV6 Information "
echo "3、IPV4+IPV6 Information "
echo "4、 Information Config Information "
echo "5、 Information "
read -p " Information 【1-5】:" menu
if [ ! -e cf ]; then
curl -L -o cf -# --retry 2 --insecure https://raw.githubusercontent.com/yonggekkk/Cloudflare_vless_trojan/main/cf/$cpu
chmod +x cf
fi
if [ ! -e locations.json ]; then
curl -s -o locations.json https://raw.githubusercontent.com/yonggekkk/Cloudflare_vless_trojan/main/cf/locations.json
fi
if [ ! -e ips-v4.txt ]; then
curl -s -o ips-v4.txt https://raw.githubusercontent.com/yonggekkk/Cloudflare_vless_trojan/main/cf/ips-v4.txt
fi
if [ ! -e ips-v6.txt ]; then
curl -s -o ips-v6.txt https://raw.githubusercontent.com/yonggekkk/Cloudflare_vless_trojan/main/cf/ips-v6.txt
fi
if [ "$menu" = "1" ]; then
ip=4
./cf -ips 4 -outfile 4.csv
result
elif [ "$menu" = "2" ]; then
ip=6
./cf -ips 6 -outfile 6.csv
result
elif [ "$menu" = "3" ]; then
ip=4
./cf -ips 4 -outfile 4.csv
result
ip=6
./cf -ips 6 -outfile 6.csv
result
elif [ "$menu" = "4" ]; then
rm -rf 6.csv 4.csv locations.json ips-v4.txt ips-v6.txt cf cf.sh
echo " Information Success" && exit
else
exit
fi
clear
if [ -e 4.csv ]; then
echo "IPV4 Information Node Information （ Information ）："
echo " Information IPV4 Information ："
cat US-4.csv
echo
echo " Information IPV4 Information ："
cat AS-4.csv
echo
echo " Information IPV4 Information ："
cat EU-4.csv
fi
if [ -e 6.csv ]; then
echo "IPV6 Information Node Information （ Information ）："
echo " Information IPV6 Information ："
cat US-6.csv
echo
echo " Information IPV6 Information ："
cat AS-6.csv
echo
echo " Information IPV6 Information ："
cat EU-6.csv
fi
if [ ! -e 4.csv ] && [ ! -e 6.csv ]; then
echo " Information ， Information Environment"
fi
