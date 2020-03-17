require_relative './load_env_file.rb'

# Instance the global environment variables
conf = LoadEnvFile.instance
configuration = conf.load_app_config_file('env.yml')
$server_host = configuration['Api_server_data']['server_host']
$server_port = configuration['Api_server_data']['server_port']
$server_extension = configuration['Api_server_data']['server_extension']
$server_version = configuration['Api_server_data']['server_version']
$server_base_endpoint = "#{$server_host}:#{$server_port}#{$server_extension}#{$server_version}"
$server_timeout = configuration['Api_server_data']['timeout']

$mongodb_host = configuration['Mongodb']['mongo_host']
$mongodb_port = configuration['Mongodb']['mongo_port']
$mongodb_username = configuration['Mongodb']['mongo_username']
$mongodb_password = configuration['Mongodb']['mongo_password']
$mongodb_db_name = configuration['Mongodb']['mongo_db_name']

$cassandra_host = configuration['Cassandra']['cassandra_host']
$cassandra_port = configuration['Cassandra']['cassandra_port']
$cassandra_username = configuration['Cassandra']['cassandra_username']
$cassandra_password = configuration['Cassandra']['cassandra_password']
$cassandra_key_space = configuration['Cassandra']['cassandra_keyspace']
