# Discovery proposal

The goal of this proposal is to support communities of IdPs and RPs that have established interoperation. Ideally the solution may also support an RP with many IdPs, where the IdPs do *not* have relationships with each other.

## Assumed requirements

**The RP cannot know the user's choice until a satisfactory authentication.** In order to have parity with FedCM as of 2023-01-31, the RP remains unaware of the user's IdP selection until the choice is made.

### Why assume this requirement?

The FedCM is built on top a separate W3C specification [CredMgmt] and attempts to align the federated authentication flow in the patterns established by that  API, which was explicitly designed for extensions. (See §8.2 [CredMgmt].) Continuing to align with [CredMgmt] aligns with that browser architecture principle.

Note that if the IdP is communicated to the RP before authentication occurs, the value of browser participation is that of *user experience*: the browser knows IdPs the user has selected in the past and can ease the "NASCAR" experience for the user by using that knowledge to help the user navigate through the discovery flow. This is especially important in the context of very large mesh federations such as exist in the R&E community [edugain]

However, the browser implementers may argue that the relying party can host its own discovery flows, solve the NASCAR problem on its own, and then the RP may proceed through the single IdP request version of FedCM. However, solving the NASCAR problem in the browser is a goal that has long been hoped-for in massive multilateral federations, and FedCM offers this community an opportunity to define standards around privacy preservation and IdP discovery that will help multiple use cases at the same time.

Isolating the selection until both the user and the IdP agree to interoperation with the RP does protect the user's affiliations from an RP that is testing for access.

TODO Is previous paragraph too paranoid? (Judith) I don't think so. Would be really cool/bonus points if we can use this to prevent evil screen-scrapers from pretending to be legitimate IdPs, too... (See also: well, I won't say here, but scammers exist and they make a lot of money selling students' attributes) hmmmm... (Nicole)

## Proposal

### The Discovery system: new participant in flows

We propose an additional party, which may have a different origin than the IdP and RPs: the Discovery system. The Discovery system hosts a searchable index of IdPs, with at least one and no more than five indexes for searching (Nicole: Why the limit of five? Can we let the RP specify its own list of IdPs via reference or value as an option? Like a Shibboleth discofeed.json?). The search retrieves objects that represent IdPs. The objects contain:

* an identifier for the IdP within the Discovery system (example: SAML entityID)
* elements to present to the user in the UI, including localizable names, IdP logos, etc.
* an identity protocol type
* a list of criteria the IdP meets as key value pairs (Nicole: Will this grammar be sufficient for all RPs' discovery use cases, and if not, can we let the RP supply its own feed as mentioned above?)

The Discovery system also hosts an endpoint from which the browser can retrieve necessary IdP information once a user has selected an IdP. (Nicole: What type of information is this? Akin to SAML metadata, or something else?)

Note that these are open endpoints on the internet. The protocol type and the criteria key-values MAY be defined privately between RPs and the Discovery system. However, the IdPs included in the Discovery system will be publicly-published/known via other mechanisms not in-scope for this proposal. (See: [samlmd],[samlmdiop],[samlmdui],[samlmdea])

### Relying parties specify Discovery system

This proposal extends the method by which an RP may allow the user to select from more than one IdP. [FedCM] specifies an extension to the navigator.credentials browser API. (See §2.3 of [CredMgmt])

[FedCM] extended the CredentialRequestOptions object, note §2.1.2 of [CredMgmt]. This would propose yet another Credential Type: Discovered, and define a DiscoveredCredential interface object.

The DiscoveredCredential object would identify the Discovery System according to the requirements for §4.1.1. Identifying Providers [CredMgmt]: the Discovery system MUST be identified by the ASCII serialization of the origin the provider uses for the search.

If the RP requests Discovered Credential, the RP may use the DiscoveredCredential interface object to specify one or more protocol type(s). If no protocol is specified, any IdP provided by the Discovery service will satisfy the RP. If protocol types are listed, only IdPs that have a matching protocol support enumeration will be displayed.

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

[CredMgmt] [Credential Management Level 1](https://w3c.github.io/webappsec-credential-management/)</br>
[edugain] [edugain](https://technical.edugain.org)</br>
[FedCM] [FedCM](https://fedidcg.github.io/FedCM/)</br>
[GeoJSON] [RFC 7946: The GeoJSON Format](https://www.rfc-editor.org/rfc/rfc7946)</br>
[JSON] [RFC 7519: The JavaScript Object Notation (JSON) Data Interchange Format](https://www.rfc-editor.org/rfc/rfc7159)</br>
[MultiIdP] [FedCM Multiple IDP Support Explainer](https://github.com/fedidcg/FedCM/blob/main/proposals/multi-idp-api.md)</br>
[WebIDL] [WebIDL](https://webidl.spec.whatwg.org)</br>
[samlmd] [samlmd](https://docs.oasis-open.org/security/saml/v2.0/saml-metadata-2.0-os.pdf)</br>
[samlmdiop] [samlmdiop](http://docs.oasis-open.org/security/saml/Post2.0/sstc-metadata-iop.pdf)</br>
[samlmdui] [samlmdui](http://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-metadata-ui/v1.0/sstc-saml-metadata-ui-v1.0.pdf)</br>
[samlmdea] [samlmdea](http://docs.oasis-open.org/security/saml/Post2.0/sstc-metadata-attr-cs-01.pdf)
