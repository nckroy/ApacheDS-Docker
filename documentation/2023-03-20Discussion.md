# Use cases: Gaps and proposals

## External discovery occurs

### Assumptions

1. The browser uses the state engine of the current FedCM spec
   1. The IdPs participating show something like "My Campus Account" as the account ID when current spec endpoint at IdP called.
2. Browsers are willing to allow protocol calls to continue once user registers SP+IdP+(Account)

## Initial flow, user has active authentication state at IdP

The SP has used user input and contextual input to determine one of many IdPs are currently in use.

SP's js calls API, exchange occurs through browser mediation to IdP where user is already logged in, token is returned to SP's js proving that the authentication flow is working. Token merely indicates that authentication protocol approved at FedCM level. SP initiates protocol flow (with appropriate request for IdP), IdP presents any necessary screens to user for step up and/or consent, IdP able to generate a response with appropriate ID (anonymous, pairwise pseudonymous, correlatable), issue appropriate affiliation, authorization, and entitlement signals for the specific SP. 

### Gaps and questions

1. How does the browser recognize protocol calls to endpoints as approved?
   1. Proposal 4 says that the SP provides the browser with the trusted and preagreed URLs used in protocol exchange between IdP and SP
   2. Current FedCM authorizes trust at the origin, which is trust far beyond a specific IdP or SP. (EG: All of microsoft Azure's IdP, all of a cloud provider's -- say a learning management system or a WordPress -- customers.)

## How does the API account for the multiple IdPs at same domain/origin for calling account chooser, etc

Protocol 4, by providing metadata, allows distinguishing the different IdPs in same origin

## User has multiple choices presented in browser

Ten vs 5,000 -- how does user search? Page through? 

## User does not have active authentication state at previously registered IdP

## User does not have active authentication state at unregistered IdP

Proposal 4 does not require the user to be authenticated. (But not sure what happens)

## User fails at the IdP due to various temporary issues

Doesn't have MFA at hand

## Return flow, same IdP, user has active authentication state at IdP

SP has to use much of the same user input and contextual input to determine one of many IdPs are currently in use, because there's no way to know if the browser has any pairings in place.

## Proxied flow

## Tracking use case

SP is a vendor or entertainment site; IdP is a correlation engine site

IdP advertises itself in the API the browser calls as "Get more by agreeing here!" IdP identifies the active account, whether or not it has seen the user before as "Best deals". IdP creates a pairwise token for the SP and provides via browser channel.

SP checks whether new user. If new user constructs a front channel link for the user to complete their registration for discount or additional feature. Get URL constructed for user by SP for IdP. On click, SP makes backchannel call to IdP registering click on link to IdP and sending token. IdP uses referral origin and backchannel call to attempt correlation, sets cookie for IdP, presents origin specific UX with link back to SP. User completes or exits the "registration" for the benefit (any data provided at IdP can be sent backchannel to SP using correlation token, but IdP first party cookie is sent)

Future calls from SP through IdP from any page trigger correlation signa
