default[:elasticsearch][:pkgs] = %w[java-1.7.0-openjdk]

# elastic search
default[:elasticsearch][:filename] = "elasticsearch-1.7.1.tar.gz"
default[:elasticsearch][:remote_uri] = "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz"
default[:elasticsearch][:checksum]="86a0c20eea6ef55b14345bff5adf896e6332437b19180c4582a346394abde019"
default[:elasticsearch][:install_dir] = "/usr/local"

# service wrapper
default[:elasticsearch_srv][:filename] = "elasticsearch-servicewrapper.tar.gz"
default[:elasticsearch_srv][:remote_uri] = "http://github.com/elasticsearch/elasticsearch-servicewrapper/tarball/master"
default[:elasticsearch_srv][:checksum]=""
default[:elasticsearch_srv][:install_dir] = "/usr/local/elasticsearch-1.7.1"
default[:elasticsearch_srv][:service_name] = "elasticsearch"
