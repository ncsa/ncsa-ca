define(m4comment)
m4comment(Change quotes to square brackets)
changequote([,])
m4comment(latex configuration, bracket to protect from m4)
[
\documentclass[10pt]{article}
\usepackage[margin=1in]{geometry}

\usepackage{times}
\usepackage{graphicx}
\usepackage{url}
\usepackage[pdftex,colorlinks=false]{hyperref}
\usepackage{epsfig}
\usepackage{tocloft}
\usepackage{color}

%\bibliographystyle{abbrv}
\bibliographystyle{plain}

\setlength{\parindent}{0pt}
\setlength{\parskip}{\baselineskip}

\begin{document}
]

m4comment(Define macros for specifying CA instance-specific details)
define([M4_CA_ONLY], [ifdef([M4_NCSA_CA], [$*])])
define([M4_SLCS_ONLY], [ifdef([M4_NCSA_SLCS], [$*])])
define([M4_2FCA_ONLY], [ifdef([M4_NCSA_2FCA], [$*])])
define([M4_MYPROXY_ONLY], [ifdef([M4_NCSA_SLCS], [$*])] [ifdef([M4_NCSA_2FCA], [$*])])
define([M4_KERBEROS_ONLY], [ifdef([M4_NCSA_SLCS], [$*])] [ifdef([M4_NCSA_CA], [$*])])

M4_CA_ONLY([
define(M4_DOC_TITLE, [Certificate Policy and Practice Statement for the NCSA MICS CA])
define(M4_CA_NAME, [NCSA-CA])
define(M4_CA_DN, [C=US, O=National Center for Supercomputing Applications, OU=Certificate Authorities, CN=CACL])
define(M4_DOC_OID, [1.3.6.1.4.1.4670.100.1.9])
])
M4_SLCS_ONLY([
define(M4_DOC_TITLE, [Certificate Policy and Practice Statement for the NCSA SLCS])
define(M4_CA_NAME, [NCSA-SLCS])
define(M4_CA_DN, [C=US, O=National Center for Supercomputing Applications, OU=Certificate Authorities, CN=MyProxy CA 2013])
define(M4_DOC_OID, [1.3.6.1.4.1.4670.100.2.9])
])
M4_2FCA_ONLY([
define(M4_DOC_TITLE, [Certificate Policy and Practice Statement for the NCSA Two Factor CA])
define(M4_CA_NAME, [NCSA-2FCA])
define(M4_CA_DN, [C=US, O=National Center for Supercomputing Applications, OU=Certificate Authorities, CN=Two Factor CA 2013])
define(M4_DOC_OID, [1.3.6.1.4.1.4670.100.4.9 ])
])
define(M4_TIMESTAMP, [esyscmd(date)])
define(M4_DOC_VERSION, [1.9])
define(M4_DOC_DATE, [M4_TIMESTAMP])
define(M4_CA_URL, [\url{http://security.ncsa.illinois.edu/CA/}])
define(M4_VERSION, [esyscmd(m4 --version)])

define(M4_ITALICS, [\textit{$*}])
define(M4_SLANTED, [\textsl{$*}])
define(M4_BOLD, [\textbf{$*}])

m4comment(For quoted terms)
define(M4_QUOTE, [\textbf{$*}])

\title{M4_DOC_TITLE}
\author{National Center for Supercomputing Applications (NCSA)}

\date{Version M4_DOC_VERSION (M4_DOC_DATE)}

\maketitle

\tableofcontents
\newpage

\section{INTRODUCTION}

\subsection{Overview}

This Certificate Policy and Practice Statement (herein referred to as
the ``Policy'') specifies minimum requirements for the issuance and
management of digital certificates that shall be used in
authenticating users accessing resources of the
National Center for Supercomputing Applications
at the University of Illinois (herein referred to as ``NCSA'') 
and the resources of other entities (relying
parties) which accept those certificates. The Policy is issued and
administered under the authority of the NCSA Policy Management
Authority (herein referred to as the ``PMA''; see Section 1.4.2 for
contact details).
This document is structured according to
Internet Engineering Task Force RFC 3647 (Internet X.509 Public Key
Infrastructure Certificate Policy and Certification Practices
Framework).

NCSA runs three CAs. Each CA has its own private key and certificate. 
It is expected
that relying parties will generally trust all NCSA CAs, 
though a relying party may
choose to trust any NCSA CA separately. These CAs taken together
along with the associated software and repositories used to distribute
policies, CRLs and the like, are referred to as the ``NCSA PKI''.
One CA issues only short-lived certificates
(with 11 days or shorter lifetime)
to users
based on Kerberos authentication
and is
henceforth referred to as the ``NCSA Short-lived Certificate Service''
or ``NCSA-SLCS''.
One CA issues only short-lived certificates
(with 11 days or shorter lifetime)
to users
based on (strong) two-factor authentication
and is henceforth referred to as the ``NCSA Two Factor CA''
or ``NCSA-2FCA''.
One CA is a traditional CA that issues long-lived certificates to
hosts, services, robots, and users requiring long-lived certificates. This CA
is henceforth referred to as the ``NCSA-CA''.
It is expected that users
will use the NCSA-SLCS and NCSA-2FCA CAs
for user certificates unless they have some
need for a long-lived certificate from the NCSA-CA.

This document covers the policy that applies to the M4_CA_NAME.
Figure \ref{arch-fig} illustrates the overall architecture of the 
M4_CA_NAME.
The CA is integrated with the NCSA user database and NCSA
M4_KERBEROS_ONLY([Kerberos]) M4_2FCA_ONLY([one-time password (RSA SecurID) ])
authentication service for identity management.
The NCSA accounting process enrolls users in the user database,
creates a
M4_KERBEROS_ONLY([Kerberos]) M4_2FCA_ONLY([one-time password ]) account 
M4_CA_ONLY([with an initial default password]) for them,
and assigns them a distinguished name.
M4_CA_ONLY([
To obtain credentials,
M4_CA_NAME subscribers run software on the host where their
credentials are to be stored.
The software generates the subscriber's private key locally,
authenticates the user to the M4_CA_NAME via 
Kerberos and their ``default password'' (two authentication factors),
issues a signed certificate request to the CA,
and, if the request is approved,
receives a signed certificate from the CA.
])
M4_SLCS_ONLY([
To obtain credentials,
M4_CA_NAME subscribers run software on the host where their
credentials are to be stored.
The software generates the subscriber's private key locally,
authenticates the user to the M4_CA_NAME via 
Kerberos,
issues a signed certificate request to the CA,
and, if the request is approved,
receives a signed certificate from the CA.
])
M4_2FCA_ONLY([
To obtain credentials,
M4_CA_NAME subscribers run software on the host where their
credentials are to be stored.
The software generates the subscriber's private key locally,
authenticates the user to the M4_CA_NAME via 
one-time password,
issues a signed certificate request to the CA,
and, if the request is approved,
receives a signed certificate from the CA.
])
M4_KERBEROS_ONLY([
The M4_CA_NAME
looks up the distinguished name in the user database 
that corresponds to the user's authenticated Kerberos identity
and issues a certificate with the appropriate distinguished name.
M4_CA_ONLY([For host and service certificate requests, the M4_CA_NAME
also queries the NCSA Host database, maintained by NCSA networking staff,
to verify the authenticated user is a registered administrator
for the requested host.])
Further policy and implementation details are provided
throughout the document.
])
M4_2FCA_ONLY([
The M4_CA_NAME
looks up the distinguished name in the user database 
that corresponds to the user's authenticated NCSA identity
and issues a certificate with the appropriate distinguished name.
])


M4_CA_ONLY([

\begin{figure}[[ht]]
\centering
\includegraphics[[trim = 0 350 0 0]]{ncsa-ca-fig.pdf}
\caption{NCSA CA Architecture}
\label{arch-fig}
\end{figure}

])

M4_SLCS_ONLY([

\begin{figure}[[ht]]
\centering
\includegraphics[[trim = 0 380 0 0]]{ncsa-slcs-fig.pdf}
\caption{NCSA SLCS Architecture}
\label{arch-fig}
\end{figure}

])

M4_2FCA_ONLY([

\begin{figure}[[ht]]
\centering
\includegraphics{ncsa-2fca-fig.pdf}
\caption{NCSA 2FCA CA Architecture}
\label{arch-fig}
\end{figure}

])

\subsection{Document name and identification}

Document title: M4_DOC_TITLE\\
This Policy is published at:
M4_CA_URL\\
Document version: M4_DOC_VERSION\\
Document date: M4_DOC_DATE\\
OID: M4_DOC_OID\\

\subsection{PKI participants}

\subsubsection{Certification authorities}

This policy is valid for the M4_CA_NAME. The M4_CA_NAME will only sign end
entity certificates. There are no subordinate CAs.

\subsubsection{\label{sec:reg}Registration authorities}

NCSA allocations group staff serve as registration authorities for the
M4_CA_NAME.
They enroll users in the NCSA user database
according to the enrollment process described in 
Section \ref{sec:enrollment},
create accounts for new users,
M4_CA_ONLY([assign a default password for the account,]) and
assign distinguished names to new users
according to Section \ref{sec:names}.

M4_KERBEROS_ONLY([
The M4_CA_NAME uses the Kerberos service to authenticate 
requests
and queries the database to obtain the proper distinguished name for
authenticated requesters. M4_CA_ONLY([The M4_CA_NAME also uses the database to authenticate users' default passwords as a ``second authentication factor''.])
The NCSA user database and Kerberos service are used to authenticate 
NCSA's users and staff for access to NCSA high-performance computing
resources, NCSA's email services and other production services.
])

M4_2FCA_ONLY([
The M4_CA_NAME
uses the NCSA one-time password (RSA SecurID) service to authenticate requests and
queries the database to obtain the proper distinguished name for 
authenticated requesters. The NCSA user database and RSA SecureID 
service are used to authenticate NCSA users and staff to NCSA high-performance 
computing resources.
])

M4_CA_ONLY([Users are instructed to change their default password
immediately upon receiving their account information and to keep their
default password in a secure place for later reference.
In the event that their current password is forgotten,
it will be reset to this default.
The default password is used as a
``second authentication factor'' in certificate requests,
along with the user's current Kerberos password.])

M4_CA_ONLY([
NCSA networking group staff serve a registration authority
role for host and service certificate requests by
maintaining
a database of all NCSA hosts and their authorized system
administrator(s). 
This allows requests for
service certificates from a host's authorized administrator
(authenticated via Kerberos) to be automatically
processed. Requests for hosts that do not appear in this database
(e.g., services run by NCSA collaborators) will be manually vetted by
NCSA operations staff.
])

M4_CA_ONLY([
Robot certificates are manually vetted and issued by CA operators
according to the requirements of the ``Guideline on IGTF Approved Robots''.
])

\subsubsection{Subscribers}

The M4_CA_NAME will serve the needs of the NCSA community by providing
NCSA users and employees with x509v3 digital certificates.  These
certificates may be used for the purpose of authentication,
encryption, and digital signing by those individuals to whom the
certificates have been issued.

M4_CA_ONLY([

The CA will also issue server and service certificates to computers
operating within the NCSA administrative domain and to computer
systems from other domains that are providing services in support of
NCSA projects.

])

\subsubsection{Relying parties}

NCSA places no restrictions on who may accept certificates it issues.

\subsubsection{Other participants}

No stipulation.

\subsection{Certificate usage}

\subsubsection{Appropriate certificate uses}

One of the purposes of this policy is to promote a wide use of
public-key certificates in many different applications.  These
applications may include, but are not limited to, login
authentication, job submission authentication, M4_CA_ONLY([encrypted e-mail,]) and
SSL/TLS encryption for applications capable of making use of these
technologies.

\subsubsection{Prohibited certificate uses}

Other uses of M4_CA_NAME certificates are not prohibited, but neither
are they supported.

\subsection{Policy administration}

\subsubsection{Organization administering the document}

This policy is administered by
the National Center for Supercomputing Applications
at the University of Illinois,
1205 W. Clark, Urbana IL 61801 USA.

This policy is accredited by
The Americas Grid Policy Management Authority (TAGPMA),
a member of the International Grid Trust Federation (IGTF).

\subsubsection{Contact person}

The point of contact for this Policy and other matters related to the
M4_CA_NAME is:

Jim Basney\\
Phone number: +1 217-244-1954\\
Postal address: 1205 W. Clark, Urbana IL 61801 USA\\
E-mail address: jbasney@illinois.edu\\
After hours contact information:\\
NCSA Security Operations and Incident Response: security@ncsa.illinois.edu\\
NCSA 24x7 Operations: +1 217-244-0710\\

\subsubsection{Person determining CPS suitability for the policy}

The Head of Security Operations for NCSA leads the PMA for the CA and
is ultimately responsible for determining the suitability of the CPS.

As an accredited policy of the TAGPMA,
all policy changes are subject to TAGPMA review and approval.

\subsubsection{CPS approval procedures}

As determined by TAGPMA and the Head of Security Operations for NCSA.

\subsection{Definitions and acronyms}

Certification Authority (CA) - An authority trusted by 
one or more users to create and assign public key 
certificates. Optionally the CA may create the user's 
keys. It is important to note that the CA is responsible 
for the public key certificates during their whole 
lifetime, not just for issuing them. 
 
CA-certificate - A certificate for one CA's public key
issued by another CA or self signed.  
 
Certificate policy (CP) - A named set of rules that 
indicates the applicability of a certificate to a 
particular community and/or class of application with 
common security requirements. For example, a particular 
certificate policy might indicate applicability of a 
type of certificate to the authentication of electronic 
data interchange transactions for the trading of goods 
within a given price range. 
 
Certification path - An ordered sequence of certificates 
which, together with the public key of the initial 
object in the path, can be processed to obtain that of 
the final object in the path. 

Certification Practice Statement (CPS) - A statement of the practices, 
which a certification authority employs in issuing certificates. 
 
Certificate revocation list (CRL) - A CRL is a time 
stamped list identifying revoked certificates, which is 
signed by a CA and made freely available in a public 
repository. 

Issuing certification authority (issuing CA) - In the context of a 
particular certificate, the issuing CA is the CA that issued the 
certificate (see also Subject certification authority). 
 
Public Key Certificate (PKC) - A data structure 
containing the public key of an end entity and some 
other information, which is digitally signed with the 
private key of the CA which issued it. 
 
Public Key Infrastructure (PKI) - The set of hardware, 
software, people, policies and procedures needed to 
create, manage, store, distribute, and revoke PKCs based 
on public-key cryptography. 
  
Registration authority (RA) - An entity that is 
responsible for identification and authentication of 
certificate subjects, but that does not sign or issue 
certificates (i.e., an RA is delegated certain tasks on 
behalf of a CA). [Note: The term Local Registration 
Authority (LRA) is used elsewhere for the same concept.] 
 
Relying party - A recipient of a certificate who acts in 
reliance on that certificate and/or digital signatures 
verified using that certificate. In this document, the 
terms ``certificate user'' and ``relying party'' are used 
interchangeably. 
 
Subject certification authority (subject CA) - In the 
context of a particular CA-certificate, the subject CA 
is the CA whose public key is certified in the certificate. 
 
IPR - Intellectual Property Rights 
 
\section{PUBLICATION AND REPOSITORY RESPONSIBILITIES}

\subsection{Repositories}

The NCSA PKI will maintain a repository at M4_CA_URL.

\subsection{Publication of certification information}

This repository will contain:

\begin{itemize}

\item Self-signed, certificates for all CAs in the NCSA PKI

\item CRLs for the M4_CA_NAME

\item General information about the NCSA PKI,
      including postal address and contact email address

\item The most recent copies of all Certificate Policies for the NCSA PKI CAs, including this policy

\end{itemize}

\subsection{Time or frequency of publication}

The CRL will be published immediately after a certificate has been
revoked as well as on a daily basis.
The CRL This Update field will indicate the issue date of the CRL,
and the Next Update field will be set to two weeks in the future,
to indicate a two week validity period for the CRL.

The Policy shall be published immediately following any update.

\subsection{Access controls on repositories}

Access to the repository for modification is restricted to 
NCSA operations staff, NCSA security operations staff,
and NCSA system administration staff.
See Section \ref{sec:procedural-controls} for
procedural controls regarding M4_CA_NAME systems.

Read access to the repository (via HTTP) is unrestricted.
Repositories are publicly available for read access.
Best effort will be provided to maintain their availability 24x7.

As a member of the TAGPMA, NCSA grants the IGTF and its
PMAs the right of unlimited redistribution of this information.

\section{IDENTIFICATION AND AUTHENTICATION}
\subsection{\label{sec:names}Naming}
\subsubsection{Types of names}

Subject distinguished names are X.500 names, with components varying
depending on the type of certificate.

\subsubsection{Need for names to be meaningful}

A unique (see Section \ref{sec:unique})
``common name'' is assigned to each user consisting of their
legal name with a serial number appended in the case of name
conflicts.

M4_CA_ONLY([

The CN component of the subject name in service certificates includes
the fully qualified DNS name of the service, which is usually that of
the host supporting the service. The structure of a service's CN is
designed to support SSL, TLS and Globus services.

])

\subsubsection{Anonymity or pseudonymity of subscribers}

Anonymity and pseudonymity are not supported.

\subsubsection{Rules for interpreting various name forms}

All subject distinguished names in certificates issued by the NCSA PKI
begin with C=US, O=National Center for Supercomputing
Applications. The next component will be one of:

\begin{itemize}

\item OU=Certificate Authorities :
for a CA's certificate. A CN component will follow the OU, naming the
CA. All CA certificates will be self-signed.

The distinguished name for the M4_CA_NAME is M4_CA_DN.

M4_CA_ONLY([
Note: CACL is the name of the software implementing this CA.
])

M4_SLCS_ONLY([
Note: MyProxy is the name of the software implementing this CA.
])

M4_CA_ONLY([

\item OU=Services :
for a service (including a host) certificate issued by the NCSA-CA. A
CN component will follow the OU, naming the service and the fully
qualified domain name (FQDN) at which the service can be contacted,
separated by a slash character. When the service is https, the service
name and separator will be absent.  For example:

C=US, O=National Center for Supercomputing Applications, OU=Services, CN=ca.ncsa.uiuc.edu

\item OU=People :
for a user's certificate issued by the NCSA-CA.  A CN
component will follow the OU, containing the user's full name and, if needed,
a numeric value to disambiguate the name from other users with the
same name.  For example:

C=US, O=National Center for Supercomputing Applications, OU=People, CN=Jim Basney

\item OU=Robots :
for a robot certificate issued by the NCSA-CA,
according to the ``Guideline on IGTF Approved Robots''.
A CN component will follow the OU, containing either 
(1) an electronic mail address of a persistent group of people responsible for the robot operations; 
or (2) the name of a single natural person responsible for the automated client.
In case (2), a numeric value may be appended to disambiguate the name
from other users with the same name.
Then another CN component will follow that CN, containing the string "Robot:"
appended with a humanly-recognisable and meaningful description of the Robot.
For example:

C=US, O=National Center for Supercomputing Applications, OU=Robots, CN=Jim Basney, CN=Robot:Dark Energy Survey Data Mover

])

M4_MYPROXY_ONLY([

\item CN=M4_ITALICS(User Name) :
for a user's certificate issued by the M4_CA_NAME.  The CN
component will contain the user's full name and, if needed,
a numeric value to disambiguate the name from other users with the
same name.  For example:

C=US, O=National Center for Supercomputing Applications, CN=Jim Basney

])

\end{itemize}

\subsubsection{\label{sec:unique}Uniqueness of names}

Each subject name issued by the NCSA PKI will be issued to one and
only one individual as identified by a record in the user database.
The user database management system implements checks to ensure the
uniqueness of assigned distinguished names.
User records are never purged from the database or reused,
to ensure that distinguished names will never be reassigned
to another individual.
The NCSA PKI may issue certificates
with identical names, but only to the same individual.
All names will be prefixed with the relative DN form of C=US,
O=National Center for Supercomputing Applications to provide a
globally unique namespace.
A unique ``common name'' is assigned to each user consisting of their
legal name with a serial number appended in the case of name
conflicts.
This common name along with the prefix create globally-unique
distinguished names used in certificates issued by the NCSA PKI to
users.
M4_CA_ONLY([For service certificates, the combination of service name and fully
qualified domain name of the host on which the service resides serves
to disambiguate the name.
])


\subsubsection{Recognition, authentication, and role of trademarks}

No stipulation.

\subsection{Initial identity validation}

\subsubsection{Method to prove possession of private key}

Certificate requests must be digitally signed by the private key
associated with the public key in the request
using a process that is run by the user on the client side of the request.

\subsubsection{Authentication of organization identity}

NCSA users are identified by their presence in the NCSA user database.
Users obtain entries in the database according to the procedure
described in Section \ref{sec:enrollment}.

\subsubsection{\label{sec:auth}Authentication of individual identity}

User identity will be authenticated via 
M4_CA_ONLY([Kerberos,]) M4_SLCS_ONLY([Kerberos,]) M4_2FCA_ONLY([one-time password, ]) 
with the authenticated
M4_KERBEROS_ONLY([Kerberos principal name]) M4_2FCA_ONLY([NCSA login name ])
mapped to a unique
``common name'' via the NCSA user database.
M4_CA_ONLY([The M4_CA_NAME also uses the database to authenticate users'
``default passwords'' as a ``second authentication factor'' as described
in Section \ref{sec:reg}.])

If traceability to a user is lost, i.e., NCSA is unable to contact a
user based on the data associated with that user in the NCSA user database,
then the user's NCSA login will be disabled 
to prevent further attempts to obtain
certificates issued by the M4_CA_NAME. 
This also prevents authentication by the
user to other NCSA services.

\subsubsection{Non-verified subscriber information}

No stipulation.

\subsubsection{Validation of authority}

Users making requests for user certificates must be authenticated as
the user identified in the certificate.

M4_CA_ONLY([

Requests for service certificates must come from a valid NCSA User and
will be checked against NCSA's database of registered system
administrators to ensure the user is a legitimate system administrator
for the service identified in the certificate subject name.

])

\subsubsection{Criteria for interoperation}

The NCSA PKI is intended to interoperate with other CAs within
TeraGrid and the International Grid Trust Federation.

\subsection{Identification and authentication for re-key requests}

\subsubsection{Identification and authentication for routine re-key}

Every certificate request is treated as an initial registration.

\subsubsection{Identification and authentication for re-key after revocation}

If the compromise was limited to just the private key, the request for
re-key will be treated as an initial registration.
M4_KERBEROS_ONLY([If the compromise involved a user's password,
that password will be reset 
according to Section \ref{sec:enrollment}.])
M4_2FCA_ONLY([If the compromise involved a user's authentication token,
that token will be revoked/re-issued
according to Section \ref{sec:enrollment}.])

\subsection{\label{sec:auth-revoke}Identification and authentication for revocation request}

CA Certificates will only be revoked at the instigation of NCSA
Operational Security personnel.

Users may request revocation by contacting NCSA Security
Operations.

M4_CA_ONLY([
Requests for revocation of service certificates from NCSA computer
security personnel and from administrators of the systems hosting the
services in question will be honored.
])

Others may request revocation if they can sufficiently prove compromise
or exposure of the associated private key.

NCSA Security Operations will verify the authenticity of revocation
requests by checking digital signatures on the request or by telephone
to the requester's registered phone number.

\section{CERTIFICATE LIFE-CYCLE OPERATIONAL REQUIREMENTS}

\subsection{Certificate Application}

\subsubsection{Who can submit a certificate application}

Any user who appears in NCSA's user database
M4_2FCA_ONLY([and has an active NCSA-issued RSA SecurID ]) may request a certificate.

\subsubsection{\label{sec:enrollment}Enrollment process and responsibilities}

NCSA allocations group staff serve as registration authorities for the
M4_CA_NAME.
They enroll users in the NCSA user database
according to the following enrollment process.
Additional details 
are available at \url{http://www.ncsa.illinois.edu/UserInfo/Allocations/}.

To receive an entry in NCSA's user database, a user must satisfy
one of the following conditions:

\begin{itemize}

\item Be an NCSA employee

\item Have a guest account requested by NCSA management for key
NCSA collaborators

\item Be a Principal Investigator (PI) with a allocation on NCSA
computational resources approved through an NSF-approved peer review
process

\item Have a project account requested on their behalf by an existing PI
using that PI's allocation

\end{itemize}

Identity vetting of NCSA employees is performed in person as part of
the University of Illinois hiring process, in collaboration with the
NCSA Human Resources department.
Identity vetting of guest accounts requires direct personal contact of
an NCSA staff member, who takes responsibility for that person's
account.  Guest account requests are reviewed and approved by NCSA
management and allocations group staff.

Allocations are typically awarded for one year,
though multi-year allocations may be granted for well-known PIs.
PIs can submit renewal or supplemental proposals to the committee
to extend their allocation.

PIs are instructed not to share their accounts with others.
Instead, they use a web form
to request accounts for their project members.
PIs can also use this form to remove project members.
Access to this form requires authentication via NCSA
M4_KERBEROS_ONLY([Kerberos]) M4_2FCA_ONLY([one-time password]).
PIs validate name, telephone, and address information for the users on
their project.
For users on multiple projects, each project PI must complete the
required information separately for each user to request the user
to have access to the project's resources.
All users are required to sign an acceptable use policy,
which educates users about secure and appropriate computing practices.

When a user no longer has any active projects, the user's NCSA
M4_KERBEROS_ONLY([Kerberos account]) M4_2FCA_ONLY([RSA SecurID ])
is disabled.
The user's NCSA
M4_KERBEROS_ONLY([Kerberos account]) M4_2FCA_ONLY([RSA SecurID ])
may also be disabled for inactivity.
User database entries are kept indefinitely for historical purposes.

M4_CA_ONLY([
All initial user passwords are distributed by postal/campus mail
(or in the case of new NCSA employees, in person by the employee's manager).
The letter distributed with the initial password
instructs the user to change their password and store
the letter in a secure place.
If the user forgets their password, they can call the helpdesk
and request that it be reset to the initial value.
If the user has lost the letter with the initial password,
they can call the helpdesk and request that a new letter be
sent to their address on record.
])

M4_MYPROXY_ONLY([
M4_KERBEROS_ONLY([
The user's initial password is established in one of two ways,
depending on the type of account requested 
and the method used to request the account.
For accounts requested via the TeraGrid User Portal,
users may choose their initial password at the time of initial
registration.
Once their registration is approved (via the allocations process),
their chosen password is activated for obtaining certificates.
For accounts requested via other methods
(for example, for new NCSA employees or NCSA guests), 
the user's initial password is distributed by postal/campus mail
(or in the case of new NCSA employees, in person by the employee's manager).
The letter distributed with the initial password
instructs the user to change their password and store
the letter in a secure place.
If the user forgets their password, they can call the helpdesk
and request that it be reset to the initial value.
If the user has lost the letter with the initial password,
they can call the helpdesk and request that a new letter be
sent to their address on record.
Users may also reset their password via the TeraGrid User Portal, 
which authenticates the request via the user's registered
email address.
])
M4_2FCA_ONLY([
When NCSA RSA SecurID tokens are requested, the user establishes 3 
personal questions with NCSA and their corresponding answers. 
Then the token is  
either mailed to a verified address or issued in person (government issued
ID required). After this, the user must activate the new token through a
web form which will ask for the answers to these 3 questions that were
established earlier.

A user who needs to reset a token (or activate an additional 
soft token) will also utilize the answers
to these 3 questions. If they call the NCSA Help Desk to get a token
reset, the help desk person will verify their identity by asking for 
the answers to those questions before proceeding. The web form to 
activate a new soft token associated with the same user account will 
also ask these same questions. 
])
])

Each user is assigned a unique username used as 
their M4_KERBEROS_ONLY([Kerberos principal and]) Unix login name
as described in \ref{sec:unique}.

\subsection{Certificate application processing}

\subsubsection{Performing identification and authentication functions}

The M4_CA_NAME authenticates all certificate requests as described in
Section \ref{sec:auth}.
M4_MYPROXY_ONLY([Communications between the subscriber, the CA, and
the user database are encrypted and integrity protected using the TLS
protocol to protect the chain of trust during application processing.
The chain of trust is protected within the CA service by the secured
process of translation from an authenticated certificate signing
request to delivery of a signed certificate.])

\subsubsection{Approval or rejection of certificate applications}

M4_CA_ONLY([
Certificate applications will be approved if the applicant can be
authenticated and, in the case of service
certificates, is validated as an authorized system administrator for
the host in question, as described in Section \ref{sec:auth}.
])

M4_SLCS_ONLY([
Certificate applications will be approved if the applicant can be
authenticated via Kerberos.
])

M4_2FCA_ONLY([
Certificate applications will be approved if the applicant can be
authenticated via NCSA-issued RSA SecurID.
])

\subsubsection{Time to process certificate applications}

Certificate applications are processed automatically.
Approved applications result in automatic certificate issuance.
Non-approved applications are automatically rejected and logged.

\subsection{Certificate issuance}

\subsubsection{CA actions during certificate issuance}

Certificate applications are processed automatically.
Approved applications result in automatic certificate issuance.
Non-approved applications are automatically rejected and logged.

\subsubsection{Notification to subscriber by the CA of issuance of certificate}

User certificates are returned directly to the user through the
application program they use to apply for a certificate.

\subsection{Certificate acceptance}

\subsubsection{Conduct constituting certificate acceptance}

Certificate acceptance is assumed.

\subsubsection{Publication of the certificate by the CA}

End entity certificates are not published.

\subsubsection{Notification of certificate issuance by the CA to other entities}

No notifications to other entities will be performed.

\subsection{Key pair and certificate usage}

\subsubsection{Subscriber private key and certificate usage}

Subscribers must:

\begin{itemize}

\item  Exercise all reasonable care in protecting the
private keys corresponding to their certificates, including but not
limited to never storing them on a networked file system or otherwise
transmitting them over a network and never sharing them between people.

M4_CA_ONLY([
\item  Ensure that the private keys corresponding to their issued service
certificates are stored in a manner that minimizes the risk of
exposure. 

\item Ensure that the private keys corresponding to robot certificates are managed in accordance with the ``Guideline on IGTF Approved Robots''.
])

\item  Observe restrictions on private key and certificate use. 

\item  Promptly notify the CA operators of any incident involving a
possibility of exposure of a private key. 

\end{itemize}

Subscribers are notified of these responsibilities in both
CA documentation and an Acceptable Usage Policy (AUP).
Subscribers are required to sign the AUP and return it to
NCSA Allocations,
thereby acknowledging reading of the AUP
and agreeing to abide by its requirements.

\subsubsection{Relying party public key and certificate usage}

Relying parties should:

\begin{itemize}

\item  Be cognizant of the provisions of this document. 

\item  Verify any self-signed CA certificates to their own satisfaction using
out-of-band means. 

\item  Accept responsibility for checking any relevant CRLs before
accepting the validity of a certificate. 

\item  Observe restrictions on private key and certificate use. 

\item  Not presume any authorization of an end entity based on possession
of a certificate from the NCSA PKI or its corresponding private key. 

\end{itemize}

\subsection{Certificate renewal}

Certificates in the NCSA PKI are not renewed. 
Instead the original subscriber may request a new certificate, using
the normal certificate issuance process.

\subsubsection{Circumstance for certificate renewal}

Not applicable.

\subsubsection{Who may request renewal}

Not applicable.

\subsubsection{Processing certificate renewal requests}

Not applicable.

\subsubsection{Notification of new certificate issuance to subscriber}

Not applicable.

\subsubsection{Conduct constituting acceptance of a renewal certificate}

Not applicable.

\subsubsection{Publication of the renewal certificate by the CA}

Not applicable.

\subsubsection{Notification of certificate issuance by the CA to other entities}

Not applicable.

\subsection{Certificate re-key}

Certificates in the NCSA PKI are not re-keyed.
Instead the original subscriber may request a new certificate, using
the normal certificate issuance process.

\subsubsection{Circumstance for certificate re-key}

Not applicable.

\subsubsection{Who may request certification of a new public key}

Not applicable.

\subsubsection{Processing certificate re-keying requests}

Not applicable.

\subsubsection{Notification of new certificate issuance to subscriber}

Not applicable.

\subsubsection{Conduct constituting acceptance of a re-keyed certificate}

Not applicable.

\subsubsection{Publication of the re-keyed certificate by the CA}

Not applicable.

\subsubsection{Notification of certificate issuance by the CA to other entities}

Not applicable.

\subsection{Certificate modification}

Certificates in the NCSA PKI are not modified.
Instead new certificates will be issued using the normal certificate
issuance process.

\subsubsection{Circumstance for certificate modification}

Not applicable.

\subsubsection{Who may request certificate modification}

Not applicable.

\subsubsection{Processing certificate modification requests}

Not applicable.

\subsubsection{Notification of new certificate issuance to subscriber}

Not applicable.

\subsubsection{Conduct constituting acceptance of modified certificate}

Not applicable.

\subsubsection{Publication of the modified certificate by the CA}

Not applicable.

\subsubsection{Notification of certificate issuance by the CA to other entities}

Not applicable.

\subsection{Certificate revocation and suspension}

\subsubsection{Circumstances for revocation}

Certificates issued by the M4_CA_NAME will be revoked in any of the
following circumstances:

\begin{itemize}

\item  The private key is suspected or reported to be lost or exposed. 

\item  The information in the certificate is believed to be, or has become
inaccurate.

\item  The certificate is reported to no longer be needed. 

\end{itemize}

\subsubsection{Who can request revocation}

NCSA Security Operations personnel may request revocation of any
certificate issued by the M4_CA_NAME.

The original subscriber for a certificate may request its revocation.

Entities other than the subscriber who suspect a certificate issued by
the NCSA PKI may be compromised should contact NCSA Security
Operations.

\subsubsection{Procedure for revocation request}

Requests for revocation should be made by email to
security@ncsa.illinois.edu or by phone to NCSA Operations 217-244-0710.
Requests will be authenticated according to
Section \ref{sec:auth-revoke}.

\subsubsection{Revocation request grace period}

No constraints.

\subsubsection{Time within which CA must process the revocation request}

Revocation requests will be processed within one working day of
the request being received.

\subsubsection{Revocation checking requirement for relying parties}

Relying parties are advised to obtain and consult a valid CRL from
M4_CA_URL.

\subsubsection{CRL issuance frequency (if applicable)}

CRLs are issued daily and whenever a certificate is revoked.

\subsubsection{Maximum latency for CRLs (if applicable)}

One day.

\subsubsection{On-line revocation/status checking availability}

Aside from the published CRL, no on-line certificate status checking
is available.

\subsubsection{On-line revocation checking requirements}

None.

\subsubsection{Other forms of revocation advertisements available}

None.

\subsubsection{Special requirements re key compromise}

None.

\subsubsection{Circumstances for suspension}

Certificate suspension is not supported.

\subsubsection{Who can request suspension}

Not applicable.

\subsubsection{Procedure for suspension request}

Not applicable.

\subsubsection{Limits on suspension period}

Not applicable.

\subsection{Certificate status services}

Aside from the published CRL, no on-line certificate status checking
is available.

\subsubsection{Operational characteristics}

No stipulation.

\subsubsection{Service availability}

No stipulation.

\subsubsection{Optional features}

No stipulation.

\subsection{End of subscription}

Subscribers may end their subscription by requesting revocation of
their certificate.

\subsection{Key escrow and recovery}

No key escrow is performed.

\subsubsection{Key escrow and recovery policy and practices}

Not applicable.

\subsubsection{Session key encapsulation and recovery policy and practices}

Not applicable.

\section{FACILITY, MANAGEMENT, AND OPERATIONAL CONTROLS}

\subsection{Physical controls}

\subsubsection{\label{sec:location}Site location and construction}

The M4_CA_NAME servers are located in NCSA's machine room in the 
National Petascale Computing Facility (NPCF)
on the University of Illinois at
Urbana-Champaign campus at 1725 South Oak Street in Champaign, Illinois.

\subsubsection{Physical access}

NCSA occupies all of NPCF.  NPCF entrances and computer rooms
are locked at all times and use and utilize a two factor HID keycard 
system to gain entry.  The building entrances use iris scanners or randomized 
keypads as the second factor and the data center uses iris scanners exclusively 
as the second factor. The physical access control system for the data
 center uses anti-passback features to reduce the likelihood of tailgating.  
Video cameras are located at all entrances, in all the halls and public areas, 
the data center and command center. They are monitored by staff in the
control room, and video is saved for a minimum of 1 month. NPCF is 
not open to the general public and is staffed at all times.

\subsubsection{Power and air conditioning}

No stipulation.

\subsubsection{Water exposures}

No stipulation.

\subsubsection{Fire prevention and protection}

No stipulation.

\subsubsection{Media storage}

No stipulation.

\subsubsection{Waste disposal}

No stipulation.

\subsubsection{\label{sec:offsite}Off-site backup}
Audit logs (see section 5.4) are archived weekly to a secondary storage facility 
in the NCSA Building
on the University of Illinois at Urbana-Champaign campus
at 1205 West Clark Street in Urbana, Illinois.
The NCSA Building is approximately 3 miles away from NPCF,
where the CA is located.

\subsection{\label{sec:procedural-controls}Procedural controls}

All persons with access to the systems hosting the M4_CA_NAME will be
full-time NCSA employees. Personnel will be NCSA Operations staff,
NCSA Security Operations staff, and NCSA System administration staff.

When any person with access to the M4_CA_NAME systems leaves NCSA or
their administrative role, their access will be revoked and any
relevant passwords changed.

NCSA will perform an operational audit of the CA/RA staff at least
once per year.
A list of CA and site identity management personnel will be maintained
and verified at least once per year.

\subsubsection{Trusted roles}

No stipulation.

\subsubsection{Number of persons required per task}

No stipulation.

\subsubsection{Identification and authentication for each role}

No stipulation.

\subsubsection{Roles requiring separation of duties}

No stipulation.

\subsection{Personnel controls}

Operators of the M4_CA_NAME will be qualified system administrators
and operators at NCSA.

\subsubsection{Qualifications, experience, and clearance requirements}

No stipulation.

\subsubsection{Background check procedures}

No stipulation.

\subsubsection{Training requirements}

No stipulation.

\subsubsection{Retraining frequency and requirements}

No stipulation.

\subsubsection{Job rotation frequency and sequence}

No stipulation.

\subsubsection{Sanctions for unauthorized actions}

No stipulation.

\subsubsection{Independent contractor requirements}

No stipulation.

\subsubsection{Documentation supplied to personnel}

No stipulation.

\subsection{Audit logging procedures}

\subsubsection{Types of events recorded}

The following items will be logged and archived:

\begin{itemize}

\item  Certificate requests

\item  Certificate issuance

\item  Certificate revocations

\item  Issued CRLs

\item  Attempted and successful accesses to the systems hosting the NCSA
PKI, and reboots of those systems

\end{itemize}

The NCSA user database maintains contact information for all subscribers.

\subsubsection{Frequency of processing log}

See Section \ref{sec:offsite}.

\subsubsection{Retention period for audit log}

Audit logs are maintain for at least three years.

\subsubsection{Protection of audit log}

Events are recorded in real-time via syslog to the local system
and to NCSA's central syslog collector service, 
which provides an independent, protected log collection point
that is physically and logically separated from CA systems.
Access to the syslog collector service
is restricted to NCSA security operations staff.

\subsubsection{Audit log backup procedures}

See Section \ref{sec:offsite}.

\subsubsection{Audit collection system (internal vs. external)}

Audit logs are stored on the local system,
on NCSA's central syslog collector service,
and in off-site backups (see Section \ref{sec:offsite}).
In all cases the logs are maintained on NCSA systems,
in NCSA buildings, under control of NCSA staff.

\subsubsection{Notification to event-causing subject}

No stipulation.

\subsubsection{Vulnerability assessments}

No stipulation.

\subsection{Records archival}

The CA records and archives all requests for certificates, 
all issued certificates, 
all revocation requests, all issued CRLs,
and the login/logout/reboot of the issuing machine. 
The CA keeps these records for at least three years.
These records will be made available to external auditors in the
course of their work as auditor.

\subsubsection{Types of records archived}

No stipulation.

\subsubsection{Retention period for archive}

No stipulation.

\subsubsection{Protection of archive}

No stipulation.

\subsubsection{Archive backup procedures}

No stipulation.

\subsubsection{Requirements for time-stamping of records}

No stipulation.

\subsubsection{Archive collection system (internal or external)}

No stipulation.

\subsubsection{Procedures to obtain and verify archive information}

No stipulation.

\subsection{Key changeover}

Best effort will be made to notify relying parties of any new public
key for the M4_CA_NAME, and it may then be obtained in the same manner
as the previous M4_CA_NAME certificates.

\subsection{Compromise and disaster recovery}

\subsubsection{Incident and compromise handling procedures}

All incidents will be handled by NCSA Security Operations and Incident
Response as they determine appropriate.

\subsubsection{Computing resources, software, and/or data are corrupted}

No stipulation.

\subsubsection{Entity private key compromise procedures}

Any private key compromise will result in revocation of the associated
certificate.

\subsubsection{Business continuity capabilities after a disaster}

No stipulation.

\subsection{CA or RA termination}

No stipulation.

\section{TECHNICAL SECURITY CONTROLS}

\subsection{Key pair generation and installation}
\subsubsection{Key pair generation}

The M4_CA_NAME does not generate any private keys but its own.

User private keys will be generated by client software on the host
where they will be stored.  They will be stored on non-networked
filesystems.

M4_SLCS_ONLY([
Private keys will normally be stored unencrypted, but the
lifetime of the associated public-key certificate is limited to 
no more than 11 days.
])

M4_CA_ONLY([
System and service administrators will generate private keys for their
services, on the service hosts themselves if at all possible.
])

\subsubsection{Private key delivery to subscriber}

Not necessary.

\subsubsection{Public key delivery to certificate issuer}

Public keys are delivered under
M4_CA_ONLY([Kerberos]) M4_MYPROXY_ONLY([TLS])
authentication and integrity protection.

\subsubsection{CA public key delivery to relying parties}

The public keys of NCSA PKI CAs are available at:
\begin{itemize}
\item M4_CA_URL
\item \url{http://security.teragrid.org/TG-CAs.html}
\item \url{http://vdt.cs.wisc.edu/certificate_authorities.html}
\item \url{https://dist.eugridpma.info/distribution/igtf/}
\item \url{https://www.tacar.org/repos/}
\end{itemize}

\subsubsection{Key sizes}

The CA private key will be 2048 bits in length.
Public RSA keys shorter than 2048 bits will not be signed.

\subsubsection{Public key parameters generation and quality checking}

No stipulation.

\subsubsection{Key usage purposes (as per X.509 v3 key usage field)}

The M4_CA_NAME does not enforce key usage restrictions by any means
beyond the X.509v3 extensions in the certificates it issues.
The certificate extensions are specified in Section \ref{sec:extensions}.

\subsection{Private Key Protection and Cryptographic Module Engineering Controls}
\subsubsection{Cryptographic module standards and controls}

The M4_CA_NAME uses a FIPS 140-2 level 3 Hardware Security Module
for storage of its private key, operated in FIPS 140-2 level 2 mode.

\subsubsection{Private key (n out of m) multi-person control}

No stipulation.

\subsubsection{Private key escrow}

M4_CA_NAME private keys are not escrowed.

\subsubsection{Private key backup}

M4_CA_NAME private key is replicated on two identical cryptographic
modules on two identical hosts in the NCSA machine room to provide for
failure protection.
The replication procedure involves transferring the private
key from one cryptographic module to the other in an encrypted file.
The private key is never exported in plain text form.
If a system hosting one CA should fail, that CA
will temporarily be hosted on the other system until such time as a
replacement system can be arranged.

\subsubsection{Private key archival}

M4_CA_NAME private keys are not archived.

\subsubsection{Private key transfer into or from a cryptographic module}

M4_CA_NAME private keys will initially be replicated on two identical
cryptographic storage modules in a secure manner.
After that point
they will not be exported from the cryptographic modules.
The private key is never exported in plain text form.

\subsubsection{Private key storage on cryptographic module}

M4_CA_NAME private keys are stored on cryptographic modules meeting
FIPS 140-2 level 3, operated in FIPS 140-2 level 2 mode.

\subsubsection{Method of activating private key}

The private key is activated automatically at server startup to allow
immediate M4_CA_NAME operation.

\subsubsection{Method of deactivating private key}

HSM utilities on the server support deactivating the private key.

\subsubsection{Method of destroying private key}

The HSM Security Officer can reinitialize the HSM to destroy the
private key.

\subsubsection{Cryptographic Module Rating}

The hardware security modules meet FIPS 140-2 level 3.

\subsection{Other aspects of key pair management}

\subsubsection{Public key archival}

No stipulation.

\subsubsection{\label{sec:lifetime}Certificate operational periods and key pair usage periods}

The certificate for M4_CA_NAME will have a lifetime of up to 20 years.

M4_CA_ONLY([
NCSA-CA User, Robot, and Service certificates will have a lifetime of not more
than 1 year and 1 month.
])
M4_MYPROXY_ONLY([
M4_CA_NAME certificates will have a lifetime of not more than 11 days.
])

\subsection{Activation data}

The M4_CA_NAME private key is activated automatically at boot time.

\subsubsection{Activation data generation and installation}

Activation data is generated using the operator interface of the
hardware security module and stored on the local CA server filesystem.

\subsubsection{Activation data protection}

Activation data is readable only by the root account on the local
CA server filesystem.

\subsubsection{Other aspects of activation data}

No stipulation.

\subsection{Computer security controls}

The M4_CA_NAME software runs on a dedicated machine, running no other
services than those needed for the CA operations.
The server's network is protected by a dedicated firewall,
and the server itself runs an operating system firewall.
The server is monitored via both host-based and network-based
intrusion detection systems.
Login access is subject to one-time password (OTP)
authentication and permitted only for
administrative personnel that require access to the system for its
operation.

The 
M4_KERBEROS_ONLY([Kerberos]) M4_2FCA_ONLY([one-time password ])
and NCSA user database servers
likewise run on dedicated machines, 
running no other services than those needed for 
M4_KERBEROS_ONLY([Kerberos]) M4_2FCA_ONLY([one-time password ])
NCSA user database operations, 
located in NCSA's machine room in the National Petascale Computing Facility
on the University of Illinois campus.
The servers are monitored via both host-based and network-based
intrusion detection systems, and login access is subject to
one-time password (OTP) authentication.

\subsubsection{Specific computer security technical requirements}

No stipulation.

\subsubsection{Computer security rating}

No stipulation.

\subsection{Life cycle technical controls}

No stipulation.

\subsubsection{System development controls}

No stipulation.

\subsubsection{Security management controls}

No stipulation.

\subsubsection{Life cycle security controls}

No stipulation.

\subsection{Network security controls}

Network security controls (firewalls)
allow inbound connections only for certificate requests
and download of CA certificates and CRLs from hosts outside NCSA's
network.

\subsection{Time-stamping}

No stipulation.

\section{CERTIFICATE, CRL, AND OCSP PROFILES}
\subsection{Certificate profile}

End-entity certificates will be X509v3,
compliant with RFC 5280.

\subsubsection{Version number(s)}

The version number will have a value of 2 indicating a Version 3 certificate.

\subsubsection{\label{sec:extensions}Certificate extensions}

For the CA certificate:

\begin{itemize}

\item keyUsage (critical): Certificate Sign, CRL Sign

\item basicConstraints (critical): CA:true

\item X509v3 Subject Key Identifier 
\item X509v3 Authority Key Identifier 

\end{itemize}

For user M4_CA_ONLY([robot and service]) certificates:

\begin{itemize}

\item Basic Constraints (critical): 
CA:false 

\item X509v3 Subject Key Identifier 
\item X509v3 Authority Key Identifier 

\item X509v3 Certificate Policies:
\begin{itemize}
\item Policy: M4_DOC_OID (this document)

M4_CA_ONLY([
\item Policy: 1.2.840.113612.5.2.2.5 (Member Integrated X.509 Credential Services with Secured Infrastructure)
\item Policy: 1.2.840.113612.5.2.3.3.1 (Policy on Automated Clients or Robot Entities) (for Robot certificates only)
])

M4_MYPROXY_ONLY([
\item Policy: 1.2.840.113612.5.2.2.3 (Short-Lived Credential Services)
])

\item Policy: 1.2.840.113612.5.2.3.2.1 (Identity Vetting by a Trusted Third Party)

\item Policy: 1.2.840.113612.5.2.3.1.2 (Private Key Protection: Key material held in files)

\end{itemize}
\item Key Usage (critical): 
Digital Signature, M4_CA_ONLY([Non Repudiation,]) Key Encipherment, Data Encipherment

M4_CA_ONLY([
\item CRLDistributionPoints:
URI:\url{http://ca.ncsa.uiuc.edu/9b95bbf2.crl}
])
M4_SLCS_ONLY([
\item CRLDistributionPoints:
URI:\url{http://crl.ncsa.illinois.edu/myproxy2013.crl}
])
M4_2FCA_ONLY([
\item CRLDistributionPoints:
URI:\url{http://crl.ncsa.illinois.edu/tfca2013.crl}
])


M4_CA_ONLY([
\item SubjectAltName:
For user and robot certificates, the NCSA email address 
of the subscriber (or robot group) responsible for the certificate.
For service certificates, the 
dnsName of the service and
the NCSA email address of the
responsible system administrator.
])

\end{itemize}

\subsubsection{Algorithm object identifiers}

\begin{itemize}

\item Hash Functions: sha1 1.3.14.3.2.26, sha256 2.16.840.1.101.3.4.2.1, sha384 2.16.840.1.101.3.4.2.2, sha512 2.16.840.1.101.3.4.2.3
\item RSA Encryption: rsaEncryption 1.2.840.113549.1.1.1
\item Signature Algorithms: sha1WithRSAEncryption 1.2.840.113549.1.1.5, sha256WithRSAEncryption 1.2.840.113549.1.1.11, sha384WithRSAEncryption 1.2.840.113549.1.1.12, sha512WithRSAEncryption 1.2.840.113549.1.1.13

\end{itemize}

\subsubsection{Name forms}

M4_CA_ONLY([
All certificates will have one of the following name forms:

\begin{itemize}

\item C=US, O=National Center for Supercomputing Applications, OU=Services,
              CN=M4_QUOTE(svcname)/M4_QUOTE(FQDN)

\item C=US, O=National Center for Supercomputing Applications, OU=Services,
              CN=M4_QUOTE(FQDN)

\item C=US, O=National Center for Supercomputing Applications, OU=People,
      	      CN=M4_QUOTE(user name)

\item C=US, O=National Center for Supercomputing Applications, OU=Robots,
      	      CN=M4_QUOTE(user name), CN=Robot:M4_QUOTE(robot description)

\item C=US, O=National Center for Supercomputing Applications, OU=Robots,
      	      CN=M4_QUOTE(robot email), CN=Robot:M4_QUOTE(robot description)

\item C=US, O=National Center for Supercomputing Applications,
              OU=Certificate Authorities, CN=M4_QUOTE(CA name)

\end{itemize}

Where:

\begin{itemize}

\item  M4_QUOTE(svcname) is ``host'' or an identifier of the service the
  certificate is associated with.

\item M4_QUOTE(FQDN) is the fully qualified domain name of the host on which the
 service the certificate is associated with is homed.

\item  M4_QUOTE(user name) is a unique name for the subscriber, which may have
 appended digits to disambiguate.

\item M4_QUOTE(robot description) is a humanly-recognisable and meaningful description of the Robot.

\item M4_QUOTE(robot email) is an electronic mail address of a persistent group of people responsible for the robot operations.

\item  M4_QUOTE(ca name) is the name of a CA.

\end{itemize}
])
M4_MYPROXY_ONLY([
All certificates will have the following name form:

C=US, O=National Center for Supercomputing Applications, CN=M4_QUOTE(user name)

Where:

 M4_QUOTE(user name) is a unique name for the subscriber, which may have
 appended digits to disambiguate.
])

\subsubsection{Name constraints}

All certificates issued by the NCSA PKI will have names with the
following prefix:

``C=US, O=National Center for Supercomputing Applications''

\subsubsection{Certificate policy object identifier}

M4_DOC_OID

\subsubsection{Usage of Policy Constraints extension}

No stipulation.

\subsubsection{Policy qualifiers syntax and semantics}

No stipulation.

\subsubsection{Processing semantics for the critical Certificate Policies extension}

No stipulation.

\subsection{CRL profile}

\subsubsection{Version number(s)}

The version number will be 1 indicating a version 2 CRL.

\subsubsection{CRL and CRL entry extensions}

No stipulation.

\subsection{OCSP profile}

OCSP is not supported.

\subsubsection{Version number(s)}

Not applicable.

\subsubsection{OCSP extensions}

Not applicable.

\section{COMPLIANCE AUDIT AND OTHER ASSESSMENTS}

M4_CA_NAME will accept being audited by other IGTF accredited CAs to
verify compliance with the rules and procedures specified in this
document.
M4_CA_NAME audit records will be made available to external auditors
in the course of their work as auditor.

\subsection{Frequency or circumstances of assessment}

No stipulation.

\subsection{Identity/qualifications of assessor}

No stipulation.

\subsection{Assessor's relationship to assessed entity}

No stipulation.

\subsection{Topics covered by assessment}

No stipulation.

\subsection{Actions taken as a result of deficiency}

No stipulation.

\subsection{Communication of results}

Audit results will be made available to the TAGPMA upon request.

\section{OTHER BUSINESS AND LEGAL MATTERS}

\subsection{Fees}

No fees will be charged by the M4_CA_NAME nor any refunds given.

\subsubsection{Certificate issuance or renewal fees}

Not applicable.

\subsubsection{Certificate access fees}

Not applicable.

\subsubsection{Revocation or status information access fees}

Not applicable.

\subsubsection{Fees for other services}

Not applicable.

\subsubsection{Refund policy}

Not applicable.

\subsection{Financial responsibility}

No financial responsibility is accepted. 

\subsubsection{Insurance coverage}

No stipulation.

\subsubsection{Other assets}

No stipulation.

\subsubsection{Insurance or warranty coverage for end-entities}

No stipulation.

\subsection{\label{sec:confidentiality}Confidentiality of business information}

Information and data maintained in electronic media on University of Illinois
computer systems are protected by the same laws and policies, and are
subject to the same limitations, as information and communications in
other media. Before storing or sending confidential or personal
information, M4_CA_NAME users should understand that most materials on
University systems are, by definition, public records. As such, they
are subject to laws and policies that may compel the University to
disclose them. The privacy of materials kept in electronic data
storage and electronic mail is neither a right nor is it guaranteed.

\subsubsection{Scope of confidential information}

No stipulation.

\subsubsection{Information not within the scope of confidential information}

No stipulation.

\subsubsection{Responsibility to protect confidential information}

No stipulation.

\subsection{Privacy of personal information}

The privacy of personal information collected by the M4_CA_NAME
is neither a right nor is it guaranteed.
See Section \ref{sec:confidentiality}.

\subsubsection{Privacy plan}

The M4_CA_NAME does not have a specific privacy plan other than
implementing the privacy polices applied to all University of Illinois
computer systems.

\subsubsection{Information treated as private}

No stipulation.

\subsubsection{Information not deemed private}

No stipulation.

\subsubsection{Responsibility to protect private information}

No stipulation.

\subsubsection{Notice and consent to use private information}

No stipulation.

\subsubsection{Disclosure pursuant to judicial or administrative process}

No stipulation.

\subsubsection{Other information disclosure circumstances}

No stipulation.

\subsection{Intellectual property rights}

The M4_CA_NAME asserts no ownership rights in certificates issued to
subscribers. 

Acknowledgment is hereby given to the Fermilab PKI, the DOE Science
Grid and to the CERN Certification Authority for inspiration of parts
of this document.

\subsection{Representations and warranties}

The M4_CA_NAME and its agents make no guarantee about the security or
suitability of a service that is identified by a NCSA certificate. The
M4_CA_NAME is run with a reasonable level of security, but it is
provided on a best effort only basis. It does not warrant its
procedures and it will take no responsibility for problems arising
from its operation, or for the use made of the certificates it
provides.

\subsubsection{CA representations and warranties}

No stipulation.

\subsubsection{RA representations and warranties}

No stipulation.

\subsubsection{Subscriber representations and warranties}

No stipulation.

\subsubsection{Relying party representations and warranties}

No stipulation.

\subsubsection{Representations and warranties of other participants}

No stipulation.

\subsection{Disclaimers of warranties}

The M4_CA_NAME denies any financial or any other kind of responsibility
for damages or impairments resulting from its operation.

\subsection{Limitations of liability}

The M4_CA_NAME is operated substantially in accordance with NCSA's
own risk analysis. No liability, explicit or implicit, is accepted.

\subsection{Indemnities}

No stipulation.

\subsection{Term and termination}
\subsubsection{Term}

This policy becomes effective on its posting to
M4_CA_URL.

\subsubsection{Termination}

This policy may be terminated at any time without warning.

\subsubsection{Effect of termination and survival}

No stipulation.

\subsection{Individual notices and communications with participants}

No stipulation.

\subsection{Amendments}
\subsubsection{Procedure for amendment}

Changes to this document will be presented to the TAGPMA for approval
before taking effect.

Changes will go into effect on the publishing of this document to
M4_CA_URL.

\subsubsection{Notification mechanism and period}

Best effort notification of all relying parties will be made with as
much advance notice as possible.

\subsubsection{Circumstances under which OID must be changed}

Any substantial change of policy will incur a change of OID.

\subsection{Dispute resolution provisions}

NCSA Security Operations will resolve all disputes regarding this
policy.

\subsection{Governing law}

Interpretation of this policy is according to the laws of the United
States of America and the State of Illinois, where the conforming CA
is established.

\subsection{Compliance with applicable law}

No stipulation.

\subsection{Miscellaneous provisions}

No stipulation.

\subsubsection{Entire agreement}

No stipulation.

\subsubsection{Assignment}

No stipulation.

\subsubsection{Severability}

No stipulation.

\subsubsection{Enforcement (attorneys' fees and waiver of rights)}

No stipulation.

\subsubsection{Force Majeure}

No stipulation.

\subsection{Other provisions}

No stipulation.

\section{DOCUMENT SOURCE} 

This source for this document can be found in the CVSROOT of
:pserver:anonymous@cvs.ncsa.uiuc.edu:/CVS/ncsa-ca in the ncsa-cp repository.
It is online at:\\
\url{http://cvs.ncsa.uiuc.edu/viewcvs.cgi/ncsa-cp/?cvsroot=ncsa-ca}.

The CVS version of the source for this document is $Revision$.
Changes in
the version of this source could be due to minor editorial changes and
do not by themselves imply a change of policy.

This document was generated from source on M4_TIMESTAMP.

\section{REVISION HISTORY}

This section captures the revision history for the
Certificate Policy and Practice Statements
of the NCSA PKI.
The Certificate Policy and Practice Statements of the CAs
in the NCSA PKI share a common source and are versioned in a
coordinated fashion, given that changes to policy often
affect all the CAs.
Not all revisions listed below may pertain to this policy.

\begin{description}
\item[1.9] The changes in this version are:
\begin{itemize}
\item Due to CA rekey, CA CNs updated to
"MyProxy CA 2013" and "Two Factor CA 2013"
and CRLDistributionPoints updated.
\item Removed all references to the NCSA GridShib CA (now retired).
\item Removed references to hardware security module vendor.
\item Clarified software/hardware firewalls/tokens.
\item Change contact person from James Barlow to Jim Basney.
\end{itemize}
\item[1.8] The changes in this version are:
\begin{itemize}
\item Introduced the NCSA-2FCA. 
\item In Section \ref{sec:location}, changed location
from the Advanced Computation Building (ACB) 
to the National Petascale Computing Facility (NPCF).
\item Replaced instances of ``no stipulation'' with ``not applicable'' where appropriate.
\end{itemize}
\item[1.7] Added support for Robot certificates in the NCSA-CA according to the ``Guideline on IGTF Approved Robots''.
\item[1.6] Added SHA-256, SHA-384, and SHA-512 in Section 7.1.3 (algorithm object identifiers) to enable move to SHA-2 hash functions per the NIST Policy on Hash Functions.
\item[1.5] The changes in this version are:
\begin{itemize}
\item Updated Section \ref{sec:enrollment} to allow the new capability in the TeraGrid User Portal for new users to choose their initial passwords during initial registration, rather that distributing initial passwords via postal mail.
\item Updated Section \ref{sec:lifetime} to increase the maximum lifetime of certificates issued by the NCSA-CA to 1 year and 1 month and by the NCSA-SLCS and NCSA-GSCA to 11 days.
\item Updated addresses from uiuc.edu to illinois.edu as appropriate. Note that old uiuc.edu addresses will automatically redirect to their new illinois.edu versions. Note also that some services, such as CRL distribution, still use uiuc.edu addresses.
\end{itemize}
\item[1.4] Introduced the GridShib CA (NCSA-GSCA). Updated off-site backup location (moved from the Beckman Institute to the new NCSA Building). Added IGTF policy OIDs. Replaced RFC 3280 reference with RFC 5280. Updated to strictly conform to RFC 3647 outline. GridShib CA approved by TAGPMA May 2009.
\item[1.3] The SLCS CA now issues CRLs.
\item[1.2] Updated password reset process in Section \ref{sec:enrollment} to include password resets via the TeraGrid User Portal for the SLCS CA. Approved by TAGPMA April 2008. Began issuing certificates May 2008.
\item[1.1] NCSA-CA and NCSA-SLCS approved by TAGPMA April 2007 and began issuing certificates May 2007.
\begin{itemize}
\item Documented allocations process with PIs acting as RAs.
\item MICS CA updated to issue user certificates with OU=People.
\item MICS CA issues version 2 CRLs.
\end{itemize}
\item[1.0] Presented at TAGPMA Face-to-Face Meeting in Mexico City (March 2007).
\end{description}

%\bibliography{biblio}

\end{document}
