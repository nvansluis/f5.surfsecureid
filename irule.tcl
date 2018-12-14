when ACCESS_SAML_AUTHN {
    set username "[ACCESS::session data get session.logon.last.username]"
    set SURFconextIdentifier "urn:collab:person:some-organisation.example.org:$username"
        
    # Variable authn_request is set to SAML authentication request payload generated.
    set authn_request [ ACCESS::saml authn ]
        
    set subject "<saml:Subject xmlns:saml=\"urn:oasis:names:tc:SAML:2.0:assertion\"> \
                 <saml:NameID Format=\"urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified\"> \
                 $SURFconextIdentifier \
                 </saml:NameID></saml:Subject>"
                     
    set new_authn_request [ string map [list "<samlp:NameIDPolicy" "$subject<samlp:NameIDPolicy"] $authn_request ]
        
    # Variable new_authn_request is set as the SAML authentication request to be processed and forwarded.
    ACCESS::saml authn $new_authn_request
}
