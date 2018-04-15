CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'OpenStack',
    openstack_tenant: 'gnct68180377',
    openstack_username: 'gncu68180377',
    openstack_api_key: 'AUNjIKV@ofK8',
    openstack_auth_url: 'https://identity.tyo1.conoha.io/v2.0' + '/tokens',
  }

  config.fog_directory = 'shirobuhi_obs'
  config.storage :fog
  config.asset_host = 'https://object-storage.tyo1.conoha.io/v1/nc_ae525541a58a443c98717ded126b6ac3' + '/' + 'shirobuhi_obs'
end

