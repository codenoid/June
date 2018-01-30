.PHONY: install

install:
	if hash gdate 2>/dev/null; then
		echo "Installing Crystal"
		apt-key adv --keyserver keys.gnupg.net --recv-keys 09617FD37CC06B54
		echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list
		apt-get update
		apt-get install \
	    libbsd-dev \
	  	libedit-dev \
	  	libevent-core-2.0-5 \
	  	libevent-dev \
	  	libevent-extra-2.0-5 \
	  	libevent-openssl-2.0-5 \
	  	libevent-pthreads-2.0-5 \
	  	libgmp-dev \
	  	libgmpxx4ldbl \
	  	libssl-dev \
	  	libxml2-dev \
	  	libyaml-dev \
	  	libreadline-dev \
	  	automake \
	  	libtool \
	  	git \
	  	llvm \
	  	libpcre3-dev \
	  	libgc-dev \
	  	zlib1g-dev \
	  	build-essential -y
		apt-get install crystal
	fi
	crystal -v
	crystal build src/June.cr --release --no-debug
	mv June june
	mv june /usr/bin/
