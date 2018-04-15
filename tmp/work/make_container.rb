require 'fog'

CONOHA_TENANT_NAME = ('gnct68180377')
CONOHA_USER_NAME = ('gncu68180377')
CONOHA_API_PASSWORD = ('AUNjIKV@ofK8')
CONOHA_API_AUTH_URL = ('https://identity.tyo1.conoha.io/v2.0')
CONOHA_CONTAINER_NAME = ('shirobuhi_obs')

strage = Fog::Storage.new(
  provider: 'OpenStack',
  openstack_tenant: CONOHA_TENANT_NAME,
  openstack_username: CONOHA_USER_NAME,
  openstack_api_key: CONOHA_API_PASSWORD,
  openstack_auth_url: CONOHA_API_AUTH_URL + '/tokens',
)

strage.put_container(CONOHA_CONTAINER_NAME, public: true, headers: {'X-Web-Mode' => 'true'})
