# Discovery proposal

The goal of this proposal is to support communities of IdPs and RPs that have established interoperation. Ideally the solution may also support an RP with many IdPs, where the IdPs do *not* have relationships with each other.

## Assumed requirements

**The RP cannot know the user's choice until a satisfactory authentication.** In order to have parity with FedCM as of 2023-01-31, the RP remains unaware of the user's IdP selection until the choice is made.

### Why assume this requirement?

The FedCM is built on top a separate W3C specification [CredMgmt] and attempts to align the federated authentication flow in the patterns established by that  API, which was explicitly designed for extensions. (See §8.2 [CredMgmt].) Continuing to align with [CredMgmt] aligns with that browser architecture principal.

Note that if the IdP is communicated to the RP before authentication occurs, the value of browser participation is that of *user experience*: the browser knows IdPs the user has selected in the past and can ease the "NASCAR" experience for the user by using that knowledge to help the user navigate through the discovery flow.

However, the browser implementers may argue that the relying party can host its own discovery flows, solve the NASCAR problem on its own, and then the RP may proceed through the single IdP request version of FedCM.

Isolating the selection until both the user and the IdP agree to interoperation with the RP does protect the user's affiliations from a RP that is testing for access.

TODO Is previous paragraph too paranoid?

## Proposal

### The Discovery system: new participant in flows

We propose an additional party, which may have a different origin than the IdP and RPs: the Discovery system. The Discovery system hosts a searchable index of IdPs, with at least one and no more than five indexes for searching. The search retrieves objects that represent IdPs. The objects contain:

* an identifier for the IdP within the Discovery system
* elements to present to the user in the UI, including localizable names
* an identity protocol type
* a list of criteria the IdP meets as key value pairs

The Discovery system also hosts an endpoint from which the browser can retrieve necessary IdP information once a user has selected an IdP.

Note that these are open endpoints on the internet. The protocol type and the criteria key-values MAY be defined privately between RPs and the Discovery system. However, the IdPs included in the Discovery system will be public.

### Relying parties specify Discovery system

This proposal extends the method by which an RP may allow the user to select from more than one IdP. [FedCM] specifies an extension to the navigator.credentials browser API. (See §2.3 of [CredMgmt])

[FedCM] extended the CredentialRequestOptions object, note §2.1.2 of [CredMgmt]. This would propose yet another Credential Type: Discovered, and define a DiscoveredCredential interface object.

The DiscoveredCredential object would identify the Discovery System according to the requirements for §4.1.1. Identifying Providers [CredMgmt]: the Discovery system MUST be identified by the ASCII serialization of the origin the provider uses for the search.

If the RP requests Discovered Credential, the RP may use the DiscoveredCredential interface object to specify one or more protocol type. If no protocol is specified, any IdP provided by the Discovery service will satisfy the RP. If protocol types are listed, only IdPs that have a matching label by the Discovery system

### The browser interaction

Given a discovery system's list of

The browser persists a tuple of [Discovery system, IdP, Account] to help speed user's selections.

## More details

### Search indices

For each of the indices, the Discovery service provides an index identifier, a list of localized labels, and a search data type. Data types include the two of the primitive JSON types, strings and numbers, [JSON] and the GeoJSON format [GeoJSON].  At least one index MUST be of type JSON string.

TODO standardize index type identifiers; look at [WebIDL]
TODO discussed with Seamless if they think that a map discovery, particularly for mobile users, may be useful

Browsers MUST support the JSON string type for index search.

### IdP Discovery Object

TODO protocol type labels are [JSON] strings, no more than N characters long, defined by the Discovery service. Browsers do not interpret the IdP protocol label, merely make string comparisons.
TODO string comparison by browser specification informed by §8.3 [JSON]

## Use cases

TODO maybe delete this section.

### Research and Education

TODO vet with Seamless and other

An R&E discovery system could include two protocols "SAML" and "OIDC". Initially, most RPs would only accept SAML. This discovery service might allow IdPs to signal capabilities, such as

* support for different attribution profiles,
* support for different authentication confirmation,
* compliance with certain operating standards and policies.
  
A particular RP may use this to allow the user to select any IdP that supports providing the name and email and also supports phishing resistant authentication.

### Learning management system

A learning management system integrates across school system against different school system OIDC and OAuth endpoints. Some users have access to data retrieved from their school systems: those requests need to specify the scopes needed for that systems APIs.

The learning management system creates its own discovery system, using the protocol indicator to identify the combination of scopes that are needed for a requests.

## References

[CredMgmt] [Credential Management Level 1](https://w3c.github.io/webappsec-credential-management/)
[FedCM] [FedCM](https://fedidcg.github.io/FedCM/)</br>
[GeoJSON] [RFC 7946: The GeoJSON Format](https://www.rfc-editor.org/rfc/rfc7946)</br>
[JSON] [RFC 7519: The JavaScript Object Notation (JSON) Data Interchange Format](https://www.rfc-editor.org/rfc/rfc7159)</br>
[MultiIdP] [FedCM Multiple IDP Support Explainer](https://github.com/fedidcg/FedCM/blob/main/proposals/multi-idp-api.md)</br>
[WebIDL] [WebIDL](https://webidl.spec.whatwg.org)
