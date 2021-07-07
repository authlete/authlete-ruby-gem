# :nodoc:
#
# Copyright (C) 2014-2021 Authlete, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require 'authlete'
require 'json'
require 'minitest/autorun'


class HskTest < Minitest::Test
  KTY         = 'EC'
  USE         = 'sig'
  ALG         = 'ES256'
  KID         = 'jane'
  HSM_NAME    = 'google'
  HANDLE      = '<handle>'
  PUBLIC_KEY  = '<public-key>'


  def generate_json
    return <<~JSON
      {
        "kty":        "EC",
        "use":        "sig",
        "alg":        "ES256",
        "kid":        "jane",
        "hsmName":    "google",
        "handle":     "<handle>",
        "publicKey":  "<public-key>"
      }
    JSON
  end


  def generate_hash
    {
      kty:        'EC',
      use:        'sig',
      alg:        'ES256',
      kid:        'jane',
      hsmName:    'google',
      handle:     '<handle>',
      publicKey:  '<public-key>'
    }
  end


  def set_params(obj)
    obj.kty         = KTY
    obj.use         = USE
    obj.alg         = ALG
    obj.kid         = KID
    obj.hsmName     = HSM_NAME
    obj.handle      = HANDLE
    obj.publicKey   = PUBLIC_KEY
  end


  def match(obj)
    assert_equal KTY,         obj.kty
    assert_equal USE,         obj.use
    assert_equal ALG,         obj.alg
    assert_equal KID,         obj.kid
    assert_equal HSM_NAME,    obj.hsmName
    assert_equal HANDLE,      obj.handle
    assert_equal PUBLIC_KEY,  obj.publicKey
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Hsk.new(hsh)

    match(actual)
  end


  def test_setters
    actual = Authlete::Model::Hsk.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Hsk.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
