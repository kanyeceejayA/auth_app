// Corresponds to AuthenticatorAttestationResponse
class RegistrationResult {
  RegistrationResult(this.credentialId, this.signedChallenge, this.publicKey);

  /// This is the identifier for the credential generated by the authenticator.
  ///
  /// It will is used by the WebAuthn server and the FIDO client to identify
  /// which credential is being verified.
  ///
  /// Encoded in Base64URL
  String credentialId;


  /// A signed copy of the challenge that was sent with the registration result.
  /// This is used to prevent replay attacks and can confirm
  /// that the result was sent for the initial request.
  String signedChallenge;

  /// The public key to be used to verify any future challenges sent from this user
  String publicKey;

}