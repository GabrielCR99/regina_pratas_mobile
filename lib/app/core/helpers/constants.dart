class Constants {
  const Constants._();

  // * ENV
  static const envBaseUrlKey = 'base_url';
  static const envRestClientConnectTimeout = 'rest_client_connect_timeout';
  static const envRestClientReceiveTimeout = 'rest_client_receive_timeout';

  // * LOCAL STORAGE
  static const localStorageAccessTokenKey = '/LOCAL_STORAGE_ACCESS_TOKEN_KEY/';
  static const localStorageRefreshTokenKey =
      '/LOCAL_STORAGE_REFRESH_TOKEN_KEY/';
  static const localStorageLoggedUserDataKey =
      '/LOCAL_STORAGE_LOGGED_USER_DATA_KEY/';

  static const restClientAuthRequiredKey = 'auth_required';
}
