#!/bin/bash
export LANG=en_US.UTF-8
arch="$(uname -m)"
case "$arch" in
x86_64|x64|amd64)   cpu=amd64 ;;
i386|i686)          cpu=386 ;;
armv8|armv8l|arm64|aarch64) cpu=arm64 ;;
armv7l)             cpu=arm ;;
mips64le)           cpu=mips64le ;;
mips64)             cpu=mips64 ;;
mips|mipsle)        cpu=mipsle ;;
*)
echo " Information  $arch， Information " && exit
;;
esac
INIT_SYSTEM=$(cat /proc/1/comm 2>/dev/null)
showports(){
if [ "$INIT_SYSTEM" = "systemd" ]; then
ports=$(ps aux | grep "$HOME/cfs5http/cfwp" 2>/dev/null | grep -v grep | sed -n 's/.*client_ip=:\([0-9]\+\).*/\1/p')
else
ports=$(ps w | grep "$HOME/cfs5http/cfwp" 2>/dev/null | grep -v grep | sed -n 's/.*client_ip=:\([0-9]\+\).*/\1/p')
fi
}
showmenu(){
showports
if [ -n "$ports" ]; then
echo " Information Node Information ："
echo "$ports" | while IFS= read -r port; do
echo "  - $port"
done
else
echo " Information Install Information Node"
fi
}
delsystem(){
local port=$1
if [ "$INIT_SYSTEM" = "systemd" ]; then
systemctl stop "cf_${port}.service" >/dev/null 2>&1
systemctl disable "cf_${port}.service" >/dev/null 2>&1
rm -f "/etc/systemd/system/cf_${port}.service"
systemctl daemon-reload >/dev/null 2>&1
else
/etc/init.d/cf_$port stop >/dev/null 2>&1
/etc/init.d/cf_$port disable >/dev/null 2>&1
rm -f /etc/init.d/cf_$port
killall -9 cf_$port >/dev/null 2>&1
fi
}
echo "================================================================"
echo " Information GithubProject ：github.com/yonggekkk"
echo " Information Blogger Information  ：ygkkk.blogspot.com"
echo " Information YouTube Information  ：www.youtube.com/@ygkkk"
echo "================================================================"
echo "Cloudflare Socks5/Http Information ProxyScript"
echo " Information ：Workers Information 、Pages Information 、Custom Information "
echo " Information ：ECH-TLS、 Information TLS、 Information TLS  Information Proxy Information ， Information "
echo "Script Information ：bash cfsh.sh"
echo "================================================================"
echo "1、 Information CF-Socks5/HttpNodeConfig"
echo "2、 Information NodeConfig Information "
echo "3、 Information Node"
echo "4、 Information ConfigNode"
echo "5、 Information "
echo
showmenu
echo
read -p " Information 【1-5】:" menu
if [ "$menu" = "1" ]; then
mkdir -p "$HOME/cfs5http"
if [ ! -s "$HOME/cfs5http/cfwp" ]; then
curl -L -o "$HOME/cfs5http/cfwp" -# --retry 2 --insecure https://raw.githubusercontent.com/yonggekkk/Cloudflare-vless-trojan/main/s5http_wkpgs/linux-$cpu
chmod +x "$HOME/cfs5http/cfwp"
fi
echo
read -p "1、CF workers/pages/Custom Information Settings（ Information ： Information :443 Information 80 Information ）:" menu
cf_domain="$menu"
echo
read -p "2、 Information Settings（ Information Default： Information ）:" menu
token="${menu:-}"
echo
read -p "3、 Information Settings（ Information Default：30000）:" menu
port="${menu:-30000}"
echo
read -p "4、 Information Address Information IP/ Information （ Information Default：yg1.ygkkk.dpdns.org）:" menu
cf_cdnip="${menu:-yg1.ygkkk.dpdns.org}"
echo
read -p "5、ProxyIPSettings（ Information Default：Usage Information ProxyIP）:" menu
pyip="${menu:-}"
echo
read -p "6、DoH Information Settings（ Information Default：dns.alidns.com/dns-query）:" menu
dns="${menu:-dns.alidns.com/dns-query}"
echo
read -p "7、ECH Information （y= Information , n= Information ,  Information ： Information ）:" menu
enable_ech=$([ -z "$menu" ] || [ "$menu" = y ] && echo y || echo n)
echo
read -p "8、 Information （y= Information Proxy, n= Information Proxy,  Information Default:  Information Proxy）:" menu
cnrule=$([ -z "$menu" ] || [ "$menu" = y ] && echo y || echo n)
echo
SCRIPT="$HOME/cfs5http/cf_$port.sh"
LOG="$HOME/cfs5http/$port.log"
cat > "$SCRIPT" << EOF
#!/bin/bash
[ -f /proc/1/comm ] && INIT_SYSTEM=\$(cat /proc/1/comm)
CMD="$HOME/cfs5http/cfwp \
client_ip=:$port \
dns=$dns \
cf_domain=$cf_domain \
cf_cdnip=$cf_cdnip \
token=$token \
enable_ech=$enable_ech \
cnrule=$cnrule \
pyip=$pyip"
if [ "\$INIT_SYSTEM" = "systemd" ]; then
exec \$CMD > $LOG 2>&1
else
nohup \$CMD > "$LOG" 2>&1 &
fi
EOF
chmod +x "$SCRIPT"
if [ "$INIT_SYSTEM" = "systemd" ]; then
cat > "/etc/systemd/system/cf_$port.service" << EOF
[Unit]
Description=CF $port Service
After=network.target
[Service]
Type=simple
ExecStart=/bin/bash -c $SCRIPT
Restart=always
RestartSec=5
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload >/dev/null 2>&1
systemctl start "cf_$port.service" >/dev/null 2>&1
systemctl enable "cf_$port.service" >/dev/null 2>&1
elif [ "$INIT_SYSTEM" = "procd" ]; then
cat > "/etc/init.d/cf_$port" << EOF
#!/bin/sh /etc/rc.common
START=99
STOP=10
USE_PROCD=1
SCRIPT="$HOME/cfs5http/cf_$port.sh"
start_service() {
procd_open_instance
procd_set_param command /bin/sh -c "sleep 10 && /bin/bash \"$SCRIPT\""
procd_set_param respawn
procd_close_instance
}
EOF
chmod +x "/etc/init.d/cf_$port"
/etc/init.d/cf_$port start >/dev/null 2>&1
/etc/init.d/cf_$port enable >/dev/null 2>&1
else
bash "$SCRIPT"
echo " Information  /bin/bash $SCRIPT  Information Settings Information "
fi
sleep 5 && echo "Install Information ，Socks5/HttpNode Information ， Information  bash cfsh.sh  Information 2， Information NodeConfig Information " 
echo
until grep -q ' Information \| Information Address Information \| Information IP' "$HOME/cfs5http/$port.log" 2>/dev/null; do sleep 1; done; head -n 16 "$HOME/cfs5http/$port.log" 2>/dev/null | grep ' Information \| Information Address Information \| Information IP'
echo
elif [ "$menu" = "2" ]; then
showmenu
echo
read -p " Information NodeConfig Information （ Information ）:" port
{ echo "$port Information NodeConfig Information ：" ; echo "------------------------------------"; sed -n '1,16p' "$HOME/cfs5http/$port.log" | grep ' Information \| Information Address Information \| Information IP' ; echo "------------------------------------" ; sed '1,16d' "$HOME/cfs5http/$port.log" | tail -n 10; }
echo
elif [ "$menu" = "3" ]; then
showmenu
echo
read -p " Information Node（ Information ）:" port
delsystem "$port"
pid=$(lsof -t -i :$port)
kill -9 $pid >/dev/null 2>&1
rm -rf "$HOME/cfs5http/$port.log" "$HOME/cfs5http/cf_$port.sh"
echo " Information  $port  Information "
elif [ "$menu" = "4" ]; then
showmenu
echo
read -p " Information Node？(y/n): " menu
if [ "$menu" != "y" ]; then
echo " Information " && exit
fi
echo "$ports" | while IFS= read -r port; do
delsystem "$port"
done
ps | grep '[c]fwp' | awk '{print $1}' | xargs -r kill -9
rm -rf "$HOME/cfs5http" cfsh.sh china_ipv4.txt china_ipv6.txt
echo " Information Node Information "
else
exit
fi
