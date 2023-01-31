# Discovery proposal

The goal of this proposal is to support a community of IdPs and RPs that have established interoperation. The goal is to support both an RP with many IdPs, where the IdPs do not have relationships as well as a community of IdPs.

## Assumed requirements

1. The RP cannot know the user's choice in order to construct a request specific for an IdP.

## Proposal

### The Discovery system: new participant in flows

Introduce an additional party, which may have a different origin than the IdP and RPs: the Discovery system. The Discovery system hosts a searchable index of IdPs, with at least one and no more than five indexes for searching. The search retrieves objects that represent IdPs, IdP Discovery Objects. This object contains:

* an identifier for the IdP within the Discovery system
* elements to present to the user in the UI, including localizable names
* an identity protocol type
* a list of criteria the IdP meets as key value pairs

The Discovery system also hosts an endpoint from which the browser can retrieve necessary information once a user has selected an IdP.

These are open endpoints on the internet. The protocol type and the criteria key-values MAY be defined privately between RPs and the Discovery system. However, the IdPs included in the Discovery system will be public.

### Relying parties specify Discovery system

TODO look up multi IdP proposal and extend
TODO Discovery system reference should be similar to IdP system reference

Extension to multi IdP proposal, instead of IdPs, the RP may specify a single Discovery system.

If the RP specifies a Discovery system, the RP may specify one or more protocol type. If no protocol is specified, any IdP provided by the Discovery service will satisfy the RP. If protocol types are listed, only IdPs that have a matching label by the Discovery system

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

[GeoJSON] [RFC 7946: The GeoJSON Format](https://www.rfc-editor.org/rfc/rfc7946)
[JSON] [RFC 7519: The JavaScript Object Notation (JSON) Data Interchange Format](https://www.rfc-editor.org/rfc/rfc7159)
[WebIDL] [WebIDL](https://webidl.spec.whatwg.org)

## Testing

``` txt
Fencing working?

```

<figcaption>

Demo the figure caption for a codeblock

</figcaption>
Back to text