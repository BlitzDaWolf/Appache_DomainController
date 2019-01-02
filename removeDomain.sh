domain=

while [ "$1" != "" ]; do
    case $1 in
		-d | --domain )    		shift
        						domain=$1
                                ;;
    esac
    shift
done


# Test code to verify command line processing

errors=
echo "domain: 	$domain"

if [ "$domain" = "" ]; then
	echo "No domain was given"
	errors=$error_default
fi

if [ "$errors" = "1" ]; then
	exit 1
fi

a2dissite "$domain"
service apache2 reload
FILE="/etc/apache2/sites-available/$domain.conf"
rm $FILE