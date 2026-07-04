Excellent. This document is especially important for Atlas because we will eventually handle **personal fitness data, body measurements, workout history, and AI-generated recommendations**. Users are trusting us with information about their health and habits, so security must be designed in from day one—not added later.

---

# `03-engineering/security.md`

```markdown id="k4v9n2"
# Security Guidelines

> "Security is not a feature.
> It is a fundamental quality of every feature."

---

# Purpose

This document defines the security principles, standards, and best practices for Atlas.

Security must be considered throughout the software development lifecycle, from design and implementation to deployment and maintenance.

The goal is to protect:

- User identities
- Personal fitness data
- Authentication credentials
- System integrity
- Business operations

---

# Security Principles

Atlas follows these principles:

- Secure by default
- Least privilege
- Defense in depth
- Zero trust
- Privacy first
- Fail securely

Security should be proactive rather than reactive.

---

# Authentication

Supported methods:

- Email & Password
- Google Sign-In
- Apple Sign-In

Future:

- Passkeys
- Enterprise SSO

Passwords are never stored in plaintext.

Use industry-standard password hashing algorithms (e.g., Argon2 or bcrypt).

---

# Authorization

Atlas uses Role-Based Access Control (RBAC).

Initial roles:

- User
- Admin

Future roles:

- Coach
- Moderator
- Support
- AI Service Account

Every request must verify that the authenticated user is authorized to perform the requested action.

---

# JWT Security

Access tokens:

- Short-lived
- Signed
- Never stored in logs

Refresh tokens:

- Rotated after use
- Revocable
- Stored securely

Tokens must always be transmitted over HTTPS.

---

# HTTPS

All traffic must use HTTPS.

Plain HTTP is not supported.

Enable HSTS in production.

---

# Password Policy

Minimum requirements:

- Minimum length
- Common password detection
- Secure reset flow

Avoid overly complex composition rules that reduce usability.

---

# Secrets Management

Never hardcode:

- API keys
- Database credentials
- JWT secrets
- Connection strings

Use secure configuration management.

Examples:

- Azure Key Vault
- Environment Variables
- Docker Secrets

Secrets must never be committed to source control.

---

# Data Protection

Protect all personally identifiable information (PII).

Examples:

- Email
- Body measurements
- Workout history
- Progress data

Encrypt sensitive data where appropriate.

---

# Privacy

Users own their data.

Users should be able to:

- Export their data
- Delete their account
- Control profile visibility
- Manage sharing preferences

Atlas should collect only the data necessary to deliver value.

---

# Input Validation

Validate all user input.

Never trust:

- Client applications
- Mobile devices
- Browsers
- Third-party integrations

Validation occurs at:

- API boundary
- Application layer
- Domain layer

---

# SQL Injection

Always use parameterized queries.

Never build SQL through string concatenation.

Entity Framework queries should avoid raw SQL unless absolutely necessary.

---

# Cross-Site Scripting (XSS)

Sanitize user-generated content before rendering.

Examples:

- Community posts
- Comments
- User biographies

Escape output where appropriate.

---

# Cross-Site Request Forgery (CSRF)

For browser-based clients, implement CSRF protection where applicable.

Mobile applications using JWTs are generally not affected in the same way.

---

# File Upload Security

Future uploads (profile photos, videos, attachments) must:

- Validate file type
- Validate file size
- Scan for malware where appropriate
- Store outside the application root

Never trust file extensions alone.

---

# Rate Limiting

Protect endpoints against abuse.

Examples:

- Login
- Registration
- Password reset
- Public APIs

Implement request throttling to reduce brute-force attacks.

---

# Logging & Auditing

Log security-relevant events:

- Login
- Logout
- Failed login attempts
- Password changes
- Role changes
- Account deletion

Logs must never contain:

- Passwords
- Access tokens
- Refresh tokens
- Sensitive personal data

---

# Error Handling

Error messages should be informative without revealing internal implementation details.

Bad:

"Database connection failed at Server X."

Good:

"An unexpected error occurred. Please try again later."

---

# Dependency Management

Keep dependencies up to date.

Monitor for known vulnerabilities.

Review third-party packages before adoption.

Remove unused dependencies.

---

# API Security

Every protected endpoint must:

- Authenticate the caller
- Authorize the action
- Validate input
- Return appropriate HTTP status codes

Use HTTPS exclusively.

---

# Mobile Security

Store tokens securely using platform-provided secure storage.

Avoid storing sensitive information in:

- Local preferences
- Plaintext files
- Logs

Use secure communication for all API calls.

---

# Data Deletion

When a user requests account deletion:

- Remove personal information where legally permitted
- Retain audit records only when required
- Respect applicable privacy regulations

Deletion workflows should be irreversible after confirmation.

---

# Backups

Database backups must:

- Be encrypted
- Be tested regularly
- Have defined retention periods

Access to backups must be restricted.

---

# Monitoring

Monitor for:

- Repeated failed logins
- Suspicious API usage
- Excessive request rates
- Unauthorized access attempts

Alerts should notify engineers of critical events.

---

# Secure Development Practices

Engineers should:

- Review security implications during design
- Validate all external input
- Follow secure coding standards
- Avoid unnecessary permissions
- Keep secrets out of source code

Security reviews are part of the development process.

---

# AI Security (Future)

AI systems must:

- Respect user privacy
- Avoid exposing personal data
- Explain recommendations where possible
- Never make unsafe training recommendations

AI models should use only the data required for the intended purpose.

---

# Third-Party Integrations

Future integrations (wearables, health platforms, AI providers) must:

- Use secure authentication
- Request minimal permissions
- Handle failures gracefully
- Protect user data during transmission

---

# Incident Response

In the event of a security incident:

1. Detect
2. Contain
3. Investigate
4. Remediate
5. Notify affected users if required
6. Document lessons learned

Every incident should result in process improvements.

---

# Security Checklist

Before releasing a feature:

✓ Authentication implemented

✓ Authorization verified

✓ Input validated

✓ Sensitive data protected

✓ Secrets managed securely

✓ Logs reviewed

✓ Error messages sanitized

✓ Dependencies scanned

✓ Security tests passed

---

# Guiding Principle

Users trust Atlas with their fitness journey.

Protecting that trust is as important as protecting their data.
```

---

# Technical Architect Review

This is a solid foundation, but there are a few enhancements I'd make as Atlas matures:

* **Threat Modeling:** Conduct lightweight threat modeling for major features (authentication, AI, community, payments).
* **OWASP ASVS Alignment:** Gradually align security practices with the OWASP Application Security Verification Standard.
* **Automated Security Scans:** Integrate dependency scanning, secret scanning, and static application security testing (SAST) into CI/CD.
* **API Abuse Protection:** Add bot detection and adaptive rate limiting as public usage grows.
* **Data Classification:** Categorize data (public, internal, confidential, sensitive) to guide handling and storage decisions.

---
