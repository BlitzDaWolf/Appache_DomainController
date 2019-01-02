port=80
host=
domain=

while [ "$1" != "" ]; do
    case $1 in
        -p | --port )           shift
                                port=$1
                                ;;
        -h | --host )    		shift
        						host=$1
                                ;;
		-d | --domain )    		shift
        						domain=$1
                                ;;
    esac
    shift
done


# Test code to verify command line processing

errors=

echo "port: 		$port"
echo "host: 		$host"
echo "domain: 	$domain"

if [ "$host" = "" ]; then
	echo "No host was given"
	errors=1
fi
if [ "$domain" = "" ]; then
	echo "No domain was given"
	errors=1
fi

if [ "$errors" = "1" ]; then
	exit 1
fi

FILE="/etc/apache2/sites-available/$domain.conf"
echo $FILE
{
echo "<VirtualHost *:80>"
echo "    ServerName $domain"
echo "    <Proxy *>"
echo "    	order deny,allow"
echo "        Allow from all"
echo "    </Proxy>"
echo "    ProxyPass / http://$host:$port/"
echo "    ProxyPassReverse / http://$host:$port/"
echo "</VirtualHost>"
} > $FILE

a2ensite $domain
service apache2 reload